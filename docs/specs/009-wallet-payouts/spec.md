# Feature Spec: Wallet & Payouts (Stripe Connect)

**Feature ID**: `009-wallet-payouts`
**Created**: 2026-06-30
**Status**: Implemented
**Mobile module**: `lib/features/wallet`, `lib/features/payments`
**Wire contract**: `GET /v1/wallet/me`, `POST /v1/wallet/me/withdraw`,
`POST /v1/stripe/onboarding/account-link`

## User Story

As a seller or driver, I want to set up payouts, see my balance, and
withdraw earnings, so I get paid for sales/deliveries.

## Current Behavior

- `wallet_repository.dart` is wired: `getSummary()` (`/wallet/me`) and
  `withdraw()` (`/wallet/me/withdraw`). `wallet_screen.dart` uses both.
- `payout_onboarding_service.dart` calls `POST /v1/stripe/onboarding/account-link`;
  `payout_setup_banner.dart` prompts Stripe Connect Express onboarding on the
  seller home when no account is linked.
- Backend wallet ledger handles commission, driver debt, and timed releases
  (BullMQ `wallet-release.processor`).

## Gaps

- Verify the withdrawal minimum (`WITHDRAWAL_MINIMUM_EUROS = 50`) is surfaced
  in the UI before submit.
- Confirm payout-banner state reacts to the real Connect account status, not
  a one-time check.

## Acceptance Criteria

1. **Given** a seller/driver without a Connect account, **When** they open the
   home, **Then** the payout banner offers onboarding via the account link.
2. **Given** a balance ≥ minimum, **When** they withdraw, **Then**
   `/wallet/me/withdraw` succeeds and the balance updates.
3. **Given** a balance below minimum, **When** they try to withdraw, **Then**
   the UI blocks with a clear reason.

## Minimal Data Contract

`WalletEntry` (`WalletEntryType` / `WalletEntryStatus`, `releasedAt`),
Stripe Connect account id on the profile.

## Execution Tasks

- [x] Wire wallet summary + withdrawal + Connect onboarding banner.
- [ ] Surface the €50 withdrawal minimum pre-submit.
- [ ] Re-check banner against live Connect status.

## Risks

- Connect transfers fail for sellers/drivers without a real Connect id.
