# TASK-017 — Surface €50 wallet withdrawal minimum

Status: Ready
Priority: P2
Feature spec: `009-wallet-payouts`

## Purpose

Make the `WITHDRAWAL_MINIMUM_EUROS = 50` threshold visible in the wallet UI so
sellers/drivers understand why a withdrawal is blocked.

## Scope

- `lib/features/wallet/presentation/screens/wallet_screen.dart` (+ wallet
  widgets) — show the minimum, disable/explain withdraw below it.

## Acceptance Criteria

- [ ] When the balance is below €50, the withdraw action is disabled with a
      clear reason ("Minimum de retrait : 50 €").
- [ ] When at/above €50, withdrawal proceeds via `POST /v1/wallet/me/withdraw`.

## Technical Notes

- Surface the server's minimum rather than hardcoding a second copy of it where
  practical (or keep them in sync via a constant).

## Edge Cases

- Balance exactly €50; pending vs available balance distinction.

## Dependencies

- None.

## Verification

- Manual: balance €30 (blocked + reason), €60 (allowed).
