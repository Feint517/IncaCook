# TASK-004 — Replace public seller-profile `SellerMockData`

Status: Ready
Priority: P1
Feature spec: `004-discovery-feed-map`

## Purpose

The buyer-facing seller profile shows hardcoded demo data. Wire it to the real
seller so buyers see the actual kitchen they tapped.

## Scope

- `lib/features/client/presentation/screens/client_home.dart:326` — stop
  passing `SellerProfileScreen(profile: SellerMockData.demoSeller())`.
- `SellerProfileScreen` — accept a real seller id / projection and load it
  (from `GET /v1/sellers` detail or the feed row already in hand).
- Reuse `GET /v1/sellers/:sellerId/reviews` for the reviews block.

## Acceptance Criteria

- [ ] Tapping a kitchen opens that seller's real profile (name, category,
      rating, listings, reviews) — never `SellerMockData`.
- [ ] No remaining reference to `SellerMockData` in `client_home.dart`.

## Technical Notes

- `kitchens_repository.dart` already fetches `GET /v1/sellers`; the tapped
  row carries the seller id.

## Edge Cases

- Seller with no listings / no reviews; deleted/suspended seller.

## Dependencies

- Confirm a buyer-facing seller-detail shape (feed row may suffice; otherwise
  a small backend projection).

## Verification

- Manual: tap several kitchens; each shows its own data.
- `grep SellerMockData lib/features/client` returns nothing.
