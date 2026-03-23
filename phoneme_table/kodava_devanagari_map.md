# Kodava Takk — Phoneme Map

Validated by: native speaker
Description: Kodava takk phoneme to Devanagari/Kannada script mapping with pronunciation hints and confidence flags.

Confidence flags:
- ✅ Confident — correct mapping, native speaker validated
- ⚠️ Approximate — no clean equivalent, use hint
- 🔴 Grammar trap — common mistake, model must warn
- 🟡 Stem change or variation — unpredictable, flag for validation

---

## Vowels

| Kodava | Devanagari | Kannada | Sound hint | Confidence | Type | Note |
|--------|-----------|---------|------------|------------|------|------|
| a   | अ  |     | like 'u' in country, bus, plum            | ✅ | vowel_short    | |
| aa  | आ  |     | like 'o' in honest, oddly, commodity      | ✅ | vowel_long     | |
| e   | ए  |     | like 'e' in enter, egg, wedding           | ✅ | vowel_short    | |
| ea  | ए  |     | like 'a' in make, wait — hold slightly longer | ⚠️ | vowel_long | same Devanagari as e, elongated |
| i   | इ  |     | like 'i' in itchy, wit, hidden            | ✅ | vowel_short    | |
| ii  | ई  |     | like 'ee' in seek, teeth, weed            | ✅ | vowel_long     | |
| ê   | ॅ  |     | like 'a' in about, assume — weak schwa    | ⚠️ | vowel_schwa   | no clean Devanagari equivalent |
| êê  | ऍ  |     | like vowel in shirt, her, burn — drop the r | ⚠️ | vowel_mid   | no clean Devanagari equivalent |
| o   | ओ  |     | like 'a' in water (Long Island accent)    | ✅ | vowel_short    | |
| oa  | ओ  | ಓ   | like 'o' in ownership, loan — hold longer | ⚠️ | vowel_long   | single long-O character ಓ — must never be split into two characters |
| u   | उ  |     | like 'oo' in good, put, could             | ✅ | vowel_short    | |
| uu  | ऊ  |     | like 'oo' in oops, pool, crouton          | ✅ | vowel_long     | |
| ai  | ऐ  | ಐ   | like 'i' in kite, my, sky                 | ✅ | vowel_diphthong | diphthong; matra form ೈ — e.g. baip'w → ಬೈಪ್ವ, ainga → ಐಂಗ |
| au  | औ  | ಔ   | like 'ou' in out, cow, how                | ⚠️ | vowel_diphthong | rare in Kodava; matra form ೌ |
| ãã  | आं |     | nasalized aa — like Portuguese coração    | ⚠️ | vowel_nasal    | Devanagari anusvara is approximate |
| ĩĩ  | ईं |     | nasalized ii — say 'keen to' very fast    | ⚠️ | vowel_nasal    | Devanagari anusvara is approximate |

---

## Consonants

| Kodava | Devanagari | Kannada | Sound hint | Confidence | Type | Flag / Note |
|--------|-----------|---------|------------|------------|------|-------------|
| k   | क  |    | like 'c' in cut, cool, thicket             | ✅ | consonant | |
| g   | ग  |    | like 'g' in get, program, yoga             | ✅ | consonant | |
| ch  | च  |    | like 'ch' in chin, kitchen, watch          | ✅ | consonant | |
| j   | ज  |    | like 'j' in jaw, image, pigeon             | ✅ | consonant | |
| th  | त  |    | like 't' in Spanish gato, Hindi taal — dental t | ✅ | consonant | 🔴 NOT थ — dental t only, tongue touches upper teeth |
| dh  | द  |    | like 'd' in Spanish dos, Hindi do — dental d | ✅ | consonant | 🔴 NOT ध — dental d only, tongue touches upper teeth |
| s   | स  |    | like 's' in some, fussy                    | ✅ | consonant | |
| n   | न  |    | like 'n' in net, winner, pin               | ✅ | consonant | |
| l   | ल  |    | like 'l' in long, wilted, coal             | ✅ | consonant | |
| m   | म  |    | like 'm' in mouse, immediately, plum       | ✅ | consonant | |
| b   | ब  |    | like 'b' in boar, bulb                     | ✅ | consonant | |
| p   | प  |    | like 'p' in port, pumpkin                  | ✅ | consonant | |
| h   | ह  |    | like 'h' in house, Ohio                    | ✅ | consonant | |
| r   | र  |    | like American 'water', Spanish toro — flapped r | ✅ | consonant | |
| y   | य  |    | like 'y' in mayo                           | ✅ | consonant | |
| w   | व  |    | like 'w' in water                          | ✅ | consonant | |
| ny  | ञ  | ಞ   | palatal nasal — the 'ny' in 'canyon', 'mañana' | ✅ | consonant_palatal_nasal | digraph like ch/th/dh; geminate use 'nyny'; puunynye (cat ಪೂಞ್ಞೆ), kunji (baby ಕುಂಞಿ), NEVER write as ನ+ಯ |
| ri  | ऋ  | ಋ   | vocalic r — like 'ri' in Sanskrit/Kannada loanwords | ⚠️ | vowel_vocalic_r | rare in native Kodava; krutagnate (gratitude ಕೃತಜ್ಞತೆ); matra form ೃ |

---

## Retroflex Consonants

| Kodava | Devanagari | Kannada | Sound hint | Confidence | Type |
|--------|-----------|---------|------------|------------|------|
| ṭ  | ट  | ಟ   | retroflex t — curl tongue back, underside touches roof | ✅ | retroflex |
| ḍ  | ड  | ಡ   | retroflex d — curl tongue back                         | ✅ | retroflex |
| Ṇ  | ण  | ಣ   | retroflex n — curl tongue back                         | ✅ | retroflex |
| Ḷ  | ळ  | ಳ   | retroflex L — curl tongue back, Marathi has this naturally | ✅ | retroflex |

---

## Geminates

| Kodava | Devanagari | Kannada | Sound hint | Confidence | Type | Note |
|--------|-----------|---------|------------|------------|------|------|
| kk   | क्क  | ಕ್ಕ  | double k — hold twice as long, like 'pick kittens' | ✅ | geminate | |
| gg   | ग्ग  | ಗ್ಗ  | double g — hold twice as long                      | ✅ | geminate | |
| chch | च्च  | ಚ್ಚ  | double ch — hold twice as long                     | ✅ | geminate | |
| jj   | ज्ज  | ಜ್ಜ  | double j — hold twice as long                      | ✅ | geminate | |
| tt   | ट्ट  | ಟ್ಟ  | double retroflex T — hold twice as long            | ✅ | geminate | |
| dd   | ड्ड  | ಡ್ಡ  | double retroflex D — hold twice as long            | ✅ | geminate | |
| DD   | ड्ड  | ಡ್ಡ  | double retroflex D (uppercase variant)             | ✅ | geminate | alternate spelling of dd |
| thth | त्त  | ತ್ತ  | double dental t — hold twice as long               | ✅ | geminate | |
| dhdh | द्द  | ದ್ದ  | double dental d — hold twice as long               | ✅ | geminate | |
| nn   | न्न  | ನ್ನ  | double dental n — hold twice as long               | ✅ | geminate | dental n geminate — distinct from NN (retroflex) |
| NN   | ण्ण  | ಣ್ಣ  | double retroflex N — hold twice as long            | ✅ | geminate | retroflex N geminate: enne→ಎಣ್ಣೆ (oil), kaNNu→ಕಣ್ಣು (eye). NEVER write as nn→ನ್ನ |
| mm   | म्म  | ಮ್ಮ  | double m — hold twice as long                      | ✅ | geminate | |
| ll   | ल्ल  | ಲ್ಲ  | double l — hold twice as long, like 'wall lighting' | ✅ | geminate | |
| LL   | ळ्ळ  | ಳ್ಳ  | double retroflex L — hold twice as long            | ✅ | geminate | |
| rr   | र्र  | ರ್ರ  | double r — hold twice as long                      | ✅ | geminate | |
| ss   | स्स  | ಸ್ಸ  | double s — hold twice as long                      | ✅ | geminate | |
| pp   | प्प  | ಪ್ಪ  | double p — hold twice as long                      | ✅ | geminate | |
| bb   | ब्ब  | ಬ್ಬ  | double b — hold twice as long                      | ✅ | geminate | |
| nyny | ञ्ञ  | ಞ್ಞ  | double palatal nasal — puunynye (cat)              | ✅ | geminate | romanised as 'nyny', not 'nn'; e.g. puunynye → ಪೂಞ್ಞೆ |

---

## Case Suffixes

| Suffix | Devanagari | Kannada | Meaning | Confidence | Flag | Example |
|--------|-----------|---------|---------|------------|------|---------|
| 'k     | क  |    | to / toward (dative case)       | ✅ | | mane'k = to the house |
| 'l     | ल  |    | in / on / at (locative case)     | ✅ | 🟡 noun ending in 'a' changes to 'ath before this suffix | kelsath'l = at work |
| 'nja   | न्ज |   | from (ablative case)             | ⚠️ | | mane'nja = from the house |
| 'ra    | र  |    | of (genitive case)               | ✅ | 🔴 NEVER use 'da for genitive — always 'ra. EXCEPTION: naada (my) is correct | kelsath'ra = of work |
| 'ella  | एल्ल |  | all / everything (of things)     | ⚠️ | | adh'ella = all of those |
| 'ellaar | एल्लार | | all (of people)                 | ⚠️ | | nang'ellaar = all of us |
| 'aa    | आ  |    | question marker                  | ✅ | | mane'aa? = is it the house? |
| 'Nda   | ण्ड |   | of (genitive for pronouns)       | ⚠️ | | āāwuNda = his |

---

## Stem Change Rules

### Nouns ending in 'a'

Nouns ending in **'a'** replace the final 'a' with **'ath'** before any suffix. Confidence: ✅ 🟡

| Noun     | + Suffix | Result        |
|----------|---------|---------------|
| kelsa    | 'l      | kelsath'l     |
| kelsa    | 'ra     | kelsath'ra    |
| thinga   | 'l      | thingath'l    |
| thinga   | 'ra     | thingath'ra   |
| kaala    | 'l      | kaalath'l     |
| kaala    | 'ra     | kaalath'ra    |
| polaaka  | 'l      | polaakath'l   |
| majjana  | 'l      | majjanath'l   |
| nimsha   | 'ra     | nimsath'ra    |
| waara    | 'l      | waarath'l     |
| dhivsa   | 'l      | dhivsath'l    |

### Nouns ending in 'e' or consonant

Nouns ending in **'e'** or a consonant attach suffix directly — no stem change. Confidence: ✅

| Noun  | + Suffix | Result   |
|-------|---------|----------|
| mane  | 'l      | mane'l   |
| mane  | 'ra     | mane'ra  |
| raste | 'l      | raste'l  |
| bayt  | 'l      | bayt'l   |
| uur   | 'ra     | uur'ra   |

---

## Verb Rules

### Nonpast person endings

Applied to verb stem:

| Person | Ending | Example    |
|--------|--------|------------|
| naa    | -ii    | maaduwii   |
| nii    | -iiya  | maaduwiiya |
| āāwu   | -a     | maaduwa    |
| nanga  | -a     | maaduwa    |
| ninga  | -iiraa | maaduwiiraa|
| ainga  | -a     | maaduwa    |

### Past tense — regular verbs (-uw'k)

Drop -uw'k, add -nê. Confidence: ✅ ⚠️ past tense marker ê = schwa sound, like 'a' in about

| Infinitive  | Past      | Meaning       | Note |
|------------|-----------|---------------|------|
| maaduw'k   | maadunê   | did / made    | |
| noatuw'k   | noatunê   | looked        | |
| waruw'k    | warunê    | slept         | |
| pottuw'k   | pottunê   | broke         | |
| kaakuw'k   | kaakunê   | called        | |
| muttuw'k   | muttunê   | touched       | |
| poyyuw'k   | pojjê     | hit           | 🟡 yy→jj stem change |

### Past tense — irregular verbs (-p'k / -b'k)

Stem change + ê. Confidence: ✅ 🟡 stem change is unpredictable — learn individually

| Infinitive  | Past       | Meaning               | Note |
|------------|------------|-----------------------|------|
| bapp'k     | bandhê     | came                  | |
| poap'k     | poanê      | went                  | |
| thimb'k    | thindhê    | ate                   | |
| kêêp'k     | kêêtê      | asked / listened      | |
| kodp'k     | kodthê     | gave                  | |
| êdp'k      | êdthê      | took                  | |
| kudip'k    | kudichê    | drank                 | |
| padip'k    | padichê    | learned               | |
| wolip'k    | wolichê    | washed                | |
| aap'k      | aachê      | happened              | |
| ipp'k      | injê       | was (1st person)      | |
| ipp'k      | injathê    | was (3rd person)      | |
| buduwu'k   | buttandhê  | stopped / left behind | 🟡 also heard as buttuw'k |

### Progressive

Ongoing action. Attach to ipp'k conjugation. 🟡 irregular stems unpredictable

| Infinitive         | Progressive    | Type      | Note |
|-------------------|----------------|-----------|------|
| maaduw'k          | maadiyand      | regular   | |
| noatuw'k          | noatiyand      | regular   | |
| waruw'k           | wariyand       | regular   | |
| pottuw'k          | pottiyand      | regular   | |
| thakk pariyuw'k   | thakk pariyand | regular   | |
| poyyuw'k          | pojjiyand      | regular   | 🟡 yy→jj stem change |
| bapp'k            | bandhand       | irregular | |
| poap'k            | poayand        | irregular | |
| thimb'k           | thindhand      | irregular | |
| kêêp'k            | kêêtiyand      | irregular | |
| kodp'k            | kodthand       | irregular | |
| êdp'k             | êdthand        | irregular | |
| kudip'k           | kudichand      | irregular | |
| padip'k           | padichand      | irregular | |
| pudip'k           | pudichand      | irregular | |
| aap'k             | aayand         | irregular | |
| ipp'k             | injand         | irregular | |
| kaamb'k           | kandhand       | irregular | |
| buduwu'k          | buttiyand      | irregular | |

### Compound verbs

Conjugate the LAST verb only — first part stays unchanged.

| Infinitive           | Past            | Progressive       |
|---------------------|-----------------|-------------------|
| êdthan bapp'k       | êdthan bandhê   | êdthan bandhand   |
| susth aap'k         | susth aachê     | susth aayand      |
| thakk pariyuw'k     | thakk pariyunê  | thakk pariyand    |

### Known textbook errors

| 🔴 Wrong   | ✅ Correct  | Note |
|-----------|-----------|------|
| buttuw'k  | buduwu'k  | 🟡 buttuw'k may also be valid variation |
