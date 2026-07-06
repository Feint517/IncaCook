# TASK-006 — Wire seller dashboard KPIs (`today_snapshot_card`)

Status: Ready
Priority: P1
Feature spec: `003-listings-publish`

## Purpose

The seller home "today snapshot" shows hardcoded numbers (`'€34.50'`). Wire it
to real seller earnings/orders data.

## Scope

- `lib/features/seller/presentation/widgets/today_snapshot_card.dart` — replace
  literals with real values.
- Source from existing data: today's orders via `seller_orders_repository.dart`
  and/or wallet summary (`GET /v1/wallet/me`). If a dedicated seller-stats
  endpoint is needed, coordinate with backend (note: `/v1/admin/dashboard/*`
  is admin-only and not for this card).

## Acceptance Criteria

- [ ] The card shows real today's revenue / order counts for the signed-in
      seller.
- [ ] No hardcoded currency literals remain in the widget.

## Technical Notes

- Prefer composing from data the app already fetches before asking backend for
  a new endpoint.

## Edge Cases

- New seller with zero orders today; timezone boundaries for "today".

## Dependencies

- Possibly a small backend seller-stats endpoint if client-side composition is
  insufficient.

## Verification

- Manual: place a test order; the snapshot reflects it.
