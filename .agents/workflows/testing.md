---
description: How to write and run tests for PumpWatch
---

# Testing Workflow

This workflow ensures every code change is accompanied by appropriate tests.

## Running Tests

// turbo-all

### Flutter Tests
1. Run all Flutter tests:
```
flutter test
```

### Python Scraper Tests
2. Run the price alert notification tests:
```
cd scraper && python3 -m pytest test_price_alerts.py -v
```

## When to Write Tests

### New Feature
- Add unit tests for any new models, utility functions, or pure business logic.
- If the feature involves filtering, sorting, or data transformation, add tests to the relevant `*_test.dart` file.
- If the feature adds new notification logic, add a scenario to `scraper/test_price_alerts.py`.

### Bug Fix
- First, write a test that reproduces the bug (it should FAIL before the fix).
- Apply the fix.
- Confirm the test now passes.

### Refactor
- Run existing tests before AND after the refactor to confirm no regressions.

## Test Directory Structure

Tests mirror the `lib/` directory structure:

```
test/
├── core/
│   └── utils/
│       ├── date_utils_test.dart
│       ├── distance_utils_test.dart
│       └── price_utils_test.dart
├── data/
│   └── models/
│       ├── fuel_brand_test.dart
│       ├── fuel_price_test.dart
│       ├── fuel_station_test.dart
│       ├── fuel_type_test.dart
│       └── saved_filter_test.dart
├── features/
│   └── settings/
│       └── settings_screen_test.dart
└── providers/
    └── filtered_stations_test.dart

scraper/
└── test_price_alerts.py
```

## What to Test

| Layer | What to Test | Example |
|---|---|---|
| **Models** | `fromJson` / `toJson` round-trips, getters, helper methods | `FuelStation.priceFor()` |
| **Utils** | Pure functions with edge cases | `formatPriceShort(0.0)` |
| **Providers** | Filtering, sorting, state logic (extract as pure functions) | `filteredStationsProvider` logic |
| **Notifications** | Simulated scenarios (percentile, cooldown, quiet hours, radius) | `test_price_alerts.py` |
| **Widgets** | Rendering, user interaction, state updates | `SettingsScreen` |

## Acceptance Criteria

A PR/change is testable when:
- [ ] `flutter test` passes with 0 failures
- [ ] `python3 -m pytest scraper/test_price_alerts.py -v` passes with 0 failures
- [ ] New/changed behaviour has at least one corresponding test
