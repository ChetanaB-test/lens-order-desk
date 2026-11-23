# Product research and scope

## Why this workflow

FREIRAUMWEB publicly describes operating several shops and maintaining the software behind an optical glass distributor. Its summary covers customer orders, delivery notes, logistics, invoices, and a tracer interface for prescription lenses and contact lenses. Its job page also describes maintaining Rails applications with clear migrations and meaningful tests.

A published Galaxa GmbH testimonial describes a longstanding relationship with FREIRAUMWEB and improvements to order fulfilment. Galaxa's own VISEA page describes a partner shop serving opticians and consumers, with ordering, delivery and billing. These sources corroborate the business scenario. They give no implementation specification.

A contact form alone would be smaller. A single order progressing through a handful of stages is the smallest workflow here that demonstrates the client's business process as well as a practical development and QA split. It fits in one persisted model and creates observable outcomes at every stage.

| Published concept | Portfolio implementation |
| --- | --- |
| B2B and B2C shops | Trade and retail channels in a single operator view |
| Prescription lenses and contact lenses | Two fictional catalogue items, without prescription data |
| Order intake | Validated form, catalogue lookup, quantity and price snapshot |
| Delivery note | Printable document available from packing onwards |
| Logistics | Explicit packing and dispatch stages |
| Invoicing | Printable sample invoice with a unit price and calculated total |
| Administration and sales operations | Order list, detail and current status |
| Tracer integration | Outside portfolio scope. Hardware protocol and client implementation details are private. |

Trustyform's public description reinforces the usefulness of field validation, but this app uses a fixed internal order form. Trustyfile and solidport.de describe different product areas, document transfer and hosting sales respectively. They are outside this order workflow.

The brand, catalogue, screens, stage names, and rules are portfolio design choices. The app is an independent demo based on public workflows. Its terminology and rules are scoped to the demo.

## Options considered

| Candidate | Implementation impact | Decision |
| --- | --- | --- |
| Trustyform-style contact form | A form and validation make the shortest build, with most checks concentrated on input handling. | Use the validation concept at order intake. |
| Optical order desk | One data model covers state changes, price calculation, admin views and document rules. | Build this workflow. |
| Trustyfile-style document collection | Real uploads require access control, storage and file lifecycle handling. | Outside scope. |
| solidport.de-style hosting storefront | Provisioning and billing require service integrations or extensive mocks. | Outside scope. |

The source also mentions tenant separation, external logistics APIs, background processing, and S3-compatible document storage. Channels are labels in the demo, and documents are rendered from existing order data on demand. This keeps local setup to Ruby and SQLite.

## Sources

- [FREIRAUMWEB homepage, Über uns → Erfahrung](https://freiraumweb.de/)
- [Galaxa VISEA contact lenses and partner-shop workflow](https://galaxa-brillenglas.de/visea-kontaktlinsen/)
- [FREIRAUMWEB Rails job page](https://freiraumweb.de/jobs)
- [Trustyform public product description](https://freiraumweb.de/trusty_form)
- [Trustyfile public product description](https://freiraumweb.de/trusty_file)
