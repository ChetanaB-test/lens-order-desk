# QA test plan

The release target is a locally runnable demo that preserves financial inputs, enforces workflow stages, and produces consistent documents from the saved order.

## Acceptance and coverage

| ID | Priority | Check and expected result | Coverage |
| --- | --- | --- | --- |
| QA-01 | P0 | A valid order is persisted at Received. Catalogue name and unit price are copied into the order. The browser shows the saved total. | Model, HTTP, browser |
| QA-02 | P0 | Quantities 1 and 100 are accepted. Missing, 0, 101, fractional and nonnumeric quantities are rejected. An invalid POST responds with 422, preserves valid input and inserts no row. | Model, HTTP |
| QA-03 | P0 | A submitted price, name or initial stage cannot override server values. | HTTP |
| QA-04 | P0 | The operator moves through Received → Packed → Dispatched → Invoiced. A stale or invalid change has no effect, and a repeated action returns 409. | Model, HTTP, browser |
| QA-05 | P0 | Delivery notes are unavailable before packing and contain no pricing. Invoices are available after invoicing and match the order total. | HTTP, browser |
| QA-06 | P1 | Blank names, malformed email addresses, invalid channels and unknown products fail validation. Surrounding whitespace in names and emails is trimmed. | Model |
| QA-07 | P1 | Missing orders and unknown documents return 404. Missing order payload returns 400. | HTTP |
| QA-08 | P1 | At mobile width, the form fits the viewport and all fields have accessible labels. Keyboard navigation and 200% zoom are checked manually. | Browser fit and labels, manual keyboard and zoom |
| QA-09 | P1 | Browser print preview shows the document heading and data without navigation controls. | Browser print CSS, manual print preview |
| QA-10 | P2 | Submitted names with accents and punctuation display consistently across form, detail and documents. | Browser delivery-note check, manual cross-view review |
| QA-11 | P2 | | QA-11 | P2 | Two valid order submissions with identical input create two separate orders with different order numbers. | Manual charter |

## Manual charter

Use an empty development database or identify your new record by order number. Use synthetic data only.

1. At a 375 px viewport and 200% zoom, navigate to New order using Tab and Enter. Confirm visible focus and that every label identifies its input. Use a name such as `Élan & Fils` and `elan@example.test`.
2. Leave a required field blank and submit. Confirm the browser prompts for it. Correct it and submit a trade order for 100 single-vision samples. Check that the total reads **€2,450.00**.
3. Open the same order in two tabs. Mark it packed in the first tab. Click the stale Pack action in the second tab. Confirm the conflict message and that the order stays at Packed.
4. Print-preview the delivery note. Confirm customer, quantity and product are visible and no price or app navigation appears. Complete dispatch and invoicing. Print-preview the invoice and verify the same customer and quantity, unit price **€24.50**, and total **€2,450.00**.
5. Create a second order using identical valid input. Confirm separate order numbers. Record any unexpected behavior as a defect with the environment, data, steps and actual result.

## Release gate

All P0 checks pass, the automated test suites pass, and any manual checks not executed are clearly identified in the execution record. Capture screenshots for UI failures and record response codes and saved order states for workflow failures.
