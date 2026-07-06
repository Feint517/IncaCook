# RevenueCat — Android (Google Play) integration & test runbook

Companion to [revenuecat-testing.md](revenuecat-testing.md) (which is iOS-first).
Same **seller monthly subscription** — Stripe still owns orders / wallet /
payouts. The app code is already cross-platform; **everything below is Play
Console + RevenueCat dashboard config plus one key value.**

Last updated: 2026-06-30.

> **Status:** 🟡 Android not yet live. Client code is platform-ready; the gaps
> are (1) `REVENUECAT_ANDROID_KEY` empty, (2) no signed build on a Play track,
> (3) no Google Play products / Play Developer API link in RevenueCat.

---

## 0. What the app already does right (no code work needed)

| Concern | State | Where |
|---|---|---|
| SDK picks the Android key on Android | ✅ `RevenueCatConfig.apiKey` switches on `defaultTargetPlatform` | `lib/core/config/revenuecat_config.dart:44` |
| `purchases_flutter ^10.2.3` → Play Billing **8** | ✅ plugin bundles it; `minSdk 21` required, app inherits `flutter.minSdkVersion` (≥21) | `pubspec.yaml:60` |
| `com.android.vending.BILLING` permission | ✅ merged automatically by the plugin manifest — **do not add it manually** | — |
| login / purchase / restore / backend sync | ✅ all platform-agnostic | `seller_subscription_view.dart` |
| Release signing wired for Play uploads | ✅ reads `android/key.properties`, falls back to debug when absent | `android/app/build.gradle.kts:52` |

The shared **offerings** (`bon_fait_maison` / `traiteur` / `sauve_ton_panier`),
**packages** (`monthly_standard` / `monthly_premium`) and **entitlements**
(`seller_standard` / `seller_premium`) already exist from the iOS setup and are
platform-agnostic. For Android you only **attach Google products to the same
packages** — you do not recreate offerings or entitlements.

---

## 1. Generate an upload keystore (one time)

Google Play rejects debug-signed AABs. Create an upload key and a gitignored
`android/key.properties` (already covered by `android/.gitignore`):

```bash
keytool -genkey -v -keystore ~/incacook-upload.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

```properties
# android/key.properties  (NEVER commit — already gitignored)
storeFile=/Users/<you>/incacook-upload.jks
storePassword=<store password>
keyAlias=upload
keyPassword=<key password>
```

Build the signed bundle:

```bash
flutter build appbundle --release \
  --dart-define-from-file=.vscode/dart_defines.json
# → build/app/outputs/bundle/release/app-release.aab
```

> Prefer **Play App Signing** (default for new apps): you upload with the key
> above, Google manages the final signing key. Keep the upload key safe — losing
> it means re-registering an upload key with Google support.

---

## 2. Play Console — app + subscription products

1. **Create / locate the app** in [Play Console](https://play.google.com/console)
   with package **`com.incacook.app`** (must match `applicationId`).
2. Upload the AAB to **Testing → Internal testing** → create a release → roll out.
   (Products only become purchasable once a build with the same package is on a
   track and the account is a license tester.)
3. **Monetize → Products → Subscriptions → Create subscription** for each tier.
   - Decide stable **product IDs** (lowercase, e.g. `seller_standard_monthly`,
     `seller_premium_monthly`). These are the Google product ids you will attach
     in RevenueCat — they need **not** equal the package names.
   - Each subscription gets a **base plan** (monthly, auto-renewing) — note the
     **base plan id** (e.g. `monthly`). RevenueCat references Google products as
     `productId:basePlanId`.
   - Add an **offer** if you want the "2 months free" intro to match iOS.
   - Set price + activate the base plan.
4. **License testers:** **Settings → License testing** → add the tester Google
   accounts (test purchases are free and renew on the compressed sandbox clock).

---

## 3. Link Play ↔ RevenueCat (server-side validation)

RevenueCat needs Play Developer API access to validate Android purchases (the
Android analogue of the iOS App-Specific Shared Secret):

1. Google Cloud / Play Console → create a **service account** with Play Developer
   API access, grant it **View financial data** + **Manage orders** on the app,
   download its **JSON credentials**.
2. RevenueCat → **Project → Apps → + New → Google Play Store**:
   - App package: `com.incacook.app`
   - Upload the service-account **JSON**.
   - Copy the **public Android SDK key** (`goog_…`).

> Propagation: after granting API access it can take **up to ~36h** before
> RevenueCat can validate Play purchases. Plan Android QA accordingly.

---

## 4. Attach Google products to the existing packages

In RevenueCat → **Products** → import/add the Google products
(`seller_standard_monthly:monthly`, `seller_premium_monthly:monthly`), then:

- **Entitlements:** attach the standard Google product to **`seller_standard`**
  and the premium one to **`seller_premium`** (same entitlements iOS uses).
- **Offerings:** open `bon_fait_maison` (and later `traiteur` /
  `sauve_ton_panier`) → on each existing package (`monthly_standard` /
  `monthly_premium`) **attach the matching Google product** alongside the Apple
  one. ⚠️ Mind the tier — do not repeat the iOS standard↔premium swap noted in
  the iOS doc §1.

---

## 5. Set the Android key in the app

`.vscode/dart_defines.json` (gitignored, public values only):

```jsonc
"REVENUECAT_ANDROID_KEY": "goog_xxxxxxxxxxxxxxxxxxxx"
```

Empty key → `RevenueCatService.init()` skips `Purchases.configure` on Android and
the paywall shows fallback prices (failure `keyMissing`). This is the **only**
client value Android needs.

---

## 6. Test (internal testing track)

1. Install the app from the **internal testing** opt-in link on a device signed
   in with a **license tester** Google account.
2. Reach the paywall (register a seller → final step) and watch logs — filter
   `RevenueCat` / `Subscription`:
   ```
   [RevenueCat] platform=Android configured=true
   [RevenueCat] sdk configured success=true
   [RevenueCat] getOfferings success=true exists=true packages=[monthly_standard, monthly_premium]
   [Subscription] entitlement returned: seller_standard|seller_premium
   [Subscription] backend sync: active=true
   ```
3. Verify in three places (same as iOS §4.7): logs, RevenueCat **Customer
   History** (sandbox `INITIAL_PURCHASE`, `app_user_id` = backend user id), and
   the backend seller row flipping active.
4. **Restore:** reinstall / "Restaurer mon abonnement" → entitlement re-granted,
   no second charge.

Sandbox renewal clock is compressed like iOS (1 month ≈ 5 min).

---

## 7. Android-specific gotchas

| Symptom | Cause | Fix |
|---|---|---|
| `getOfferings success=true` but empty packages | Google product not attached to the package, or build not on a track yet | Attach product in RevenueCat (§4); ensure the AAB is live on internal testing with the same package |
| `configured=false` on Android | `REVENUECAT_ANDROID_KEY` empty | Set the `goog_` key (§5) |
| Purchase fails "item not available" | License tester not added, or product base plan inactive | Add tester (§2.4); activate the base plan |
| Validation errors after purchase | Play Developer API not linked / still propagating | Upload service-account JSON (§3); wait up to ~36h |
| Build rejected by Play (debug signed) | No `key.properties` | Create upload keystore (§1) |

---

## 8. Backend

No backend changes for Android — the webhook handler and
`POST /v1/sellers/me/subscription/sync` are store-agnostic (they key off
entitlement ids + `app_user_id`). Same open item as iOS: set
**`REVENUECAT_WEBHOOK_AUTH_TOKEN`** in the deployment env **and** the RevenueCat
webhook config, or every event 401s (see testing doc §1.3).
