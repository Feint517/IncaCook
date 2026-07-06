# TASK-020 — Net-new scoping: photo enhancement + buyer subscriptions

Status: Backlog (scoping only)
Priority: P3
Feature spec: `013-net-new-requests`
Source: `docs/client-feedback.md` §5.1, §5.3, §5.5

## Purpose

Hold a scoping conversation with the client for the underspecified net-new
requests before any build.

## Items to scope

- **Dish-photo enhancement** (§5.1) — auto background-blur/depth. Decide
  client-side overlay vs upload-time backend pipeline.
- **Buyer subscriptions** (§5.3) — Uber-One-style fee reductions vs
  cuisinier-sold meal plans. (Seller subscriptions already exist — spec `010`.)
- **Client-home rubric clarity** (§5.5) — rename/subtitle the three rubrics;
  clarify or drop "partage solitaire". (Also in spec `004` / TASK-004 area.)

## Acceptance Criteria

- [ ] Each item has a client-confirmed scope, data-model decision, and UI spec
      recorded before implementation tickets are split out.

## Dependencies

- Client availability for a scoping call.

## Verification

- A written scope per item appended to `docs/specs/013-net-new-requests/spec.md`.
