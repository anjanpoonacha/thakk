#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

MODEL="mlx-community/Qwen3.5-4B-OptiQ-4bit"
ADAPTER="adapters/kodava"
MAX_TOKENS=256

SYSTEM_PROMPT="You are a Kodava takk language assistant. You help transliterate Kodava to Marathi Devanagari, conjugate verbs, and identify grammar mistakes. Always flag uncertain sounds with ⚠️, grammar traps with 🔴, and unpredictable stem changes with 🟡."

run_test() {
    local test_num="$1"
    local description="$2"
    local prompt="$3"
    local expected="$4"

    echo "──────────────────────────────────────────────"
    echo "Test $test_num: $description"
    echo "Expected: $expected"
    echo "Model output:"

    full_prompt="<|im_start|>system
${SYSTEM_PROMPT}
<|im_end|>
<|im_start|>user
${prompt}
<|im_end|>
<|im_start|>assistant"

    python3 -m mlx_lm.generate \
        --model "$MODEL" \
        --adapter-path "$ADAPTER" \
        --max-tokens "$MAX_TOKENS" \
        --prompt "$full_prompt"

    echo ""
}

echo "Kodava takk fine-tuned model — test suite"
echo "Model:   $MODEL"
echo "Adapter: $ADAPTER"
echo ""

# Test 1 — basic transliteration
run_test 1 \
    "Basic transliteration: akku → अक्कु ✅" \
    "Transliterate: akku" \
    "अक्कु ✅"

# Test 2 — phrase transliteration with retroflex
run_test 2 \
    "Phrase transliteration with retroflex ḷ: ennane uLLiya niin?" \
    "Transliterate: ennane uLLiya niin?" \
    "एन्नाने उळ्ळिया नीन?"

# Test 3 — grammar correction with 🔴 flag
run_test 3 \
    "Grammar correction: kelsa'da → kelsath'ra 🔴" \
    "Correct this: kelsa'da" \
    "kelsath'ra 🔴"

# Test 4 — verb conjugation
run_test 4 \
    "Past tense conjugation: bapp'k → bandhê (all persons)" \
    "Conjugate: bapp'k past tense" \
    "bandhê (all persons)"

# Test 5 — uncertain vowel transliteration with ⚠️
run_test 5 \
    "Uncertain vowel: êtt → ऍट्ट ⚠️" \
    "Transliterate: êtt" \
    "ऍट्ट ⚠️"

echo "──────────────────────────────────────────────"
echo "All 5 tests complete."
