# This week — wealth + literacy

Do these four things before any new feature.

1. Name Flo that can record a take (ugly is fine).
2. Four Stripe Payment Links (test, then live).
3. Ten names in Drive folder `02_Street_Call_List`.
4. One Cipher Day on the calendar — reconnect Calendar write access, then book Wed 16 Sep 2026, 3:00–3:45pm PT.

Sunday scoreboard automation is already on (`Readarap Sunday scoreboard`, 5pm PT).

Stripe connector in this chat needs a reconnect. Mint the links in the dashboard.

## Stripe click path (20 minutes)

Dashboard → Products → Add product. Then Payment Links.

| Product | Lookup key | Price | Checkout mode | Metadata |
|---|---|---|---|---|
| Cipher Pilot Coach | `cipher_pilot_coach` | $49 | payment (one-time) | `plan=cipher_pilot` `audience=k12` `pilot_days=30` `seats=0` `source=cold_call` |
| Cipher Pilot Room | `cipher_pilot_room` | $99 | payment | same + `seats=35` |
| Cipher Pilot Day | `cipher_pilot_day` | $149 | payment | `plan=cipher_pilot` `audience=k12` `product=day` |
| Street+ | `street_plus_month` | $8 / mo | subscription | `plan=street_plus` `audience=street` |

Receipt line for pilots: `Instructional materials — classroom cipher pilot`.
Never auto-renew a pilot. Never take a child's card.
Do not put Classroom $59 or School $8–12 on the cold-call link.

## Call line

Your class takes a song they love and puts the chapter they hate in the pocket. Thirty days. Ninety-nine dollars.

## Wealth rule

Cash this month is $49 / $99 / $149 / $8. Not district RFPs. Not Roblox. Not School $8–12.
If a week makes money and zero passing takes, ignorance was not solved — record ten Name Flo locks before another feature.
