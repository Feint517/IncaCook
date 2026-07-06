# Feature Spec: Reviews, Messaging, Moderation & Notifications (cross-cutting)

**Feature ID**: `011-reviews-messaging-moderation-notifications`
**Created**: 2026-06-30
**Status**: Implemented — verify + clean up
**Mobile modules**: `lib/features/reviews`, `chat`, `moderation`,
`lib/core/services` (push), `lib/features/supply_catalog`

## User Story

As a user, I want to rate orders, chat with the other party, report abuse,
and receive push notifications — and (as a B2B buyer) browse the supply
catalog — all on real data.

## Current Behavior

- **Reviews** (`reviews_repository.dart`): `POST /v1/orders/:orderId/review`
  (multi-criterion), `GET /v1/sellers/:sellerId/reviews`; `review_sheet.dart`.
- **Messaging** (`conversations_repository.dart`, `messages_repository.dart`):
  `/v1/conversations*`; `conversations_list.dart` + `chat.dart` real,
  realtime via socket. **Orphan:** `chat/.../chat_list.dart` mock (dead).
- **Moderation** (`reports_repository.dart`): `POST /v1/reports`; `report_sheet.dart`.
- **Push** (`push_notification_service.dart`): FCM + `/v1/device-tokens`;
  notification tap opens `OrderTrackingScreen`.
- **Supply catalog** (`supply_catalog_repository.dart`): `/v1/catalog/*`
  (products, checkout, claims, orders).

## Gaps

- Regression-verify each on real data (review submit, conversation realtime,
  report submit, push receipt, catalog checkout).
- Delete the orphan `chat/.../chat_list.dart` mock and the dead
  `lib/features/home/` nav tabs that reference it.
- Push delivery hardening (receipts + dead-token pruning) — optional Phase 2.

## Acceptance Criteria

1. **Given** a delivered order, **When** the buyer submits a review, **Then**
   `POST /v1/orders/:id/review` records it and seller stats update.
2. **Given** two parties, **When** one sends a message, **Then** the other
   receives it in realtime via the socket.
3. **Given** abusive content, **When** a user reports it, **Then**
   `POST /v1/reports` creates a moderation record.
4. **Given** a backgrounded app, **When** an order event fires, **Then** a
   push arrives and tapping it opens tracking.

## Minimal Data Contract

`Review` + `ReviewCriterionRating`, `Conversation` /
`ConversationParticipant` / `Message`, `Report`, `DeviceToken`,
`CatalogProduct` / `CatalogOrder` / `CatalogClaim`.

## Execution Tasks

- [x] Wire reviews, messaging, moderation, push, supply catalog.
- [ ] Regression-verify all five on real data.
- [ ] Delete orphan `chat_list.dart` + `lib/features/home/`.
- [ ] (Phase 2) Push receipts + dead-token pruning.

## Risks

- Realtime reconnect/missed-message handling on flaky networks.
