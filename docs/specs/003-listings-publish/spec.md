# Feature Spec: Listings — Seller Publish

**Feature ID**: `003-listings-publish`
**Created**: 2026-06-30
**Status**: Implemented — compliance gaps remain
**Mobile module**: `lib/features/catalog` (repository), `lib/features/seller`
**Wire contract**: `docs/backend-communication.md` §7, `docs/client-feedback.md` §1.1–§1.2

## User Story

As a seller, I want to publish a dish with photos, price, description, and
allergens so buyers can find and order it.

## Current Behavior

- `ListingsRepository` (`catalog/data/repositories/listings_repository.dart`)
  is **wired**: `getFeed`, `getMyListings`, create, update, `setAvailability`
  against `/v1/listings` + `GET /v1/sellers/me/listings`.
- `add_product_controller.dart` drives the publish form on real data; photo
  upload uses the two-step `UploadsRepository` (purpose `listing_image`).
- The seller dashboard product list reads `ListingsRepository.getMyListings`.

> The "listings not wired / `ListingsRepository` unregistered" note in
> `docs/backend-communication.md` is **stale** — it is wired today.

## Gaps

- **Fait-maison €4.50 hard input block** (`docs/client-feedback.md` §1.2): the
  price field still accepts > €4.50 (only the submit button disables). Clamp
  the field when `isFaitMaison`, with inline error + helper text. Backend
  `INCACOOK_PRICE_CAP_EXCEEDED` remains the belt-and-braces.
- **Mandatory allergen declaration** (§2.2): force an explicit "no allergens"
  confirmation or ≥1 selected; enforce a minimum description length (~40
  chars) so "Tajine" alone is rejected.
- **Seller dashboard KPIs** (`today_snapshot_card.dart`) are hardcoded
  (`'€34.50'`) — not a listings concern but adjacent seller-home work.

## Acceptance Criteria

1. **Given** a fait-maison seller, **When** they type a price > €4.50,
   **Then** the field blocks the value with an inline error (not just a
   disabled submit).
2. **Given** a dish with no declared allergens, **When** publishing, **Then**
   the seller must explicitly confirm "none" or select at least one.
3. **Given** a published listing, **When** the seller opens their dashboard,
   **Then** it loads from `GET /v1/sellers/me/listings` (already true).
4. **Given** a photo, **When** uploaded, **Then** the two-step flow stores
   keys submitted as `imageUrls` on `POST /v1/listings` (already true).

## Minimal Data Contract

`Listing` (+ `ListingAddOn`), images as storage keys, `expiresAt` for
fait-maison time-boxed listings.

## Execution Tasks

- [x] Wire `ListingsRepository` (feed, my-listings, create, availability).
- [x] Two-step photo upload in the publish form.
- [ ] Hard-clamp fait-maison price at €4.50 with inline error + helper text.
- [ ] Enforce allergen confirmation + minimum description length.

## Risks

- Price cap must hold even if the client is patched (server enforces).
- Orphaned uploads if metadata write fails — retry/cleanup on the two-step flow.
