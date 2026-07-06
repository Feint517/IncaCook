# TASK-003 — Pickup-vs-delivery order tracking copy

Status: Ready
Priority: P0
Feature spec: `007-order-lifecycle-tracking`
Source: `docs/client-feedback.md` §1.4

## Purpose

Stop showing "Votre commande est en route" for pickup orders. Branch the
tracking title/subtitle on fulfillment type.

## Scope

- `lib/features/orders/presentation/widgets/order_bottom_sheet.dart` — pass
  the order (or `isDelivery`) into the sheet; branch `_StageHeader`.
- `lib/core/constants/text_strings.dart` — add
  `trackingArrivingSubtitlePickup` (+ title variant if needed).
- Confirm exact French wording with the client.

## Acceptance Criteria

- [ ] Delivery orders keep "Votre nourriture est en route." (or current copy).
- [ ] Pickup orders show pickup-appropriate copy
      ("Votre commande vous attend chez le cuisinier." — confirm wording).
- [ ] The choice is driven by `order_detail.dart` `isDelivery` / `isPickup`.

## Technical Notes

- `order_detail.dart` already exposes `isDelivery` / `isPickup`.
- Also confirm with backend that pickup orders follow
  `PREPARED → ARRIVED_PICKUP → DELIVERED` and skip `ON_THE_WAY` /
  `ARRIVED_DROPOFF`; if not, file a separate backend bug.

## Edge Cases

- Mixed fulfillment; order whose fulfillment changes; missing flag.

## Dependencies

- Backend stage-path confirmation (non-blocking for the copy change).

## Verification

- Manual: place a pickup order and a delivery order; confirm distinct copy at
  each stage.
