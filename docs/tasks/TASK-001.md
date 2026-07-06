# TASK-001 — Fait-maison €4.50 hard input block

Status: Ready
Priority: P0
Feature spec: `003-listings-publish`
Source: `docs/client-feedback.md` §1.2

## Purpose

For fait-maison sellers, prevent entering a dish price above €4.50 at the
input level — not merely disabling the submit button — and explain the cap.

## Scope

- `lib/features/seller/controllers/add_product_controller.dart` — clamp the
  price input when `isFaitMaison == true`.
- The add-product form widget — inline error / red border at the limit;
  helper text "Plafond fait-maison : 4,50 €".
- Keep the existing `canSubmit` check as belt-and-braces.

## Acceptance Criteria

- [ ] A fait-maison seller cannot commit a price field value > €4.50 (the
      field clamps or rejects the keystroke).
- [ ] An inline error + helper text explains the cap.
- [ ] Non-fait-maison categories are unaffected.
- [ ] Server still rejects an over-cap value with `INCACOOK_PRICE_CAP_EXCEEDED`
      if it ever reaches the API.

## Technical Notes

- Category is on the seller profile (`SellerCategory.FAIT_MAISON`).
- The cap constant is `LE_BON_FAIT_MAISON_PRICE_CAP=4.50` server-side.

## Edge Cases

- Pasting an over-cap value; locale decimal separators (`,` vs `.`);
  switching category after typing a price.

## Dependencies

- None.

## Verification

- Manual: fait-maison seller, attempt €5.00 → blocked with message;
  €4.50 accepted; traiteur unaffected.
- `flutter analyze` clean.
