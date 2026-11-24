# Test execution record

**23 November 2026**

| Check | Result | Evidence |
| --- | --- | --- |
| Database setup | Pass | Orders migration and database constraints verified on a clean database. |
| Model and request suite | Pass | 10 tests, 76 assertions, zero failures or errors. |
| Browser suite | Pass | 2 tests, 19 assertions, zero failures or errors. Covered the order-to-invoice journey plus a narrow-screen trade order and delivery-note print styling. |
| Optional seed | Pass | Two consecutive seed commands left one sample order. |
| Extracted archive and local server | Pass | Fresh extraction passed both suites. The development server served the seeded order list and stylesheet. |
| Manual exploratory charter | Pass | I verified keyboard navigation and zoom, required-field validation, the order total, stale updates across two tabs, delivery note and invoice print previews, and separate order numbers for two valid submissions. |

## Environment incident

The workstation Chromium package exited before WebDriver could open a session because the execution environment denied a socket operation during browser startup. The same browser suite passed with Chrome Headless Shell and matching ChromeDriver. No application behavior was involved in the startup failure.

## Release assessment

I ran the model, HTTP request, and browser tests on Windows. Both suites passed with zero failures or errors. The manual checks I ran also passed.

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
