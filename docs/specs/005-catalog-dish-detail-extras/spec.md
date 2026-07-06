# Feature Spec: Dish Detail & Seller Extras

**Feature ID**: `005-catalog-dish-detail-extras`
**Created**: 2026-06-30
**Status**: Partial
**Mobile module**: `lib/features/catalog`
**Wire contract**: `GET /v1/listings/:id` (+ proposed `/v1/sellers/me/extras`),
`docs/client-feedback.md` §3

## User Story

As a buyer, I want to see a dish's full detail and add only the extras the
cook actually offers (bread, drinks, sauces), so my order reflects what's
really available.

## Current Behavior

- `product_detail.dart` renders the real listing from `GET /v1/listings/:id`.
- **But** seller info + reviews on that screen are filled from
  `seller_mock_data.dart`, and add-ons are demo/hardcoded (`_demoAddOns`).

## Gaps (`docs/client-feedback.md` §3)

- Extras should live on the **seller profile** as a small pantry (a cook who
  has bread today has bread for every dish), not hardcoded per dish.
- Backend: add a `seller_extras` concept + `GET/PUT /v1/sellers/me/extras`;
  include the seller's active extras inline in `GET /v1/listings/:id`.
- Flutter: a "Mes extras" seller section; replace `_demoAddOns` with the
  returned extras; **when the extras list is empty, hide the whole section**.
- Replace the `SellerMockData` seller-info/reviews block with real data
  (`GET /v1/sellers/:id/reviews`, seller projection).

## Acceptance Criteria

1. **Given** a dish, **When** detail opens, **Then** seller info + reviews are
   real, not `SellerMockData`.
2. **Given** a seller who declared extras, **When** a buyer opens any of their
   dishes, **Then** those extras appear as add-ons; **when none declared, no
   extras section renders**.
3. **Given** an extra is added, **When** the buyer orders, **Then** its price
   is included in the order total.

## Minimal Data Contract

`ListingAddOn` / proposed `SellerExtra` (label, price cents, active), plus
the seller projection already in `GET /v1/listings/:id`.

## Execution Tasks

- [ ] Backend: `seller_extras` + `GET/PUT /v1/sellers/me/extras`; inline on listing detail.
- [ ] Flutter: seller "Mes extras" management UI.
- [ ] Replace `_demoAddOns` with real extras; hide section when empty.
- [ ] Replace `SellerMockData` seller info/reviews on the detail screen.

## Risks

- Extras pricing must flow into order totals + commission correctly.
