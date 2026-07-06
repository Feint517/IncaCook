# TASK-010 — Remove or finish Facebook login button

Status: Ready
Priority: P1
Feature spec: `001-auth-onboarding`
Source: `docs/client-feedback.md` §1.5

## Purpose

The client reports Facebook login is impossible. A `facebook_email_completion`
screen exists but the flow isn't functional. Either remove the button or
complete the flow.

## Scope

- Sign-in / sign-up screens — the Facebook button.
- `authentication/.../facebook_email_completion` screen.
- If wiring: a `POST /v1/auth/facebook` (analogous to `googleSignIn`) — confirm
  backend support exists first.

## Acceptance Criteria

- [ ] Either: the Facebook button is removed everywhere it appears, **or**
      Facebook sign-in completes a real session like Google.
- [ ] No non-functional auth affordance ships.

## Technical Notes

- Recommended default: **remove the button** until backend `auth/facebook`
  exists, to stop advertising a broken feature.
- Backend git mentions "facebook login" work (`a067a42`, `c7f027e fix the
  facebook id bundle`) — verify whether a backend endpoint is actually live
  before choosing to wire vs remove.

## Edge Cases

- Existing email account with the same Facebook email (identity linking).

## Dependencies

- Backend confirmation of `auth/facebook` support (decides remove vs wire).

## Verification

- Manual: the sign-in screen has no dead Facebook button (or it works).
