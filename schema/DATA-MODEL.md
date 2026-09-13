# ReadaRap v1 data model

Source of truth for `orgs`, `tracks`, and `takes`.
Aligns with PROTOCOL.md, PROVISIONS.md, and INMATE-TRACK.md.

**Engine rule:** one schema, three audiences. Every row that can identify a person carries `audience` and `org_id`. K12, Street Cypher, and Academy never share a roster query.

**Scoring pillars (do not change without a protocol revision):**

| Pillar        | Weight |
|---------------|--------|
| Syllable Lock | 0.35   |
| Cadence Key   | 0.30   |
| Rhyme Graph   | 0.25   |
| Fact Check    | 0.10   |

Pass default: weighted score >= 70 AND syllable >= 60. Teacher may override.

**Tiers:** `baby` (~50% swap) → `little` (~75%) → `big` (100%).

**Modules:** `name_flo` → `alphabet_buss_down` → `karaoke`.

---

## Entity map

```
audience ── org (tenant: individual | family | classroom | school | academy | correspondence)
              ├── org_members (role on that tenant)
              ├── classrooms (optional; school/classroom orgs)
              │     └── enrollments
              ├── subscriptions (Stripe)
              └── assignments
                    └── takes → take_bars → scores

profile (person)
  ├── guardian_links (COPPA)
  ├── consent_events
  ├── progress_unlocks
  └── coin_ledger

track (content)
  └── track_bars
```

A **take** is one scored attempt at one track at one swap level. That is the unit of learning evidence.

---

## Tenancy rules

| Org kind        | Typical audience | Seats come from          | Notes |
|-----------------|------------------|--------------------------|-------|
| individual      | k12 or street    | 1 learner                | Parent is Stripe customer if age < 13 |
| family          | k12              | up to 4 learners         | Guardians on the same org |
| classroom       | k12              | teacher + N student seats| Join code; teacher-model gate |
| school          | k12              | many classrooms          | Admin CSV roster |
| academy         | academy          | enrollment records       | Separate legal store in practice (same tables, different audience) |
| correspondence  | academy          | packet roster            | No live mic; paper takes typed in by staff |

Street Cypher individuals must not be selected in any K12 classroom query.

---

## Unlock state machine

Computed from `progress_unlocks` + best passing `takes`, never from a course-percent field.

1. Complete Name Flo (`module = name_flo`, pass) → unlock Alphabet Buss Down.
2. Pass 8+ Alphabet letters → unlock teacher-modeled karaoke at 50%.
3. Teacher `modeled_at` on the assignment (or org-level track model) → student may submit.
4. Student pass at 50 → Baby. 75 → Little. 100 → Big.

Teachers cannot assign a karaoke track they have not passed themselves (`teacher_models`).

---

## What v1 does *not* store

- Raw third-party song files you do not license.
- Precise geolocation of minors.
- Behavioral ad identifiers.
- Inmate and K12 learners in the same org.
- A child as a Stripe customer.
