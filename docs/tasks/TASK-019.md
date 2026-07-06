# TASK-019 — Net-new: featured listings "Mise à la Une"

Status: Backlog (needs scoping)
Priority: P3
Feature spec: `013-net-new-requests`
Source: `docs/client-feedback.md` §5.2

## Purpose

A paid option for sellers to boost a dish to a featured position in the buyer
feed. Maps to the empty backend `boosts` module.

## Scope

- Data model: `is_featured` + `featured_until` on `Listing`.
- Backend: feed ranking honours featured items; endpoint to purchase/toggle.
- Payment: Stripe charge for the boost (one-off or recurring — clarify).
- UI: "Mettre à la Une" CTA in the seller dashboard + badge on the listing card.

## Acceptance Criteria

- [ ] A seller can pay to feature a dish; it ranks ahead in the feed until
      `featured_until`.
- [ ] The card shows a featured badge.

## Open Questions (gather from client first)

- Cost, duration, how many featured at once, audience.

## Dependencies

- Client scoping; Stripe charge flow.

## Verification

- Manual: feature a dish → appears boosted with a badge until expiry.
