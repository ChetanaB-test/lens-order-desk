# Test execution record

**23 November 2026** · Ruby 3.4.8, Rails 8.1.4.1, SQLite, Chrome Headless Shell 156 on Linux.

| Check | Result | Evidence |
| --- | --- | --- |
| Database setup | Pass | Orders migration and database constraints verified on a clean database. |
| Model and request suite | Pass | 10 tests, 76 assertions, zero failures or errors. |
| Browser suite | Pass | 2 tests, 19 assertions, zero failures or errors. Covered the order-to-invoice journey plus a narrow-screen trade order and delivery-note print styling. |
| Optional seed | Pass | Two consecutive seed commands left one sample order. |
| Extracted archive and local server | Pass | Fresh extraction passed both suites. The development server served the seeded order list and stylesheet. |
| Manual exploratory charter | Pending | Keyboard-only flow at browser zoom, actual print preview, multi-tab walkthrough and duplicate intake are listed in the [test plan](test-plan.md). The request suite verifies stale stage updates independently. |
| GitHub Actions | Pending | Workflow is included. The GitHub-hosted run starts after the repository is pushed. |

## Environment incident

The workstation Chromium package exited before WebDriver could open a session because the execution environment denied a socket operation during browser startup. The same browser suite passed with Chrome Headless Shell and matching ChromeDriver. No application behavior was involved in the startup failure.

## Release assessment

The automated P0 checks passed for the local demo. The [defect issue template](../.github/ISSUE_TEMPLATE/defect.md) is available for manual findings.

## Windows test run — 23 November 2026

I ran both test suites locally on Windows using Ruby 3.4.13.
The browser tests used Chrome for Testing 156.

| Test suite | Command | Result |
| --- | --- | --- |
| Model and HTTP request tests | `bundle exec ruby bin/rails test` | 10 runs, 76 assertions, 0 failures, 0 errors, 0 skips |
| Browser tests | `bundle exec ruby bin/rails test:system` | 2 runs, 19 assertions, 0 failures, 0 errors, 0 skips |

The browser suite exercised the retail order workflow from creation through
invoicing. It also checked the order form at a narrow window size and the
printed layout of the delivery note.

See the [test plan](test-plan.md) for the scenarios and expected results.

## Windows browser test run

- Environment: Windows, Ruby 3.4.13, Chrome for Testing 156
- Command: `bundle exec ruby bin/rails test:system`
- Result: [Finished in 1.921866s, 5.2033 runs/s, 39.5449 assertions/s.
10 runs, 76 assertions, 0 failures, 0 errors, 0 skips]

## Windows browser test run

- Environment: Windows, Ruby 3.4.13, Chrome for Testing 156
- Command: `bundle exec ruby bin/rails test:system`
- Result: [Finished in 17.104857s, 0.1169 runs/s, 1.1108 assertions/s.
2 runs, 19 assertions, 0 failures, 0 errors, 0 skips]
