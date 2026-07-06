# QA — RevenueCat seller subscription: integration check & test guide

Covers the **seller monthly subscription** (the only thing RevenueCat handles —
Stripe stays for orders / wallet / payouts). Read alongside
[../revenuecat-setup.md](../revenuecat-setup.md) (dashboard setup) — this file is
the **testing / QA** companion.

Last verified: 2026-06-30.

> **Status (2026-06-30):** ✅ **Le Bon Fait Maison now works end-to-end on a
> physical device + sandbox.** After the Paid Applications Agreement went Active
> (30 Jun) and propagated, `getOfferings` returns
> `success=true … packages=[monthly_standard, monthly_premium]` with real € prices.
> `traiteur` / `sauve_ton_panier` are not yet fetchable (group localization +
> swapped products — see §1) and the leftover `default`/Test-Store offering still
> logs harmless warnings.

---

## 1. Integration status — what's done vs what's missing

### ✅ Client code — complete and correct
Verified end-to-end in the codebase:

| Capability | Where | Status |
|---|---|---|
| SDK configured at startup (public key, no secret) | `main.dart` → `RevenueCatService.init()` | ✅ |
| Subscriber identified with backend user id (= webhook `app_user_id`) | `RevenueCatService.login()` ← `seller_subscription_view._bootstrap` | ✅ |
| Offerings fetched per seller category | `loadOfferingForCategory()` | ✅ |
| Packages resolved by id (`monthly_standard` / `monthly_premium`) | `seller_subscription_view` | ✅ |
| Purchase + user-cancel handling | `RevenueCatService.purchase()` | ✅ |
| Restore purchases (App Store requirement) | `RevenueCatService.restore()` + "Restaurer" button | ✅ |
| Entitlement read (`seller_premium` wins over `seller_standard`) | `_outcomeFrom()` | ✅ |
| Backend sync after purchase/restore | `SellersRepository.syncSubscription()` | ✅ |
| Precise paywall error states (keyMissing / storeError / offeringMissing / packagesEmpty) | `OfferingFailure` | ✅ |

**Conclusion: nothing is missing in the app code.** Every failure seen so far is
configuration on the store / dashboard side.

### 🔴 / 🟡 What's missing or needs action (config, not code)

1. **✅ RESOLVED (30 Jun) — App Store Connect: Paid Applications Agreement.**
   This was the original blocker: `getOfferings` returned `configurationError` /
   "None of the products registered in the RevenueCat dashboard could be fetched
   from App Store Connect", with the paywall falling back to hardcoded "€ HT"
   prices. Fixed by completing **App Store Connect → Business → Agreements, Tax,
   and Banking** (Paid Applications agreement + banking + tax → **Active**).
   ⏳ Note: products are **not** fetchable instantly — allow **a few hours up to
   24h** after the agreement activates (and after any product edit) for sandbox
   to serve them. For Fait Maison this propagated the same day.

2. **🟡 `traiteur` / `sauve_ton_panier` not yet fetchable.** Only the **Fait
   Maison** subscription group was fully "Prêt à soumettre" + group-localized, so
   only its products fetch. The other two categories need:
   - their subscription-**group localization** completed (was "Finaliser avant
     soumission"), and products set to "Prêt à soumettre", **and**
   - the **swapped App Store products fixed**: in `traiteur` and
     `sauve_ton_panier` the Apple product attached to each package is inverted
     (`monthly_standard` → premium product, `monthly_premium` → standard). Fix in
     RevenueCat → Offerings → detach/re-attach so each package's Apple product
     tier matches its id.
   👉 Until both are done, **test with "Le Bon Fait Maison" only.**

   Also: the leftover **`default` offering** + **`incacook Pro` (Test Store)**
   entitlement produce harmless `why-are-offerings-empty` warnings in the log
   (Test-Store products can't fetch on a real device). Delete them in RevenueCat
   to silence the noise.

3. **🟡 Backend webhook auth token is commented out** in the server `.env`
   (`REVENUECAT_WEBHOOK_AUTH_TOKEN`). Without it the webhook reconciliation
   (renewals / cancellations / expirations / cross-platform transfers) isn't
   verified end-to-end. Confirm RevenueCat → Project → Integrations → Webhooks
   points at the backend endpoint and the auth token matches an **uncommented**
   value in the server env. (The in-app `syncSubscription` covers the initial
   purchase; the webhook is what keeps the backend truthful over time.)

4. **🟢 Verify the App-Specific Shared Secret / In-App Purchase key** is present
   in RevenueCat → Apps → `incacook (App Store)` (needed for receipt
   validation). A missing one shows up as validation errors, not empty
   offerings.

5. **Android** is not wired for testing: `REVENUECAT_ANDROID_KEY` is empty in
   `dart_defines.json`. Fine for the current iOS test. Full Play Console +
   RevenueCat Android setup is its own runbook →
   [revenuecat-android-setup.md](revenuecat-android-setup.md). The client code is
   already cross-platform; Android needs the `goog_` key, a signed AAB on a Play
   track, and Google products attached to the existing packages/entitlements.

---

## 2. Prerequisites to run the app at all (fresh clone)

These are unrelated to RevenueCat but block the build:

- **`.vscode/dart_defines.json`** — present (public values only). Required; the
  app reads Supabase / API / Stripe / Google Maps / RevenueCat from it.
- **Google Maps Platform** — billing must be enabled and the mobile key must
  have Maps SDK for iOS/Android plus Places, Directions, Geocoding, and Static
  Maps enabled for the app surfaces that use them.
- **Code signing** — device builds use `DEVELOPMENT_TEAM = 7DSQT22UZ7` (the team
  that owns `com.incacook.app` + the App Store Connect products). Your Apple ID
  **must be a member of that team**, or real-sandbox products won't resolve.
- **SwiftPM / GitHub resolve** — if Xcode SPM resolution stalls with
  `Failed to connect to github.com port 443 after 75010 ms` (IPv6 black-hole),
  force IPv4 for the resolve:
  ```bash
  networksetup -setv6off Wi-Fi      # your active service
  # open ios/Runner.xcworkspace → File → Packages → Resolve Package Versions
  networksetup -setv6automatic Wi-Fi
  ```
  Once resolved it caches; subsequent `flutter run`s won't re-fetch.

---

## 3. Two test environments — pick the right one

| | Simulator + StoreKit file | **Physical device + real sandbox** |
|---|---|---|
| What it proves | Paywall UI, offerings load, purchase flow, entitlement grant | The **real** chain incl. App Store Connect + **webhook** |
| Products source | `ios/Runner/Products.storekit` (local) | App Store Connect (real) |
| Webhook fires | ❌ no | ✅ yes |
| Scheme setting | StoreKit Configuration = **Products.storekit** | StoreKit Configuration = **None** |
| Use when | Quick "is it wired up" check | **Validating RevenueCat for real** |

Toggle in Xcode: **Product → Scheme → Edit Scheme → Run → Options → StoreKit
Configuration**. (The current scheme is set to **None** for device sandbox
testing.) VS Code launch configs:
- `IncaCook ▶ iPhone d'Ali (device · sandbox)` — real sandbox
- `IncaCook ▶ iPhone 17 (simulator · StoreKit)` — local StoreKit

---

## 4. Successful test — step by step (device + real sandbox)

1. **Prerequisites green** (section 2) and **Paid Apps Agreement Active**
   (section 1.1).
2. **Create + sign in a Sandbox tester on the device.**
   - Create the tester: **App Store Connect → Users and Access → Sandbox → Test
     Accounts → +** (use an email that is **not** a real Apple ID).
   - Sign in on the iPhone (iOS 16+, incl. iOS 26): **Settings → Developer →
     Sandbox Apple Account → Sign In** with the tester credentials.
     - The **Developer** menu only appears after a development build has run on
       the device from this Mac (ours has). If it's missing, re-run from Xcode.
     - ⚠️ **Do NOT** put the sandbox account in **Settings → [your name]** (that's
       your real Apple ID) — it goes **only** under Developer → Sandbox Apple
       Account.
   - Alternative: skip Settings and sign in when the **purchase sheet** prompts
     (it shows "Environnement Sandbox" at the bottom).
3. **Run:** VS Code → `IncaCook ▶ iPhone d'Ali (device · sandbox)` → F5.
4. **Reach the paywall:** register a new **seller** → walk the signup steps →
   final step "Choisissez votre abonnement". **Pick "Le Bon Fait Maison"** (the
   only category with correct products today).
5. **Confirm offerings loaded** — watch the log console (see section 5). The two
   plan cards must show **real € prices** (not the "€ HT" fallback).
6. **Buy:** select a plan → "S'abonner maintenant" → the sandbox sheet shows
   **"2 mois gratuits, puis …"** → authenticate with the sandbox tester →
   confirm.
7. **Verify in three places:**
   - **Logs:** `entitlement returned: seller_standard|seller_premium` then
     `backend sync: active=true`.
   - **RevenueCat dashboard** → Customer History (toggle **Sandbox**) → an
     `INITIAL_PURCHASE` event with `app_user_id` = the backend user id.
   - **Backend** → webhook received → seller subscription marked active.
8. **Restore test:** tap "Restaurer mon abonnement" → entitlement re-granted
   without a second charge.

> **After the purchase succeeds**, "Terminer" enables and the seller lands on
> their home. Continue the full shop-setup → live-operation test (and the buyer
> + driver journeys) in
> **[full-user-journey-testing.md](full-user-journey-testing.md)** — it picks up
> exactly here (Journey A, step 13).

### Sandbox quirks (not bugs)
- Renewal clock is compressed: 1 month ≈ **5 min**; auto-renews ~6× then stops.
- The "2 mois gratuits" intro offer shows **once per sandbox account** — use a
  fresh tester (or clear purchase history) to re-test the trial.

---

## 5. Reading the logs

Logging now uses `lib/core/utils/log.dart` (colour-coded, grouped under the
`IncaCook` source). Filter the debug console / `flutter logs` for `RevenueCat`
or `Subscription`.

Each line is prefixed by the logger source + timestamp, e.g.
`[IncaCook:56:1:794] [RevenueCat] getOfferings success=true …`.

**Success chain (verified on device, Fait Maison):**
```
[RevenueCat] platform=iOS configured=true          (blue)
[RevenueCat] sdk configured success=true           (green)
[SubscriptionGate] backend status=NONE shouldShowPaywall=true   (blue)
[Subscription] category=faitMaison offeringId=bon_fait_maison   (blue)
[RevenueCat] getOfferings start offeringId=bon_fait_maison      (blue)
[RevenueCat] getOfferings success=true exists=true packages=[monthly_standard, monthly_premium]   (green)
[Subscription] selected plan=standard              (blue)
[Subscription] entitlement returned: seller_standard           (green)
[Subscription] backend sync: active=true status=...            (green)
```

**`getOfferings success=true` but RevenueCat still prints
`why-are-offerings-empty` / "problem with your configuration" warnings.**
This is normal once at least one offering works: the warnings are about the
**other** offerings whose products didn't fetch (the leftover `default`/Test
Store offering, and `traiteur`/`sauve_ton_panier` before they're ready). A
package only appears in `availablePackages` (the `packages=[...]` log) when its
App Store product fetched **with a price** — so if your category lists both
packages, it's good to purchase regardless of the warnings.

**Failure example (the original blocker, now resolved):**
```
[RevenueCat] getOfferings failed code=PurchasesErrorCode.configurationError
  message=There is an issue with your configuration...
  underlying=None of the products ... could be fetched from App Store Connect   (red)
```

To attach without rebuilding: `flutter logs -d <device-id>` then re-open the
paywall (the `getOfferings` call fires on screen load).

---

## 6. Troubleshooting map (app error → cause → fix)

| In-app banner / log | `OfferingFailure` / code | Cause | Fix |
|---|---|---|---|
| "Produits non encore disponibles dans l'environnement Apple Sandbox" + `configurationError` | `storeError` | Products not fetchable from App Store Connect | **Paid Applications Agreement Active** (#1); products priced + available in tester region; **subscription-group localization completed**; wait up to 24h for propagation after the agreement activates / after edits |
| `getOfferings success=true` but warnings about *other* offerings | — | Other offerings have unfetchable products (Test-Store `default`, not-ready categories) | Harmless for the working category; delete leftover `default`/Test-Store offering + finish the other groups to silence |
| "Offre d'abonnement introuvable" | `offeringMissing` | Offering id not found in dashboard | Offering id must be `bon_fait_maison` / `traiteur` / `sauve_ton_panier` (see log `store returned [...]`) |
| "Produits d'abonnement indisponibles" | `packagesEmpty` | Offering exists, package ids mismatch | Packages must be exactly `monthly_standard` / `monthly_premium` |
| "Configuration RevenueCat manquante" | `keyMissing` | SDK key empty in build | Check `REVENUECAT_IOS_KEY` in `dart_defines.json` |
| Standard shows premium price (or vice-versa) | — | Swapped Apple products | Fix `traiteur` / `sauve_ton_panier` offering attachments (section 1.2) |
| Build fails: `github.com port 443 ... 75010 ms` | — | SwiftPM IPv6 stall | Force IPv4 during resolve (section 2) |
| Google map is blank | — | Maps SDK key/API/billing missing | Check `GOOGLE_MAPS_API_KEY` in dart-defines, enabled Maps SDKs/APIs, and billing |

---

## 7. Pre-flight checklist

- [x] Paid Applications Agreement **Active** (banking + tax) — done 30 Jun
- [x] Sandbox tester created + signed in on the device (Developer → Sandbox Apple Account)
- [x] Fait Maison products fetch (`getOfferings success=true … packages=[…]`)
- [ ] **Purchase test completed** on Fait Maison (entitlement + backend sync + RevenueCat Sandbox event)
- [ ] `traiteur` / `sauve_ton_panier`: group localization completed + products "Prêt à soumettre"
- [ ] Swapped products fixed in `traiteur` + `sauve_ton_panier`
- [ ] Leftover `default` offering + `incacook Pro` Test-Store entitlement deleted (silences warnings)
- [ ] App-Specific Shared Secret / IAP key in RevenueCat
- [ ] Webhook configured + `REVENUECAT_WEBHOOK_AUTH_TOKEN` set (uncommented) on the backend
- [x] Google Maps mobile key configured for iOS/Android
- [x] Signed with team `7DSQT22UZ7`
- [ ] Scheme StoreKit Configuration = **None** (device) / **Products.storekit** (simulator)
