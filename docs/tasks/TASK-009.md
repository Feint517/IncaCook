# TASK-009 — RevenueCat store/dashboard config + webhook token

Status: Blocked (external: App Store Connect)
Priority: P1
Feature spec: `010-seller-subscriptions`
Source: `docs/qa/revenuecat-testing.md`

## Purpose

The subscription app code is complete; subscriptions fail only because of
store/dashboard configuration. Finish that config so purchases work end-to-end
with backend reconciliation.

## Scope (config, not app code)

- App Store Connect: sign **Paid Applications Agreement** + banking + tax until
  **Active** (else Apple returns zero products).
- RevenueCat: fix the **swapped Apple products** in the `traiteur` and
  `sauve_ton_panier` offerings (standard/premium inverted).
- Backend: set `REVENUECAT_WEBHOOK_AUTH_TOKEN` (uncommented) and point the
  RevenueCat webhook at the backend endpoint.
- Verify App-Specific Shared Secret / IAP key present in RevenueCat.
- (Later) Android: set `REVENUECAT_ANDROID_KEY` + Play products.

## Acceptance Criteria

- [ ] On a real device, the paywall shows real € prices + the 2-month trial for
      all three categories.
- [ ] A sandbox purchase grants the entitlement, `syncSubscription` marks the
      backend active, and the webhook records `INITIAL_PURCHASE`.
- [ ] Restore re-grants without a second charge.

## Technical Notes

- App User ID = backend user id (already set via `RevenueCatService.login`).
- Identifiers are fixed in `revenuecat_config.dart` — do not change them;
  match them character-for-character in the dashboards.

## Edge Cases

- Sandbox renewal clock (1 month ≈ 5 min); intro offer once per sandbox account.

## Dependencies

- Apple agreement activation (external, may take time).

## Verification

- Follow `docs/qa/revenuecat-testing.md` §4 step-by-step on a real device
  (test `bon_fait_maison` first until the swapped products are fixed).
