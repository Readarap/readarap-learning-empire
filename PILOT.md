# Cipher Pilot — school micro-purchase from a cold call

Street Cypher and Private School Cypher still author the method (`CYPHERS.md`).
K12 does not write PROTOCOL.

Exception: a **Cipher Pilot** sold as a micro-purchase after a cold call.
Same player. No standards chip. No auto-renew. No Street wall. No inmate packets.

---

## Why the dollar amount works

As of October 1, 2025 the federal micro-purchase threshold is **$15,000** (2 CFR 200.320 / FAR 2.101). California bid thresholds for goods and services sit far above that (PCC 20111). Districts may self-certify a higher federal cap (often $50,000).

A $49 / $99 / $149 / $490 swipe is always under bid law.

The real blockers are teacher P-card daily caps and pupil-records review (CA Ed Code 49073.1) if the pilot stores student accounts. Price does not waive that. Design the SKU so PII is optional.

---

## Three SKUs (Stripe Checkout mode=payment, not subscription)

| Lookup key | Price | What they get | Student PII |
|---|---|---|---|
| `cipher_pilot_coach` | $49 one-time | Coach only. Name Flo + model one track. 30 days. Zero learner seats. | None |
| `cipher_pilot_room` | $99 one-time | 1 coach + 35 kiosk seats. 30 days. Same cipher player. | First name / nickname only |
| `cipher_pilot_day` | $149 one-time | Live 45-minute cipher. Calendar booking. Paper + beat. No software accounts. | None |

Never put School $8-12, Academy tuition, or Street+ on the cold-call link.
Never auto-subscribe month 2.

After day 30: plan = free_cipher, seat_limit = 1, Name Flo stays open, takes exportable 14 days.

---

## Tenant

- orgs.kind = classroom
- orgs.audience = k12
- subscriptions.status = pilot
- Do not add cipher_pilot to plan_code. It is a time box, not a plan.
- Teacher-before-student on for room pilots.
- Kiosk mode. No student email. No audio of minors in v1.
- No Street wall. No correspondence. No standards field in the player.

---

## Cold call

One sentence: Your class locks their names to a beat this week. Thirty days. Ninety-nine dollars. Their songs, their syllables.

Call first: private schools, charters, microschools, homeschool co-ops, after-school, Title I teachers with PTA money. Public unified districts last.

Convert is human, not automatic. If the loop (calls → paid pilots → Name Flo takes) fails, stay on Street + Academy.
