# TASK-016 — Re-enable phone OTP when SMS provider is live

Status: Blocked (external: SMS provider)
Priority: P2
Feature spec: `001-auth-onboarding`

## Purpose

Phone verification is currently bypassed (`feature_flags.dart`
`skipPhoneVerification = true`; `useEmailOtpBypass = false`). Restore real SMS
phone verification once the provider is back.

## Scope

- `lib/core/config/feature_flags.dart` — flip `skipPhoneVerification` to `false`.
- Verify the phone-OTP UI (intact) and `/v1/auth/phone/{request-otp,verify}`
  end-to-end; ensure `User.phone` / `phoneVerified` persist.
- Remove the temporary email-OTP bypass path if no longer needed.

## Acceptance Criteria

- [ ] New signups collect + verify a real phone via SMS OTP.
- [ ] `phoneVerified` gate is satisfied by the SMS flow, not the email bypass.

## Dependencies

- SMS provider (Twilio/Prelude) operational in production.

## Verification

- Manual: sign up, receive a real SMS code, verify; `GET /v1/users/me` shows the
  verified phone.
