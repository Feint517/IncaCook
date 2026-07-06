# Feature Spec: Seller Subscriptions (RevenueCat)

**Feature ID**: `010-seller-subscriptions`
**Created**: 2026-06-30
**Status**: Partial — app complete, store/dashboard config pending
**Mobile module**: `lib/features/subscriptions`
**Wire contract**: `docs/revenuecat-setup.md`, `docs/qa/revenuecat-testing.md`,
`GET/POST /v1/sellers/me/subscription` (+ `/sync`, `/portal`),
`POST /v1/webhooks/revenuecat`

## User Story

As a seller, I want to subscribe to a monthly plan for my category (with a
2-month free trial) so I can sell on the platform; the backend stays the
source of truth via webhook reconciliation.

## Current Behavior (app code — complete & correct)

- `RevenueCatService.init()` configures the SDK at startup (public key only).
- Subscriber identified with the backend user id (= webhook `app_user_id`).
- Offerings fetched per seller category (`bon_fait_maison` / `traiteur` /
  `sauve_ton_panier`); packages resolved by id (`monthly_standard` /
  `monthly_premium`); purchase + restore + entitlement read
  (`seller_premium` wins over `seller_standard`).
- After purchase/restore, `SellersRepository.syncSubscription()` reconciles
  the backend. `subscription_gate` wraps all seller tabs; precise paywall
  error states (`keyMissing` / `storeError` / `offeringMissing` /
  `packagesEmpty`).

## Gaps (config / ops — not code)

1. **🔴 App Store Connect: Paid Applications Agreement not Active** → Apple
   returns zero products. Sign agreement + banking + tax.
2. **🟡 Swapped products** in `traiteur` + `sauve_ton_panier` offerings (Apple
   product tier inverted) — test only `bon_fait_maison` until fixed.
3. **🟡 Backend `REVENUECAT_WEBHOOK_AUTH_TOKEN` commented out** → webhook
   reconciliation (renewals/cancellations/transfers) unverified.
4. **🟢 Verify** App-Specific Shared Secret / IAP key present in RevenueCat.
5. **Android** not wired (`REVENUECAT_ANDROID_KEY` empty).

## Acceptance Criteria

1. **Given** a seller at the paywall, **When** offerings load, **Then** real €
   prices show (not the "€ HT" fallback) and the trial is offered.
2. **Given** a purchase, **When** it completes, **Then** the entitlement is
   granted, `syncSubscription` marks the backend active, and the webhook
   records `INITIAL_PURCHASE`.
3. **Given** a reinstall, **When** the seller taps "Restaurer", **Then** the
   entitlement re-grants without a second charge.

## Minimal Data Contract

`SellerProfile` subscription columns (`SubscriptionStatus`, RevenueCat
fields), entitlements `seller_standard` / `seller_premium`.

## Execution Tasks

- [x] App-side SDK, offerings, purchase, restore, entitlement, backend sync.
- [ ] App Store Connect: Paid Apps Agreement active; products "Ready to Submit".
- [ ] Fix swapped products in `traiteur` / `sauve_ton_panier`.
- [ ] Set `REVENUECAT_WEBHOOK_AUTH_TOKEN` (uncommented) + point webhook at backend.
- [ ] Android key + Play products before Android QA.

## Risks

- Webhook gaps leave the backend's subscription state stale over time.
