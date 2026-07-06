# TASK-007 — Wire driver stats card + drop `_hydrateMock` filler

Status: Ready
Priority: P1
Feature spec: `008-deliveries-driver`

## Purpose

Driver-side has two mock leaks: a hardcoded stats card and an incoming-order
controller that overlays real fields on a mock order.

## Scope

- `lib/features/delivery/presentation/widgets/today_stats_card.dart` — replace
  `delivery_driver_mock_data` with real earnings/delivery counts
  (`GET /v1/wallet/me` + completed deliveries).
- `lib/features/delivery/controllers/incoming_order_controller.dart` — remove
  `_hydrateMock()`; populate the order entirely from the backend delivery /
  order payload (no `OrderMockData` filler for cart lines / payment method).

## Acceptance Criteria

- [ ] Driver stats come from real data; `delivery_driver_mock_data` is unused.
- [ ] Incoming-order details (items, totals, payment) are fully real, no mock
      filler.

## Technical Notes

- The available-deliveries feed + claim already return real order context;
  ensure the controller maps all displayed fields from it.

## Edge Cases

- Order with add-ons; absent-recipient / seller-unavailable paths still render
  correct details.

## Dependencies

- Confirm the delivery/available payload includes the line-item + payment
  fields the UI needs; extend backend DTO if missing.

## Verification

- Manual (driver): go online, receive an incoming order, confirm all fields
  are real; stats card reflects completed deliveries.
- `grep delivery_driver_mock_data lib` returns nothing live.
