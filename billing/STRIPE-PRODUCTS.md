# Stripe product list — ReadaRap

Create these in Stripe Dashboard → Products (test mode first).
Copy the resulting `prod_…` and `price_…` ids into `stripe-products.json`.

The **parent or school**, never the child, is the Stripe customer.
Keep Academy tuition as its own product so K12 invoices never mix with private-school tuition.

## Products

### Free Cipher
Name Flo + first 4 Alphabet letters + 1 demo karaoke. Grant in DB as `orgs.plan = free_cipher`. No paid Stripe price required.

### Readarapper (individual)
- Monthly $12 — lookup_key `readarapper_month`
- Yearly $96 — lookup_key `readarapper_year`
- Metadata: plan=readarapper seats=1

### Family
- Monthly $20 — `family_month`
- Yearly $168 — `family_year`
- Metadata: plan=family seats=4

### Classroom
- Monthly $59 — `classroom_month`
- Yearly $490 — `classroom_year`
- Includes 35 seats. Metadata: plan=classroom included_seats=35

### Extra Seat
- $2 / month / unit — `extra_seat_month`

### School License (invoice only)
- $12 / student / year (100–199) — `school_year_12`
- $10 / student / year (200–499) — `school_year_10`
- $8 / student / year (500+) — `school_year_8`
- Collection: send_invoice, net 30

### Street+
- $8 / month — `street_plus_month`
- audience=street

### Academy Enrollment
Invoice only. Separate product. audience=academy

## Checkout rules
1. client_reference_id = org_id
2. metadata.org_id, metadata.plan, metadata.audience
3. customer_email = guardian or teacher, never the learner
4. Webhooks: checkout.session.completed, customer.subscription.*, invoice.paid, invoice.payment_failed
5. Failed payment: 14-day grace. Name Flo stays open.
