# IncaCook Build Task Board

Project: IncaCook Mobile (Flutter) + IncaCook-Server (NestJS)
Current focus: close residual mock leaks + enforce compliance/UX rules to
reach the transaction-loop MVP Definition of Done.
Current milestone: Phase 1 — MVP hardening
Updated: 2026-06-30

> The marketplace loop is already wired (see `docs/FEATURE-ASSESSMENT.md`).
> These tasks finish it: remove named mock leaks, enforce the client's
> blockers (`docs/client-feedback.md` §1–§4), and complete store-side config.

## Columns

Backlog · Ready · In Progress · Review · Blocked · Done

## How to grab a task

Each `TASK-XXX.md` is independently grabbable: it names the exact files,
acceptance criteria, edge cases, and verification. Pick any `Ready` task with
no open dependency. Tasks are grouped by feature spec under `docs/specs/`.

## Tasks

| Task | Title | Feature spec | Status | Priority |
|---|---|---|---|---|
| TASK-001 | Fait-maison €4.50 hard input block | `003-listings-publish` | Ready | P0 |
| TASK-002 | Mandatory allergen declaration + min description | `003-listings-publish` | Ready | P0 |
| TASK-003 | Pickup-vs-delivery order tracking copy | `007-order-lifecycle-tracking` | Ready | P0 |
| TASK-004 | Replace public seller-profile `SellerMockData` | `004-discovery-feed-map` | Ready | P1 |
| TASK-005 | Real seller info/reviews on dish detail | `005-catalog-dish-detail-extras` | Ready | P1 |
| TASK-006 | Wire seller dashboard KPIs (`today_snapshot_card`) | `003-listings-publish` | Ready | P1 |
| TASK-007 | Wire driver stats card + drop `_hydrateMock` filler | `008-deliveries-driver` | Ready | P1 |
| TASK-008 | Replace `OrderMockData` order template | `006-cart-checkout-orders` | Ready | P1 |
| TASK-009 | RevenueCat store/dashboard config + webhook token | `010-seller-subscriptions` | Blocked | P1 |
| TASK-010 | Remove or finish Facebook login button | `001-auth-onboarding` | Ready | P1 |
| TASK-011 | Verify empty-filter shows everything (live feed) | `004-discovery-feed-map` | Ready | P2 |
| TASK-012 | Dead-code cleanup (home/, checkout stub, orphan mocks) | multiple | Ready | P2 |
| TASK-013 | Seller "extras" pantry: backend + UI | `005-catalog-dish-detail-extras` | Backlog | P2 |
| TASK-014 | CGU/CGV content rewrite + charter version bump (backend) | `002-profile-kyc-charters` | Backlog | P1 |
| TASK-015 | Onboarding copy rewrite (value prop) | `012-settings-legal-theming` | Blocked | P2 |
| TASK-016 | Re-enable phone OTP when SMS provider live | `001-auth-onboarding` | Blocked | P2 |
| TASK-017 | Surface €50 wallet withdrawal minimum | `009-wallet-payouts` | Ready | P2 |
| TASK-018 | Net-new: listing countdown timer | `013-net-new-requests` | Backlog | P3 |
| TASK-019 | Net-new: featured listings "Mise à la Une" | `013-net-new-requests` | Backlog | P3 |
| TASK-020 | Net-new scoping: photo enhancement + buyer subs | `013-net-new-requests` | Backlog | P3 |

## Status key

- **Ready** — fully specified, no blocking dependency; grab it.
- **Backlog** — needs a prerequisite (backend change or client input) first.
- **Blocked** — waiting on an external (App Store agreement, SMS provider,
  client-supplied copy).

## Definition of Done (milestone)

`grep -r MockData lib/features` returns only intentionally-dead files (which
TASK-012 deletes); the client blockers in `docs/client-feedback.md` §1 are
all closed; RevenueCat verified on a real device per
`docs/qa/revenuecat-testing.md`.
