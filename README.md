# Lens Order Desk

**Portfolio project : Chetana Bhosale**

Lens Order Desk is a small Ruby on Rails application for entering and tracking fictional optical orders. It pairs a working order workflow with a test plan, request-level checks and a browser test.

## Run locally

Requires Ruby 3.4, Bundler, and SQLite.

```sh
bundle install
bin/rails db:migrate
bin/rails server -b 127.0.0.1
```

Open [localhost:3000](http://127.0.0.1:3000). Run `bin/rails db:seed` for the optional fictional trade order.

## Try the workflow

1. Create a retail or trade order. Use `Mira Sample` and `mira@example.test` with three contact lens trial packs. The order total is **€38.70**.
2. Mark the order as packed. Open the **delivery note** and check the product and quantity.
3. Mark it as dispatched, then invoiced. Open the **sample invoice** and compare the unit price and total with the order.
4. Return to the order list and confirm the status is **Invoiced**.

The app has two fictional catalogue items. Rails validates submissions and records a snapshot of the catalogue name and unit price. Status changes compare the displayed stage with the database in a single update. The delivery note and invoice are printable HTML pages.

## Run the QA checks

```sh
RAILS_ENV=test bin/rails db:prepare
bin/rails test
bin/rails test:system
```

For the system test, install Chrome or Chromium and a matching ChromeDriver, or let Selenium Manager resolve ChromeDriver. Set `CHROME_BIN` to an absolute executable path if Chrome is installed somewhere Selenium cannot find. GitHub Actions runs both test commands on pushes and pull requests.

- [QA test plan and traceability](docs/test-plan.md)
- [Test execution and defects](docs/test-results.md)

## Demo boundaries

Run this as a local, single-operator demo with fictional records. The workflow has no logins, separate shop accounts, email delivery, tracer hardware, shipping integration, payments, or tax calculation. The invoice is an illustration for testing. A second valid creation request creates a second order. The workflow protects stage changes from duplicate or stale actions.
