# Feature Spec: Order Lifecycle & Tracking (seller + buyer)

**Feature ID**: `007-order-lifecycle-tracking`
**Created**: 2026-06-30
**Status**: Implemented — copy bug
**Mobile module**: `lib/features/orders`, `lib/features/seller`
**Wire contract**: order lifecycle + QR + tracking endpoints (`/v1/orders/*`,
`/v1/sellers/me/orders/*`), `docs/client-feedback.md` §1.4

## User Story

As a seller I want to accept/prepare/hand off orders; as a buyer I want to
track my order accurately whether it's pickup or delivery.

## Current Behavior

- Seller side (`seller_orders_repository.dart`): list incoming, `cancel`,
  `cannot-provide`, `start-preparing`, `mark-ready`, `pickup-qr`. Screens
  `order_requests`, `seller_home` wired.
- Buyer side: `order_tracking_controller.dart` reads `GET /v1/orders/:id/tracking`;
  `orders_history_screen → dispute_screen` for disputes; QR handoff via
  `qr_flutter` / `mobile_scanner`; live updates via `tracking_socket_client`.
- Full backend lifecycle exists: `OrderStatus` / `DeliveryStatus` enums,
  no-driver-decision, delivery-proof, disputes.

## Gaps (`docs/client-feedback.md` §1.4)

- **Tracking copy bug:** `order_bottom_sheet.dart` uses the same subtitle
  (`trackingArrivingSubtitle`) for pickup and delivery. The data exists
  (`order_detail.dart` exposes `isDelivery` / `isPickup`). Branch the
  title/subtitle:
  - Delivery → "Votre nourriture est en route."
  - Pickup → "Votre commande vous attend chez le cuisinier." *(confirm wording)*
- **Confirm with backend:** pickup orders should follow
  `PREPARED → ARRIVED_PICKUP → DELIVERED` and skip `ON_THE_WAY` /
  `ARRIVED_DROPOFF`. If every order traverses `ON_THE_WAY`, file a backend bug.

## Acceptance Criteria

1. **Given** a pickup order, **When** the buyer tracks it, **Then** the copy
   reflects pickup, never "en route" delivery phrasing.
2. **Given** a seller, **When** they progress an order, **Then**
   `start-preparing` / `mark-ready` / `pickup-qr` advance server state.
3. **Given** a QR handoff, **When** scanned, **Then** the matching
   confirm-pickup / confirm-delivery endpoint fires.

## Minimal Data Contract

`Order`, `OrderStatus`, `Delivery`, `DeliveryStatus`, QR proof payloads,
`OrderDispute`, `OrderIssue`.

## Execution Tasks

- [x] Wire seller lifecycle + buyer tracking + QR + disputes.
- [ ] Branch pickup-vs-delivery tracking title/subtitle; add new strings.
- [ ] Confirm/repair the pickup stage path with backend.

## Risks

- Stage-machine mismatch between client copy and server transitions.
