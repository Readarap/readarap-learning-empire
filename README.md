# Readarap Learning Empire

**Make It Make Sense** — solving America's literacy crisis one lyric, rhythm, and rhyme at a time. Rap is the tool, not the distraction.

This repo is HQ. One shared engine. Three public skins. Same protocol on every domain.

| Skin | Domain | Audience | Rules |
| --- | --- | --- | --- |
| K12 | [readarap.org](https://readarap.org) | Students, families, districts | FERPA, COPPA under 13, clean classroom lyrics, standards language |
| Street Cypher | [readarap.com](https://readarap.com) | Open community cipher | Community code, age-gate, copyright on source tracks |
| Private Academy | [readarapacademy.com](https://readarapacademy.com) | Private school + correspondence | California Private School Affidavit track. Paper-first inmate path lives **only** here |

Sister builds (players and prototypes, not competing products):

- [Readarap-K12](https://github.com/Readarap/Readarap-K12) — beatbox + K12 site heritage
- [readarap-street-cipher](https://github.com/Readarap/readarap-street-cipher) / [readarap-dash-cipher](https://github.com/Readarap/readarap-dash-cipher) — syllable-sync cipher
- [ReadARap-Academy-K-12-Learning](https://github.com/Readarap/ReadARap-Academy-K-12-Learning) — academy learning pack

---

## Shared protocol

Full text: [`PROTOCOL.md`](./PROTOCOL.md)

1. **Name Flo** — break any name into syllable chunks and lock them to a beat. Coach: Miss Little. Unlock: Baby Readarapper (~50% lyric-swap readiness).
2. **Alphabet Buss Down** — phonics on the beat. Letter name, letter sound, CVC / blends. Coach: Dr. Baby. Unlock: Little Readarapper (~75%).
3. **Freestyle Karaoke for Learning** — keep cadence, rhyme scheme, and syllable count. Swap lyrics at 50 / 75 / 100 percent.

Progression:

```
Name Flo → Alphabet Buss Down → teacher-modeled karaoke → student karaoke → 100% Real Rapper
```

A teacher must complete a track before assigning it.

**Tiers:** Baby → Little → Big Readarapper (Mr. Bigg).

**Currency:** RapCoins.

**Scoring pillars**

| Pillar | Weight |
| --- | --- |
| Syllable Lock | 0.35 |
| Cadence Key | 0.30 |
| Rhyme Graph | 0.25 |
| Fact Check | 0.10 |

Pass default: weighted score ≥ 70 **and** syllable ≥ 60. Teacher may override.

Legal skins and the inmate correspondence offer: [`PROVISIONS.md`](./PROVISIONS.md), [`INMATE-TRACK.md`](./INMATE-TRACK.md). Correspondence is Academy-only. Never under `.org` or `.com`.

---

## Repo map

```
.
├── README.md                 ← you are here
├── PROTOCOL.md               ← pedagogy constitution
├── PROVISIONS.md             ← three-domain legal skins
├── INMATE-TRACK.md           ← paper-first adult literacy (Academy only)
├── schema/
│   ├── DATA-MODEL.md         ← orgs / tracks / takes explained
│   └── v1.sql                ← Postgres / Supabase schema
├── billing/
│   ├── STRIPE-PRODUCTS.md    ← dashboard click path
│   └── stripe-products.json  ← lookup keys and amounts
└── content/
    └── tracks/
        └── name-flo.example.json
```

---

## Data model (v1)

Learning evidence is a **take**. Money and seats live on an **org**. Content is a **track**.

```
org (tenant)
  └── members, classrooms, assignments, subscriptions
profile (person)
  └── guardian links, consent, unlocks, RapCoin ledger
track → track_bars
take  → take_bars → score snapshot
```

Tenants: `individual` | `family` | `classroom` | `school` | `academy` | `correspondence`.

Audiences: `k12` | `street` | `academy`. Those three never share a roster query.

Input modes on a take: `typed` | `tap` | `paper` | `audio`. Paper keeps correspondence on the same engine. No mic required for v1.

Apply the schema in a Supabase SQL editor:

```bash
# copy schema/v1.sql into Supabase → SQL → Run
```

Details: [`schema/DATA-MODEL.md`](./schema/DATA-MODEL.md).

---

## Plans (Stripe)

Name Flo stays free. That is the door, not a trial.

| Plan | Lookup key | Price | Seats |
| --- | --- | --- | --- |
| Free Cipher | *(database default)* | $0 | 1 learner, limited pack |
| Readarapper | `readarapper_month` / `_year` | $12 / mo or $96 / yr | 1 |
| Family | `family_month` / `_year` | $20 / mo or $168 / yr | 4 |
| Classroom | `classroom_month` / `_year` | $59 / mo or $490 / yr | 1 teacher + 35 |
| Extra seat | `extra_seat_month` | $2 / seat / mo | +1 |
| School | `school_year_12` / `_10` / `_8` | $12 / $10 / $8 per student / yr | 100 min, invoice |
| Street+ | `street_plus_month` | $8 / mo | 1 adult / age-gated |
| Academy | invoice | custom tuition | separate product |

The Stripe customer is the **parent or school**, never the child.

Checkout always sends `client_reference_id = org_id` plus `metadata.org_id`, `metadata.plan`, `metadata.audience`.

Failed payment: 14-day grace. Portfolio goes read-only. Name Flo stays open.

How to type this into the Stripe dashboard: [`billing/STRIPE-PRODUCTS.md`](./billing/STRIPE-PRODUCTS.md).

---

## Product rules that do not move

1. Rhythm is the pedagogy. If a feature cannot be clapped, it does not ship first.
2. Teacher-before-student. Encoded in `teacher_models`, not in a PDF.
3. Three audiences, three data walls.
4. Buy auth, payments, email, and hosting. Build only the protocol.
5. Do not claim public-school status, CDE endorsement, or CDCR vendor status unless a real contract exists.

---

## Build order

1. Paste `schema/v1.sql` into Supabase.
2. Create Stripe products in **test mode** using the lookup keys above.
3. Ship Name Flo: create an org + profile + take, score taps against syllable count, stamp `module:name_flo`.
4. Alphabet Buss Down + teacher model gate + classroom join codes.
5. Karaoke 50 / 75 / 100 + Checkout for Individual and Classroom.
6. Teacher review queue, CSV export, printable worksheets (Academy twin).

Not in v1: live multiplayer battles, Clever / ClassLink, a custom beat marketplace, native apps.

Suggested app stack when the player graduates out of static HTML: Next.js on Netlify, Supabase Auth + Postgres, Stripe Checkout + Billing, Google Drive as the content inbox.

---

## Contact

Readarap Academy  
1063 Enterprise Ave, San Jacinto, CA 92582  
+1 909-238-9770

© Readarap. Make It Make Sense.
