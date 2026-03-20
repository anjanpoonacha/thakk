# Corpus

This directory is the live data store for the Kodava RAG system ([kodava-rag](https://github.com/anjanpoonacha/kodava-rag)).

`anjanpoonacha/thakk` is the single source of truth for all corpus data. No corpus files live in the application repo.

---

## Directory layout

```
thakk/
├── audio-vocab/
│   ├── *_vocab_table.md          ← vocabulary source (one per session)
│   └── *_transcription.txt       ← raw audio transcriptions
├── phoneme_table/
│   └── kodava_devanagari_map.json ← phoneme → Devanagari mapping
├── kodava_corrections.md          ← grammar corrections & native-speaker verified forms
├── elementary_kodava_FINAL.md     ← primary textbook source
└── corpus/
    ├── sentences.jsonl            ← approved user-submitted sentences (this repo)
    ├── review.jsonl               ← rejected submissions pending manual review
    └── README.md                  ← this file
```

---

## Source types and what they produce

| Source file | Type | Ingester | Corpus collection |
|---|---|---|---|
| `audio-vocab/*_vocab_table.md` | Markdown table | `VocabTableIngester` | `vocabulary.jsonl` |
| `kodava_corrections.md` | Structured markdown | `CorrectionsIngester` | `grammar_rules.jsonl` |
| `phoneme_table/kodava_devanagari_map.json` | JSON map | `PhonemeMapIngester` | `phonemes.jsonl` |
| `corpus/sentences.jsonl` | JSONL (direct) | — | `sentences.jsonl` (read as-is) |

---

## Post-processed entry schema

Every entry in a corpus JSONL file follows the `CorpusEntry` schema:

```json
{
  "id": "7af43df2",            // SHA-256[:8] of type+kodava+english — deterministic, deduplication key
  "type": "vocabulary",        // vocabulary | grammar_rule | phoneme | sentence
  "kodava": "Naa bandi.",      // Romanized Kodava — never Devanagari
  "devanagari": "नान बन्दि.", // Devanagari rendering, empty string if unknown
  "english": "I came.",        // English meaning or description
  "explanation": "naa = I, bandi = came (past of bapp'k)",
  "confidence": "audio_source",// verified | audio_source | textbook | unverified
  "source": "session_11_vocab_table.md",
  "tags": ["lesson:11", "past-tense"]
}
```

**Sentence entries** (from `corpus/sentences.jsonl`) use a simpler shape produced by the feedback endpoint:

```json
{
  "id": "s_1774018047",
  "type": "sentence",
  "query": "how do I say I came",
  "kodava": "Naa bandi.",
  "status": "corrected",
  "source": "ui_feedback"
}
```

---

## Confidence levels

| Value | Meaning |
|---|---|
| `verified` | Native speaker confirmed |
| `audio_source` | Extracted from a Kodava Koota video session |
| `textbook` | From `elementary_kodava_FINAL.md` (may have errors — see corrections) |
| `unverified` | Extrapolated or uncertain |

---

## Adding new vocabulary (contributor workflow)

1. Create a new `audio-vocab/<session_name>_vocab_table.md` with this structure:

   ```markdown
   | English | Kodava Takk | Explanation |
   |---------|-------------|-------------|
   | I went  | Naa poaye.  | naa = I, poaye = went (past of poap'k) |
   ```

2. Run `make corpus` in the `kodava-rag` repo — it will sync this file and rebuild the BM25 index automatically.

---

## Adding grammar corrections

Append a block to `kodava_corrections.md` following the existing `WHAT / CORRECT / WHY / CONFIDENCE` format:

```markdown
- WHAT: incorrect form or phrase
- CORRECT: correct form
- WHY: reason
- CONFIDENCE: certain
```

Sections B, C, D, E group corrections by type (textbook errors, person forms, vocabulary, spelling).

---

## Feedback loop (sentences.jsonl / review.jsonl)

The RAG API writes directly to this repo via the GitHub Contents API:

- `POST /feedback` with `status: approved` or `corrected` → appended to `corpus/sentences.jsonl`
- `POST /feedback` with `status: rejected` → appended to `corpus/review.jsonl` (pending manual review)

To promote a rejected entry: move it from `review.jsonl` to `sentences.jsonl` manually, or re-submit via the API with `status: corrected`.

Entries in `sentences.jsonl` are live in the RAG immediately on the next `make corpus` run (or on next pod startup in Kyma).
