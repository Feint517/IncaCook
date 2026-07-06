# TASK-008 — Replace `OrderMockData` order template

Status: Ready
Priority: P1
Feature spec: `006-cart-checkout-orders`

## Purpose

The order object is seeded from `OrderMockData.demoOrder()` and hydrated with
real fields, leaving some cart-line / payment-method values as filler. Build
the order entirely from real data.

## Scope

- `lib/features/orders/data/order_mock_data.dart` usages — replace the template
  seed with a real model constructed from the cart + `POST /v1/orders` /
  `GET /v1/orders/:id` responses.
- Remove the mock template once unused.

## Acceptance Criteria

- [ ] No screen constructs an order from `OrderMockData`.
- [ ] All order fields (items, add-ons, totals, fulfillment, payment) come from
      the cart and backend responses.

## Technical Notes

- Shared with TASK-007 (delivery side also references `OrderMockData`). Land a
  single real `Order` mapping both consume.

## Edge Cases

- Orders with extras; pickup vs delivery; partial backend responses.

## Dependencies

- Coordinate field mapping with TASK-007.

## Verification

- Manual: place a real order; every displayed field matches the backend.
- `grep OrderMockData lib` returns nothing live.
