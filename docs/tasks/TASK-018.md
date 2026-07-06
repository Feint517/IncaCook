# TASK-018 — Net-new: listing countdown timer

Status: Backlog
Priority: P3
Feature spec: `013-net-new-requests`
Source: `docs/client-feedback.md` §5.4

## Purpose

Surface a visible countdown on fait-maison listings using the existing
`expiresAt`, so buyers see how long a dish is available.

## Scope

- A countdown widget on the listing card + detail driven by `listing.expiresAt`
  ("Disponible encore 2h 14min").
- Auto-hide/refresh the listing when the timer hits 0 (backend already excludes
  expired listings from the feed).
- For permanent-menu items (`expiresAt == null`), render no countdown.

## Acceptance Criteria

- [ ] Time-boxed listings show a live countdown; permanent ones don't.
- [ ] At expiry, the listing disappears/refreshes client-side.

## Dependencies

- None (lowest-effort net-new item; can proceed independently).

## Verification

- Manual: a listing with a near `expiresAt` counts down and hides at 0.
