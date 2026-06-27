# RevenueCat + App Store Connect setup (seller subscriptions)

This is the exact configuration the IncaCook app expects. The identifiers below
are **hard-coded in the app** ([lib/core/config/revenuecat_config.dart](../lib/core/config/revenuecat_config.dart)
and [lib/core/services/revenuecat_service.dart](../lib/core/services/revenuecat_service.dart)).
They must match **character-for-character** in both dashboards or the paywall
loads but finds no packages.

## 0. The fixed identifiers (do not change these — the app reads them)

| Concept | Identifier (exact) | Where used in code |
|---|---|---|
| Bundle ID (iOS) / applicationId (Android) | `com.incacook.app` | iOS project / Android gradle |
| Offering — Le bon fait maison | `bon_fait_maison` | `offeringFaitMaison` |
| Offering — Traiteur | `traiteur` | `offeringTraiteur` |
| Offering — Restaurant / Sauve ton panier | `sauve_ton_panier` | `offeringSauveTonPanier` |
| Package — Standard (in every offering) | `monthly_standard` | `packageStandard` |
| Package — Premium (in every offering) | `monthly_premium` | `packagePremium` |
| Entitlement — Standard | `seller_standard` | `entitlementStandard` |
| Entitlement — Premium | `seller_premium` | `entitlementPremium` |

So there are **3 offerings × 2 packages = 6 store products** total.

### Product IDs (you choose these — but they must be identical in App Store Connect and RevenueCat)

Use exactly these so nothing is ambiguous later:

| Offering | Plan | Product ID | Business price (monthly) | Free trial |
|---|---|---|---|---|
| `bon_fait_maison` | standard | `incacook_faitmaison_standard_monthly` | 4,99 € | 2 months |
| `bon_fait_maison` | premium | `incacook_faitmaison_premium_monthly` | 9,99 € | 2 months |
| `traiteur` | standard | `incacook_traiteur_standard_monthly` | 9,99 € | 2 months |
| `traiteur` | premium | `incacook_traiteur_premium_monthly` | 14,99 € | 2 months |
| `sauve_ton_panier` | standard | `incacook_restaurant_standard_monthly` | 4,99 € | 2 months |
| `sauve_ton_panier` | premium | `incacook_restaurant_premium_monthly` | 9,99 € | 2 months |

> Note on tax: the app's fallback labels say "€ HT" (excl. tax), but the App Store
> always shows tax-inclusive prices to the buyer. Pick the App Store price tier
> whose **net (your revenue)** matches your intended HT price, or just set the
> tier closest to the numbers above. The store price always overrides the
> fallback label once products load.

---

## 1. App Store Connect — prerequisites (do these first or products stay invisible)

1. **Agreements, Tax, and Banking** → sign the **Paid Applications Agreement**
   and complete banking + tax. Until this is "Active", StoreKit returns **zero**
   products in sandbox — this is the #1 cause of your current error.
2. Make sure the app record exists with Bundle ID **`com.incacook.app`**.

## 2. App Store Connect — create the subscriptions

Go to your app → **Monetization → Subscriptions**.

Create **3 Subscription Groups** (one per seller category — products in the same
group are mutually exclusive, which is what we want: a seller picks standard OR
premium within their category):

| Subscription Group (reference name) | Contains |
|---|---|
| `IncaCook Fait Maison` | faitmaison standard + premium |
| `IncaCook Traiteur` | traiteur standard + premium |
| `IncaCook Sauve ton Panier` | restaurant standard + premium |

For **each of the 6 products**, inside the right group, click **+** and set:

1. **Reference Name** — internal only, e.g. `Fait Maison Standard Mensuel`.
2. **Product ID** — the exact value from the table in §0 (e.g.
   `incacook_faitmaison_standard_monthly`). ⚠️ This cannot be changed later.
3. **Subscription Duration** — `1 Month`.
4. **Subscription Price** — pick the price tier (see tax note above).
5. **Localization** (add at least French): Display Name + Description.
   - e.g. Standard: "Abonnement Standard" / Premium: "Abonnement Premium".
6. **Introductory Offer** → **+** :
   - Type: **Free**
   - Duration: **2 Months**
   - Countries: all
   - This is the "2 mois gratuits" promised on the paywall.
7. Set **Review Information** (screenshot can be a paywall mock for review).

For sandbox testing, each product only needs to reach **"Ready to Submit"**
(price + 1 localization + the duration filled). You do **not** need App Review
approval to test in sandbox.

## 3. App Store Connect — keys RevenueCat needs

1. **App-Specific Shared Secret**: app → **App Information →
   App-Specific Shared Secret** → Generate → copy it (RevenueCat needs it to
   validate receipts). *(If you prefer the modern path, use an In-App Purchase
   API key instead — see §4 step 3.)*
2. **In-App Purchase Key** (recommended, enables StoreKit 2):
   **Users and Access → Integrations → In-App Purchase** → generate a key,
   download the `.p8`, note the **Issuer ID** and **Key ID**.

## 4. App Store Connect — Sandbox tester

**Users and Access → Sandbox → Test Accounts → +** : create a tester with an
email you do NOT use as a real Apple ID. You'll sign in with this on the device
at purchase time (not in iOS Settings).

---

## 5. RevenueCat dashboard — project & app

1. Create (or open) the project. Add an **App Store** app:
   - **App Bundle ID**: `com.incacook.app`
   - **App-Specific Shared Secret**: paste from §3.1, **or** upload the In-App
     Purchase `.p8` key (Issuer ID + Key ID) from §3.2.
2. Confirm the **public iOS SDK key** (`appl_…`) matches what the app ships —
   it's currently in [.vscode/dart_defines.json](../.vscode/dart_defines.json)
   under `REVENUECAT_IOS_KEY`.
3. (Android, later) add a **Play Store** app with package `com.incacook.app`
   and its service-account JSON, then set `REVENUECAT_ANDROID_KEY`.

## 6. RevenueCat dashboard — Products

**Product catalog → Products → + New**. Add all **6** products. For each:
- **Store**: App Store
- **Identifier**: the exact Product ID from §0 (must match App Store Connect).

## 7. RevenueCat dashboard — Entitlements

**Product catalog → Entitlements → + New**. Create exactly two:

| Entitlement identifier | Attach these products |
|---|---|
| `seller_standard` | `incacook_faitmaison_standard_monthly`, `incacook_traiteur_standard_monthly`, `incacook_restaurant_standard_monthly` |
| `seller_premium` | `incacook_faitmaison_premium_monthly`, `incacook_traiteur_premium_monthly`, `incacook_restaurant_premium_monthly` |

(The app treats premium as winning over standard when both are active.)

## 8. RevenueCat dashboard — Offerings (the part that fixes your error)

**Product catalog → Offerings → + New**. Create **3 offerings**. The offering
**Identifier** must be exact:

### Offering `bon_fait_maison`
Add **2 packages**. When adding a package, choose **Custom** identifier (not the
preset `$rc_monthly`) and type the identifier exactly:

| Package identifier | Product to attach |
|---|---|
| `monthly_standard` | `incacook_faitmaison_standard_monthly` |
| `monthly_premium` | `incacook_faitmaison_premium_monthly` |

### Offering `traiteur`
| Package identifier | Product to attach |
|---|---|
| `monthly_standard` | `incacook_traiteur_standard_monthly` |
| `monthly_premium` | `incacook_traiteur_premium_monthly` |

### Offering `sauve_ton_panier`
| Package identifier | Product to attach |
|---|---|
| `monthly_standard` | `incacook_restaurant_standard_monthly` |
| `monthly_premium` | `incacook_restaurant_premium_monthly` |

> The app fetches **all** offerings and looks up the one by id per category
> (`offerings.all['bon_fait_maison']`), so you do **not** need to mark a
> "Current" offering — but set one anyway (any of them) to satisfy the
> dashboard.

## 9. RevenueCat dashboard — Webhook (backend reconciliation)

The app sells locally but the **backend is the source of truth** (it reconciles
via webhook — see the sync logic in
[seller_subscription_view.dart](../lib/features/subscriptions/presentation/widgets/seller_subscription_view.dart#L181)).

**Project Settings → Integrations → Webhooks → + New**:
- URL: your backend RevenueCat webhook endpoint (Railway API). Confirm the exact
  path with the backend — coordinate this with whoever owns the server.
- The app sets the RevenueCat **App User ID = backend user id** (see
  `_revenueCat.login(userId)`), so webhook events map straight to the seller.

---

## 10. Verify on device

1. Sign out of the App Store on the device (Settings → your name → Media &
   Purchases → Sign Out) — for sandbox you sign in only when prompted.
2. Run the app on the physical device:
   ```bash
   flutter run --release --dart-define-from-file=.vscode/dart_defines.json -d <device-id>
   ```
3. Watch the logs. Success looks like:
   ```
   [RevenueCat] platform=iOS configured=true
   [RevenueCat] getOfferings success=true
   [RevenueCat] current offering exists=true
   [RevenueCat] packages count=2
   [Subscription] available packages=[monthly_standard, monthly_premium]
   ```
4. Tap a plan → purchase → sign in with the **Sandbox tester** → the sheet shows
   "2 months free, then …". After purchase you should see
   `[Subscription] entitlement returned: seller_standard` (or `seller_premium`).

### Troubleshooting map (from the app's own error messages)

| You see in the app | Meaning | Fix |
|---|---|---|
| "Produits non encore disponibles dans l'environnement Apple Sandbox" (`storeError`) | SDK reached RevenueCat but StoreKit returned no products | §1 Paid Apps Agreement; products "Ready to Submit"; product IDs match |
| "Offre d'abonnement introuvable" (`offeringMissing`) | Offering id not found | §8 — offering identifier must be `bon_fait_maison` / `traiteur` / `sauve_ton_panier` |
| "Produits d'abonnement indisponibles" (`packagesEmpty`) | Offering exists but package ids don't match | §8 — packages must be `monthly_standard` / `monthly_premium` |
| "Configuration RevenueCat manquante" (`keyMissing`) | SDK key empty | check `REVENUECAT_IOS_KEY` in dart_defines |

## Checklist

- [ ] Paid Applications Agreement active (banking + tax)
- [ ] 3 subscription groups, 6 products created with the exact Product IDs
- [ ] Each product: 1-month duration, price, FR localization, 2-month free intro offer
- [ ] App-Specific Shared Secret (or IAP key) added to RevenueCat app
- [ ] 6 products imported into RevenueCat
- [ ] Entitlements `seller_standard` / `seller_premium` with products attached
- [ ] 3 offerings with `monthly_standard` + `monthly_premium` packages, products attached
- [ ] Webhook pointed at backend
- [ ] Sandbox tester created; verified on device
