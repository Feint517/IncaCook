# Feature Spec: Cart, Checkout & Order Placement

**Feature ID**: `006-cart-checkout-orders`
**Created**: 2026-06-30
**Status**: Implemented — template leak
**Mobile module**: `lib/features/cart`, `lib/features/orders`, `lib/features/payments`
**Wire contract**: `POST /v1/orders` (idempotent), `POST /v1/orders/:id/confirm-payment`

## User Story

As a buyer, I want to add dishes to a cart, choose pickup or delivery, and
pay securely, so I receive my order.

## Current Behavior

- `cart_controller.dart` is a local in-memory cart **by design** (no backend).
- The real purchase chain lives under `orders/`:
  `my_cart → delivery_address / order_summary → payment → payment_processing
  → order_confirmation → order_tracking`.
- `orders_repository.dart` creates the order and confirms payment via Stripe
  (`flutter_stripe`).
- The `lib/features/checkout/` module is a **dead `Placeholder()` stub**,
  referenced nowhere — the orders flow superseded it.

## Gaps

- **Mock template leak:** the order object is seeded from
  `OrderMockData.demoOrder()` and hydrated with real fields; cart line
  specifics / payment-method are left as "visual filler" per code comment.
  Replace with fully real data.
- Delete the dead `checkout` module.

## Acceptance Criteria

1. **Given** a cart with fulfillment choice, **When** the buyer pays, **Then**
   `POST /v1/orders` is sent **with an `Idempotency-Key`** and Stripe confirms.
2. **Given** a created order, **When** payment succeeds, **Then**
   `confirm-payment` advances it and tracking opens.
3. **Given** the order screens, **When** they render, **Then** no field is
   sourced from `OrderMockData`.

## Minimal Data Contract

`Order` + `OrderItem` + `OrderItemAddOn`, `Fulfillment` / `FulfillmentChoice`,
`PaymentStatus`, commission (30%/25%, €1 floor) computed server-side.

## Execution Tasks

- [x] Wire cart → order creation → Stripe payment → confirmation → tracking.
- [ ] Replace the `OrderMockData` template with fully real order data.
- [ ] Delete the dead `lib/features/checkout/` placeholder.
- [ ] Confirm `POST /v1/orders` always carries an idempotency key.

## Risks

- Idempotency on order creation must prevent double charges on retry.
