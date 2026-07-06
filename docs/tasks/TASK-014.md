# TASK-014 — CGU/CGV content rewrite + charter version bump (backend)

Status: Backlog (needs legal input)
Priority: P1
Feature spec: `002-profile-kyc-charters`
Source: `docs/client-feedback.md` §2

## Purpose

The CGU/CGV contain the wrong product name and lack the cuisinier-responsibility
and allergen clauses the client requires. Update the charter content and force
re-acceptance.

## Scope (IncaCook-Server backend)

- Charter/legal-document content (seed/migration + `charters.constants.ts`).
- Replace the wrong product name with **IncaCook**.
- Add required clauses: mandatory allergen declaration, mandatory ingredient
  list, accurate dish description, single-person reasonable portion, and
  sanctions on dispute (suspension/termination + full refund).
- Bump `CGU` / `CGV` (and any affected charter) **version** so existing
  acceptances no longer count and users re-accept on next sign-in.

## Acceptance Criteria

- [ ] CGU/CGV show the correct product name and the new responsibility clauses.
- [ ] `GET /v1/charters/active` returns the bumped versions.
- [ ] Existing users are re-prompted to accept at next sign-in.

## Technical Notes

- Acceptance is keyed `(userId, charter, version)`; bumping the version is what
  forces re-prompt (see `docs/signup-flow.md` §3.10–§3.11).

## Dependencies

- Final legal text from the client/legal team.

## Verification

- Accept current version, bump it, re-launch → user re-prompted.
