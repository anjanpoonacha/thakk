#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ── 1. Ensure mlx-lm is installed ────────────────────────────────────────────
if ! python3 -c "import mlx_lm" 2>/dev/null; then
    echo "[install] mlx-lm not found — installing..."
    pip install mlx-lm
else
    echo "[check] mlx-lm already installed"
fi

# ── 2. Check / download base model ───────────────────────────────────────────
MODEL_ID="mlx-community/Qwen3.5-4B-OptiQ-4bit"
MODEL_CACHE_DIR="$HOME/.cache/huggingface/hub/models--mlx-community--Qwen3.5-4B-OptiQ-4bit"

if [ -d "$MODEL_CACHE_DIR" ]; then
    echo "[check] Model already downloaded: $MODEL_CACHE_DIR"
else
    echo "[download] Fetching $MODEL_ID from Hugging Face..."
    python3 -c "
from huggingface_hub import snapshot_download
snapshot_download(repo_id='$MODEL_ID')
print('[download] Model download complete.')
"
fi

# ── 3. Prepare training data ──────────────────────────────────────────────────
echo "[data] Preparing training data..."

python3 - <<'PYEOF'
import json
import random
import os
import yaml
import mlx.core as mx
from mlx_lm import load as mlx_load

random.seed(42)

# Set MLX cache limit to 4GB — prevents buffer pool growing unbounded
# Fixes monotonic memory growth across iterations (MLX issue #742, #828)
mx.metal.set_cache_limit(4 * 1024 * 1024 * 1024)
print("[data] MLX cache limit set to 4GB")

# Load real tokenizer — char-based estimates are wrong for Devanagari
# Devanagari characters tokenize as multiple tokens each
print("[data] Loading tokenizer for accurate token counting...")
_, tokenizer = mlx_load("mlx-community/Qwen3.5-4B-OptiQ-4bit")

SYSTEM_PROMPT = (
    "Kodava takk assistant. Transliterate to Devanagari, conjugate verbs, "
    "identify grammar mistakes. Flag: \u26a0\ufe0f uncertain, \U0001f534 grammar trap, \U0001f7e1 stem change."
)

MAX_SEQ = 512  # all examples fit under 512 with compact JSON + short system prompt

def count_tokens(text: str) -> int:
    return len(tokenizer.encode(text))

def format_example(instruction: str, inp: str, output) -> list[dict]:
    """
    Returns prompt/completion pairs using real tokenizer counts.
    Drops examples where prompt alone >= MAX_SEQ.
    Splits oversized completions by token budget.
    """
    user_content = instruction
    if inp and inp.strip():
        user_content = f"{instruction}\n\n{inp}"

    output_str = (
        json.dumps(output, ensure_ascii=False)
        if not isinstance(output, str)
        else output
    )

    prompt = (
        f"<|im_start|>system\n{SYSTEM_PROMPT}\n<|im_end|>\n"
        f"<|im_start|>user\n{user_content}\n<|im_end|>\n"
        f"<|im_start|>assistant\n"
    )
    completion = output_str + "\n<|im_end|>"

    prompt_tokens = count_tokens(prompt)

    # Drop if prompt alone exceeds budget
    if prompt_tokens >= MAX_SEQ:
        return []

    completion_ids = tokenizer.encode(completion)
    completion_budget = MAX_SEQ - prompt_tokens

    if len(completion_ids) <= completion_budget:
        return [{"prompt": prompt, "completion": completion}]

    # Split by token budget — guaranteed no truncation
    chunks = []
    for i in range(0, len(completion_ids), completion_budget):
        chunk_text = tokenizer.decode(completion_ids[i:i + completion_budget])
        chunks.append({"prompt": prompt, "completion": chunk_text})
    return chunks

    examples = []
    for i, chunk in enumerate(chunks):
        part_prompt = (
            f"<|im_start|>system\n{SYSTEM_PROMPT}\n<|im_end|>\n"
            f"<|im_start|>user\n{user_content} (part {i+1}/{len(chunks)})\n<|im_end|>\n"
            f"<|im_start|>assistant\n"
        )
        examples.append({
            "prompt": part_prompt,
            "completion": chunk + "\n<|im_end|>"
        })
    return examples

with open("training_config/dataset_weights.yaml") as f:
    weights_cfg = yaml.safe_load(f)

all_examples = []
dropped = 0

for dataset_cfg in weights_cfg["datasets"]:
    path = dataset_cfg["path"]
    weight = dataset_cfg["weight"]

    if not os.path.exists(path):
        print(f"[warn] Dataset not found, skipping: {path}")
        continue

    with open(path, encoding="utf-8") as f:
        if path.endswith(".jsonl"):
            records = [json.loads(line) for line in f if line.strip()]
        else:
            records = json.load(f)

    print(f"[data] Loaded {len(records)} records from {path} (weight={weight})")

    formatted = []
    for r in records:
        examples = format_example(r["instruction"], r.get("input", ""), r["output"])
        if not examples:
            dropped += 1
        formatted.extend(examples)

    # Integer replication only — keeps dataset small and RAM usage low
    expanded = formatted * int(weight)
    all_examples.extend(expanded)

if not all_examples:
    raise RuntimeError("No training examples found. Check training_data/ JSON files exist.")

if dropped > 0:
    print(f"[data] Dropped {dropped} oversized examples (prompt >= {MAX_SEQ} tokens)")

random.shuffle(all_examples)

# Hard-cap dataset to what training actually needs
# 1000 iters × batch_size=1 = 1000 examples. Keep 1500 for splits + headroom.
MAX_EXAMPLES = 1500
if len(all_examples) > MAX_EXAMPLES:
    print(f"[data] Capping dataset: {len(all_examples)} → {MAX_EXAMPLES} examples")
    all_examples = all_examples[:MAX_EXAMPLES]

token_counts = [
    count_tokens(e["prompt"] + e["completion"])
    for e in all_examples
]
print(f"[data] Token stats — max: {max(token_counts)}, avg: {sum(token_counts)//len(token_counts)}, over_{MAX_SEQ}: {sum(1 for t in token_counts if t > MAX_SEQ)}")

n = len(all_examples)
train_end = int(n * 0.8)
valid_end = int(n * 0.9)

splits = {
    "train": all_examples[:train_end],
    "valid": all_examples[train_end:valid_end],
    "test":  all_examples[valid_end:],
}

os.makedirs("data", exist_ok=True)

for split_name, examples in splits.items():
    out_path = f"data/{split_name}.jsonl"
    with open(out_path, "w", encoding="utf-8") as f:
        for ex in examples:
            f.write(json.dumps(ex, ensure_ascii=False) + "\n")
    print(f"[data] Wrote {len(examples)} examples to {out_path}")

print(f"[data] Total: {n} — train={train_end}, valid={valid_end - train_end}, test={n - valid_end}")
PYEOF

# ── 4. Run QLoRA fine-tuning ──────────────────────────────────────────────────
echo "[train] Starting MLX QLoRA fine-tuning..."

mkdir -p adapters/kodava

python3 -m mlx_lm lora \
    --config training_config/qlora_config.yaml \
    --train \
    --data data \
    --mask-prompt

# ── 5. Done ───────────────────────────────────────────────────────────────────
echo ""
echo "Training complete."
echo "Adapter saved to: $(pwd)/adapters/kodava"
echo ""
echo "To run inference:"
echo "  python3 -m mlx_lm.generate --model mlx-community/Qwen3.5-4B-OptiQ-4bit \\"
echo "      --adapter-path adapters/kodava --prompt 'Transliterate: akku'"
