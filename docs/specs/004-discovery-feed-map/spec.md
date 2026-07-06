# Feature Spec: Discovery — Buyer Feed, Kitchens & Map

**Feature ID**: `004-discovery-feed-map`
**Created**: 2026-06-30
**Status**: Implemented — one mock leak
**Mobile module**: `lib/features/client`, `lib/features/catalog`, `lib/features/map`
**Wire contract**: `GET /v1/listings`, `GET /v1/sellers`

## User Story

As a buyer, I want to discover nearby dishes and kitchens — in a list and on
a map — filtered by cuisine and dietary preference, so I can find affordable
home-made food close to me.

## Current Behavior

- `client_home.dart` renders the buyer feed from `ListingsRepository.getFeed`
  plus `kitchens_repository.dart` (`GET /v1/sellers`).
- `filter_controller.dart` applies cuisine/dietary filters; empty filter
  returns the full source.
- `map_controller.dart` plots listings from `ListingsRepository().getFeed`
  on Mapbox (PostGIS radius backend). `map_mock_data.dart` is now **dead**.

## Gaps

- **Mock leak:** tapping a kitchen opens
  `SellerProfileScreen(profile: SellerMockData.demoSeller())`
  (`client_home.dart:326`) — the public seller-profile view shows hardcoded
  demo data instead of the real seller. Needs a buyer-facing seller endpoint
  (e.g. from `GET /v1/sellers` detail) wired into that screen.
- **Verify** empty-filter behaviour end-to-end on the live feed
  (`docs/client-feedback.md` §1.3): absent/empty filter params must mean "no
  filter", not "narrow to empty".
- **Rubric clarity** (§5.5): the three client-home rubrics (incl. "partage
  solitaire") confuse the client — rename or add subtitles.

## Acceptance Criteria

1. **Given** the buyer home, **When** it loads, **Then** dishes + kitchens
   come from `/v1/listings` and `/v1/sellers` (already true).
2. **Given** a kitchen tap, **When** the seller profile opens, **Then** it
   shows the **real** seller, not `SellerMockData`.
3. **Given** no selected cuisine/diet, **When** the feed renders, **Then**
   all eligible dishes show.

## Minimal Data Contract

`Listing` feed rows (cursor pagination), `SellerProfile` public projection
(display name, category, rating, location).

## Execution Tasks

- [x] Wire buyer feed + kitchens + map to real endpoints.
- [ ] Replace `SellerMockData.demoSeller()` in the public seller profile.
- [ ] Verify empty-filter "show everything" on the live feed.
- [ ] Rename / subtitle the client-home rubrics with client.
- [ ] Delete dead `map/data/map_mock_data.dart` and `client_mock_data.dart`.

## Risks

- PostGIS radius performance on the feed under load.
