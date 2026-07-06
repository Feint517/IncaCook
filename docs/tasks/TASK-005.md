# TASK-005 — Real seller info/reviews on dish detail

Status: Ready
Priority: P1
Feature spec: `005-catalog-dish-detail-extras`

## Purpose

`product_detail.dart` renders the real listing but pulls seller info + reviews
from `seller_mock_data.dart`. Replace with real data.

## Scope

- `lib/features/catalog/presentation/screens/product_detail.dart` — remove the
  `seller_mock_data` import; source seller info from the listing's inline
  seller projection (`GET /v1/listings/:id`) and reviews from
  `GET /v1/sellers/:sellerId/reviews`.

## Acceptance Criteria

- [ ] Dish detail shows the real seller and real reviews.
- [ ] No reference to `seller_mock_data` remains in `product_detail.dart`.

## Technical Notes

- The extras section on this screen is handled separately in TASK-013
  (needs the backend extras endpoint); this task is seller-info/reviews only.

## Edge Cases

- Listing whose seller has zero reviews; long bios.

## Dependencies

- None for seller info/reviews (endpoints exist). Extras → TASK-013.

## Verification

- Manual: open several dishes; seller + reviews match the real seller.
