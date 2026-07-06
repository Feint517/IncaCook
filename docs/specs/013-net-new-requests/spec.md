# Feature Spec: Net-New Client Requests (Phase 3)

**Feature ID**: `013-net-new-requests`
**Created**: 2026-06-30
**Status**: Todo — needs scoping with client
**Source**: `docs/client-feedback.md` §5

## Summary

Net-new product work requested by the client after a hands-on review. Each
needs a scoping conversation before build; none is in the MVP. Backend
placeholder modules `boosts`, `geo`, `search` exist but have no controllers.

## Items

### 13.1 Dish-photo enhancement (§5.1)
> "Amélioration de photo des plats (flou arrière…)"

Auto background-blur / depth so amateur photos look professional. Options:
client-side overlay (cheap) vs upload-time backend pipeline (better). Confirm
scope.

### 13.2 Featured listings — "Mise à la Une" (§5.2)
Paid boost to feature a dish in the feed. Needs: `is_featured` +
`featured_until` on `Listing`; feed ranking honours it; Stripe charge; seller
CTA + card badge. Maps to the empty backend `boosts` module. Gather pricing,
duration, max featured, audience.

### 13.3 Subscriptions — buyer side (§5.3)
Seller subscriptions already exist (spec `010`). The client's open ask is a
**buyer** subscription (Uber-One style: reduced delivery fees, exclusive
access) or a cuisinier-sold meal-plan. Scope before any data-model work.

### 13.4 Listings with a countdown timer (§5.4)
Fait-maison listings already carry `expiresAt`. Surface a visible countdown on
the card/detail ("Disponible encore 2h 14min"); auto-hide at 0. Backend
already excludes expired listings from the feed. Small, mostly client-side.

### 13.5 Client-home rubric clarity (§5.5)
Three rubrics ("plats près de toi", "cuisine près de toi", "partage
solitaire") confuse the client. Rename or subtitle; clarify or drop "partage
solitaire". (Also referenced in spec `004`.)

## Acceptance Criteria (per item, once scoped)

- Each item has a client-confirmed scope, a data-model decision, and a UI spec
  before implementation starts.

## Execution Tasks

- [ ] Scoping call: confirm 13.1–13.5 scope, pricing, and priority.
- [ ] 13.4 countdown timer (lowest-effort; can proceed independently).
- [ ] 13.2 featured listings (boosts module + Stripe + ranking) after scoping.
- [ ] 13.1 / 13.3 after scoping.

## Risks

- Building before scoping wastes effort; "partage solitaire" may reference an
  unbuilt feature.
