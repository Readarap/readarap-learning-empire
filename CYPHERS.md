# Private School Cypher + Street Cypher

ReadaRap is a **method**, not a genre.

Lock syllables to a beat. Keep cadence, rhyme scheme, and syllable count. Swap lyrics until the bar is yours. That is the movement. K12 vendor provisions (standards chips, district DPA, educational-rap catalogs, quiz loops) change what you are allowed to rap and how you score it. That is how a method becomes a new genre.

**Authors of the method:** Street Cypher (`readarap.com`) and Private School Cypher (`readarapacademy.com`).

**Later export, not the source:** K12 (`readarap.org`). Parked. Same engine if a district ever pays. Does not write PROTOCOL.

---

## One engine, two rooms

Same three modules. Same scores. Same tiers. Different room rules.

```
Name Flo → Alphabet Buss Down → Freestyle Karaoke 50 / 75 / 100
Baby → Little → Big Readarapper
Syllable 0.35 · Cadence 0.30 · Rhyme 0.25 · Fact 0.10
RapCoins
```

| | Street Cypher | Private School Cypher |
|---|---|---|
| Domain | readarap.com | readarapacademy.com |
| Audience | `street` | `academy` |
| Room | Drop-in cipher | Enrolled cipher |
| Feel | Wild N Out energy, Mavis underneath | Same player. Records in the back, not on the bar |
| Teacher-before-student | Off | On — coach models the track |
| Public wall / battles | 18+ only | Off |
| Under-13 accounts | None | Parent creates account, child PIN, no public profile |
| Catalog | Favorite-song swap + original beds | Same player. Young cohorts can use a G pack without defining the art |
| Paper twin | No | Yes — same JSON prints a worksheet |
| Correspondence / inmate | Never | Academy only |
| Money | Free Cipher + Street+ $8/mo | Custom tuition invoice. Not Classroom $59 |

---

## Street Cypher — readarap.com

**Homepage copy:** Lock your name. Swap your song.

### Loop (v1)

1. Age-gate. Default 18+. 13–17 need a guardian as the account owner. Under 13 do not live here.
2. Name Flo on *your* name in three minutes.
3. Pick an original bed or paste clean-enough lyrics you have the right to use.
4. Blank 50, 75, or 100 percent of the bars.
5. Type or tap the swap. Hear lock or miss.
6. RapCoins. Street+ unlocks the full library and the public wall.

No lesson object. No standards chip. No for-teachers nav. No roster CSV.

### What Street is not

- Not school.
- Not a compulsory-attendance exemption.
- Not a ripped MP3 library.
- Not a multiple-choice literacy quiz (the dash-cipher prototype is energy reference only).

### Billing

- `free_cipher` — door stays open.
- `street_plus` / `street_plus_month` — $8.
- Checkout `audience=street`. Webhook rejects any other audience.
- Org kind: `individual` only in v1.
- Forbidden on this domain: Classroom, School, Family, Readarapper, Academy invoice.

---

## Private School Cypher — readarapacademy.com

**Homepage copy:** Same cipher. Enrolled. Records in the back.

This is a school **you operate** (California Private School Affidavit, EC 33190 / 48222), not a vendor selling into someone else's classroom. That is why K12 provisions feel like they rewrite the music: they are vendor provisions.

PSA is registration. It is not accreditation, not CDE endorsement, not ADA funding, not a public school.

### Learner sees

The same cipher player as Street. Next bar. Coach who already modeled the track. Baby / Little / Big stamp. Portfolio of takes.

### Back office sees (not the player)

- Cohort roster and attendance
- Course of study = PROTOCOL, written once a year for the affidavit
- Pupil records and a custodian of records
- Printable 50 / 75 / 100 sheets from the same track JSON
- Correspondence packet queue

Teacher-before-student stays. That is school, not district theater.

### What does not appear in the learner UI

NGSS codes. Phonics-program branding. FERPA vendor copy. District DPA. Educational rap as a genre label.

COPPA still applies if you collect from under-13 online. Minimum that does not change the bar: parent creates the account, child uses a PIN, no public profile, no ads.

### Billing

- Academy invoice. Custom tuition. No public lookup key.
- Seats = enrolled pupils. Coach does not consume a seat.
- Do not reuse Classroom $59 or School $8–12. Different legal product.
- Family $20 is a consumer K12/homeschool SKU. An academy family of four is invoice seats, not that plan.

### Correspondence

Paper-first. Adult learners. Facility education approval. `input_mode = paper`. Separate roster from day-school pupils. Never on `.com` or `.org`. Honest limit: literacy correspondence attached to a private-school filing, not a CDCR contract and not a diploma from the affidavit alone.

---

## Genre rule

If a provision changes the bar — what you can rap, how you score, whether you clap first — it belongs only on `readarap.org`, or it does not ship.

Refuse on both cyphers:

- Standards picker in the player
- Clever / ClassLink
- District DPA checkout
- Classroom price as Academy tuition
- Street+ sold on `.org` or `.academy`
- Inmate packets on `.com`
- A ratings board that turns Street into radio-edit school rap
- Renaming 50 / 75 / 100 to grade-level bands
- Writing original literacy songs as the product instead of swapping songs people already love
- Multiple-choice vocabulary as the core loop

Keep (these are not K12):

- Name Flo first
- Four-pillar score
- Age honesty
- Copyright on source tracks
- Parent as Stripe customer when a minor pays
- PSA honesty
- No public-school or CDCR-vendor claims

---

## K12 parked

`readarap.org` and the Classroom / School / Family / Readarapper Stripe SKUs stay in the catalog for a later constrained export. They do not author PROTOCOL. They do not appear in Street or Academy checkout.

---

## Build order (these two only)

1. Street: Name Flo + lyric-swap editor (typed + tap). Kill the quiz as the core loop.
2. Wrap that same player in an Academy cohort + coach model gate.
3. Print 50 / 75 / 100 from the same track JSON (correspondence twin).
4. Street+ Checkout. Academy invoice. Do not touch `.org`.
