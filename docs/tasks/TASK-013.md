# TASK-013 — Seller "extras" pantry: backend + UI

Status: Backlog (backend first)
Priority: P2
Feature spec: `005-catalog-dish-detail-extras`
Source: `docs/client-feedback.md` §3

## Purpose

Replace hardcoded dish add-ons (`_demoAddOns`) with real seller-declared extras
(bread, drinks, sauces) that live on the seller profile and appear on every
listing — only when the seller actually offers them.

## Scope

- Backend: `seller_extras` table + `GET/PUT /v1/sellers/me/extras`; include the
  seller's active extras inline in `GET /v1/listings/:id`.
- Flutter: "Mes extras" seller management UI; `SellersRepository.getMyExtras()` /
  `putMyExtras()`; replace `_demoAddOns` in `product_detail.dart`; **hide the
  extras section entirely when the list is empty**.

## Acceptance Criteria

- [ ] A seller can declare/edit extras once; they appear on all their listings.
- [ ] When no extras are declared, no extras section renders on dish detail.
- [ ] Added extras are included in the order total + commission.

## Dependencies

- Backend `seller_extras` endpoint must land first.

## Verification

- Manual: seller declares "Pain +0,50 €" → appears on their dishes; remove all
  → section disappears; order total includes the extra.
