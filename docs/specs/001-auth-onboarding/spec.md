# Feature Spec: Authentication & Signup Wizard

**Feature ID**: `001-auth-onboarding`
**Created**: 2026-06-30
**Status**: Implemented (hardening)
**Mobile module**: `lib/features/authentication`, `lib/features/onboarding`
**Wire contract**: `docs/backend-communication.md` §4–§6, `docs/signup-flow.md`

## User Story

As a new user, I want to sign up as a buyer, seller, or driver — verifying
my account and completing a role-specific profile — so I can transact on
IncaCook.

## Current Behavior

- Email/password and native Google sign-in are wired (`AuthRepository`).
  Tokens persist in `flutter_secure_storage`; `AuthInterceptor` attaches the
  bearer and performs single-flight 401→refresh→replay.
- The signup wizard (`SignupFlowController`) is a dynamic `PageView` with two
  commit gates: **Gate 1** `POST /v1/auth/signup` (issues JWT), **Gate 2**
  `POST /v1/users` (commits role + CGU/CGV, idempotent ULID header).
- Role branches (buyer/seller/driver) and dynamic step skipping are driven by
  the backend's completeness cursor `GET /v1/users/me/onboarding`; cold-start
  resume jumps to `next`.
- Phone verification temporarily uses an **email-OTP bypass**
  (`/v1/auth/email/{request-otp,verify}`) because the SMS provider is down.

## Gaps

- **Facebook button is advertised but unimplemented** (`docs/client-feedback.md`
  §1.5) → remove it or wire `POST /v1/auth/facebook`.
- Email-signup friction reported by the client; error copy shows raw codes
  instead of friendly French messages — branch on `ApiFailure.code`.
- `correlationId` parsed but never surfaced in the UI.
- Email-OTP bypass must be reverted to SMS (`/v1/auth/phone/*`) when the
  provider returns.

## Acceptance Criteria

1. **Given** valid signup, **When** Gate 1 fires, **Then** a session is stored
   and every later wizard call is authenticated.
2. **Given** a role is chosen, **When** Gate 2 fires with CGU+CGV accepted,
   **Then** the `User` aggregate + role stub is created (idempotent).
3. **Given** a stored session at cold start, **When** the app boots, **Then**
   `GET /v1/users/me/onboarding` routes the user to `next` or the role home.
4. **Given** an expired access token, **When** any request 401s, **Then** the
   interceptor refreshes once and replays without user-visible failure.
5. **Given** an unimplemented provider (Facebook), **When** the user looks at
   sign-in, **Then** no non-functional button is shown.

## Minimal Data Contract

`auth.users` (Supabase) → `User` (role, firstName, lastName, email/phone
verified flags) + one of `BuyerProfile` / `SellerProfile` / `DriverProfile`.

## Execution Tasks

- [x] Wire `/v1/auth/*` + token storage + refresh interceptor.
- [x] Wire two-gate wizard + onboarding resume cursor.
- [x] Email-OTP phone-verification bypass.
- [ ] Remove (or wire) the Facebook button.
- [ ] Friendly `ApiFailure.code`-based error copy for email signup.
- [ ] Revert phone verification to SMS when provider is live.

## Risks

- Authorization must never trust `user_metadata`.
- OTP resend must stay rate-limited; bypass must not leak codes cross-account.
