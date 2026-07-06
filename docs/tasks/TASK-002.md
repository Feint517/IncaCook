# TASK-002 — Mandatory allergen declaration + minimum description

Status: Ready
Priority: P0
Feature spec: `003-listings-publish`
Source: `docs/client-feedback.md` §2.2

## Purpose

Close the loophole where an empty allergen list is silently treated as "none
declared", and reject placeholder descriptions, to protect the platform.

## Scope

- Add-product form (`add_product_sheet.dart` + `add_product_controller.dart`).
- Require either ≥1 allergen selected **or** an explicit "Aucun allergène"
  confirmation checkbox before publish.
- Require a minimum description length (~40 chars).
- Optional: `otherAllergens` free-text for items outside the EU-14.

## Acceptance Criteria

- [ ] Publish is blocked until the seller selects ≥1 allergen or explicitly
      confirms "no allergens".
- [ ] A description shorter than the minimum is rejected with inline copy.
- [ ] The explicit "no allergens" confirmation is sent distinctly from an
      unanswered empty list.

## Technical Notes

- Allergen enum = EU-14 French names (see `docs/signup-flow.md` §3.13).
- Coordinate with backend if a new branchable error code is needed for
  "missing allergen confirmation".

## Edge Cases

- Seller selects allergens then ticks "none"; very long descriptions;
  non-Latin characters.

## Dependencies

- Backend: confirm/extend `INCACOOK_*` codes if a dedicated error is wanted.

## Verification

- Manual: publish with empty allergens (blocked), with "none" confirmed
  (allowed), with a 5-char description (blocked).
- `flutter analyze` clean.
