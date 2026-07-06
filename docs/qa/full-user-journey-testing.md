# IncaCook — Full end-to-end QA journeys (all 3 user types)

Step-by-step manual test scripts to exercise the app from **purchase / signup
→ onboarding → live operation** for each role, so you can drive a real flow and
record what breaks.

Companion docs:
- [revenuecat-testing.md](revenuecat-testing.md) — the App Store purchase itself
  (the seller's final onboarding step). **This doc picks up where that one ends.**
- [revenuecat-android-setup.md](revenuecat-android-setup.md) — Android wiring.

Assumes: **App Store sandbox entitlements work** (Fait Maison purchase returns
`packages=[monthly_standard, monthly_premium]` with real € prices). Build /
device prerequisites are in revenuecat-testing.md §2.

Last updated: 2026-06-30.

---

## 0. The 3 roles (and the fastest test path)

`UserRole`: **buyer (BUYER)** · **seller (SELLER)** · **driver (DRIVER)**
(`lib/features/authentication/data/models/user_role.dart`). Role is chosen once
on the role-selection step and is **forward-only** after commit (no going back).

Seller has a sub-type `SellerCategory` that changes the onboarding length:

| Category | Extra steps vs Fait Maison | Use for |
|---|---|---|
| **faitMaison** (default) | none — **shortest path** | smoke-testing the whole chain |
| **traiteur** | + business info, + KYC (ID + selfie) | KYC / business validation |
| **restaurant** | + business info (SIRET + facade + hours), + KYC | full compliance path |

👉 **Run the Fait Maison seller first** — it's the shortest route to a live shop
and the only category whose App Store products currently fetch.

---

## 1. Before you start — QA realities baked into this build

These are current code behaviours that will confuse testing if you don't know
them:

| Reality | Where | Impact on testing |
|---|---|---|
| **No SMS/OTP step** — `skipPhoneVerification = true` | `lib/core/config/feature_flags.dart` | Phone is collected on basic-info, stored unverified. Don't wait for a code. |
| **Debug builds auto-seed** the basic-info fields with random fake data | `signup_flow_controller.dart` (basic-info) | Speeds signup, but every run creates a NEW random account. Note the email if you need to log back in. |
| **Stripe is in test mode** — `pk_test_…` is set in `dart_defines.json` | buyer payment | Use Stripe **test card `4242 4242 4242 4242`**, any future expiry / CVC. If the backend returns a `…_secret_devbypass` intent, the charge is skipped and the order still completes. |
| **Sandbox renewal clock is compressed** | App Store sandbox | 1 month ≈ 5 min; the seller sub auto-renews ~6× then stops — fine for a session. |
| **Navigation is by widget class**, not routes | `app.dart` (only `/signup` is named) | Reference screen **class names** below, not deep links. |
| Two **QR scans** in the driver flow | `delivery_route_controller.dart` | You need the **seller's pickup QR** and the **buyer's reception QR** on screen to scan — plan device positioning (see §5). |

**Recommended rig for the full integration test (§6):** 3 sessions —
1 sandbox device (seller, real App Store purchase) + 2 more accounts (buyer,
driver). A second physical device or a simulator works for buyer/driver since
they don't purchase. The driver QR scans require the seller/buyer QR to be
visible to the driver's camera.

---

## 2. JOURNEY A — Seller: from App Store purchase to a live shop

**Goal:** complete onboarding via the purchase, then set up the shop and reach
"ready to receive orders." Precondition: sandbox tester signed in (revenuecat
doc §4.2).

### A1 · Reach the paywall (signup → final step)
1. Launch → **WelcomeScreen** (`welcome.dart`). Tap **"S'inscrire avec e-mail"**.
   - ☑ Expected: `/signup` wizard opens (`SignupShellScreen`).
2. **Basic info** (`basic_info_page.dart`) — debug auto-fills; tap **"Continuer"**.
   - ☑ `POST /v1/auth/signup` succeeds; advances. **Record the auto-seeded email.**
3. **Biometric** (`biometric_setup_page.dart`) — tap **"Passer"**.
4. **Legal** (`legal_acceptance_page.dart`) — check **CGU + CGV** → "Continuer".
5. **Role selection** (`role_selection_page.dart`) — tap **"Ma cuisine mérite
   d'être goûtée"** (seller) → **"Continuer"**.
   - ☑ `POST /v1/users` commits the role. ⚠️ **No back button after this.**
6. **Seller profile** (`seller_profile_page.dart`) — pick **"fait maison"**, add a
   profile photo (**required**), display name (≥2 chars), bio → "Continuer".
7. **DOB + pickup address** (`seller_dob_address_page.dart`) — DOB **≥18**, pickup
   address → "Continuer".
   - ☑ `PUT /sellers/me/profile` (sends `category`, `deliveryFeeCents:250`).
   - *(traiteur/restaurant only: Business info → KYC ID → KYC selfie steps here.)*
8. **Cuisine** (`seller_cuisine_page.dart`) — pick ≥1 cuisine → "Continuer".
   - ☑ `PUT /sellers/me/cuisines`.
9. **Charter** (`seller_charter_page.dart`) — check both commitments → "Continuer".
10. **Subscription** (`seller_subscription_page.dart`, "Choisissez votre
    abonnement", step **10/10**). ☑ Two plan cards show **real € prices**.

### A2 · The App Store purchase (the hand-off point)
Follow [revenuecat-testing.md §4.6–4.7](revenuecat-testing.md) here. In short:
11. Select a plan → **"S'abonner maintenant"** → sandbox sheet ("2 mois
    gratuits…") → authenticate with the sandbox tester → confirm.
12. ☑ **Logs:** `entitlement returned: seller_standard|seller_premium` →
    `backend sync: active=true status=…`.
13. ☑ **"Terminer" enables** (it stays disabled until `subscriptionActive ==
    true`). Tap **"Terminer"**.
    - ☑ `Get.offAll(NavigationMenu(tabs: kSellerNavTabs))` → lands on **Accueil**.

> **If "Terminer" never enables:** the purchase succeeded but the backend sync
> didn't flip active. Check the webhook token (revenuecat doc §1.3) and the
> `backend sync` log line. This is the #1 thing to watch.

### A3 · Verify the subscription gate
The seller tabs **Accueil / Commandes / Mes plats** are wrapped in
`SubscriptionGate` (`subscription_gate.dart`); **Messages / Profil** are not.
14. ☑ With an active sub, Accueil / Commandes / Mes plats show real content —
    **not** the "Abonnement requis" `SubscriptionPaywallScreen`.
    - 🐞 *Bug-hunt:* if any gated tab still shows the paywall while logs say
      active, the gate's `hasActiveSellerSubscription` isn't reacting.

### A4 · Set up the shop (add the first dish)
15. **Mes plats** tab (`seller_products.dart`) → tap the add bar → **"Ajouter un
    plat"** sheet (`add_product_sheet.dart`).
16. Fill: Photos, title/description/**price** (⚠️ **€4.50 cap for fait-maison** —
    confirm it's enforced), portions, prep minutes; classification (category is
    read-only, auto from profile), cuisines, diets; **allergens (required)**;
    availability (pickup start/end); pickup mode toggles; check the **CGU/CGV**
    consent tile.
17. Tap **"Publier le plat"**.
    - ☑ `POST /v1/listings` → dish appears under **Disponible**.
    - 🐞 *Bug-hunt:* price cap bypass, allergen not enforced, photo upload
      failures, availability toggle not persisting.
18. Open the dish → `ProductDetailScreen(isSeller:true)` → confirm **"Modifier" /
    "Supprimer"** work (`PATCH` / delete).

### A5 · Payout setup (so the seller can be paid)
19. **Profil** tab → settings → **Stripe Connect payout** setup. Complete the
    Connect onboarding (test mode).
    - ☑ Payout status reflects "configured".
    - 🐞 *Bug-hunt:* Connect redirect not returning to the app, status stuck.

**Seller is now live** — discoverable in the buyer feed and able to receive
order requests (continue at §6 to actually receive one).

---

## 3. Seller resilience checks (optional, valuable)
- **Lapsed sub:** if the sub expires (sandbox stops renewing), Accueil /
  Commandes / Mes plats should flip to **"Abonnement requis"** while Messages /
  Profil stay reachable. ☑ Confirm the soft-lock, and that **"Restaurer mon
  abonnement"** re-grants access.
- **Restore on reinstall:** delete + reinstall, log back in (use the recorded
  email), tap restore → entitlement returns, no second charge.

---

## 4. JOURNEY B — Buyer: browse → order → pay → track

**Goal:** place and pay for a real order and watch it track. Precondition: a
live seller with ≥1 published dish (Journey A), ideally a different account.

1. Sign up as **buyer**: Welcome → "S'inscrire avec e-mail" → basic info →
   biometric "Passer" → legal → **role "j'ai faim…"** → lands on
   `NavigationMenu(kClientNavTabs)` → **Accueil** (`client_home.dart`).
   - *(Buyer has an optional skippable dietary step.)*
2. **Browse** — "Food near you" feed (`GET /v1/listings`) + "Kitchens near you"
   (`GET /v1/sellers`). ☑ The seller's dish from §2 appears. Use the filter /
   search / category hub.
   - 🐞 *Bug-hunt:* feed empty despite a published dish (location filter, seller
     not "active", `displayName` null), images missing.
3. **Product detail** (`product_detail.dart`) → either quick **add-to-cart** or
   **order/customize** (`OrderCustomizeSheet` — add-ons, qty, note).
4. **Cart** (`my_cart.dart`, "Mon panier"). ⚠️ **Single-seller lock** — adding a
   dish from a different seller triggers `DifferentSellerDialog`. Tap **"Continuer
   le paiement"**.
5. **Fulfillment** — `FulfillmentChoiceSheet` (delivery vs pickup). For the full
   chain pick **delivery** → enter address (`DeliveryAddressScreen`).
6. **Order summary** (`order_summary.dart`, "checkout") — ☑ breakdown = articles +
   delivery fee + **5% platform fee** = total. Tap **"Continuer vers le paiement"**.
7. **Payment** (`payment.dart`) — check **CGU/CGV** tile, pick a method, enter the
   Stripe **test card `4242 4242 4242 4242`** (any future expiry, any CVC). Tap
   **"Payer €X.XX"**.
8. **Processing** (`payment_processing.dart`) — `POST /v1/orders` → Stripe
   PaymentIntent → `confirmPayment`.
   - ☑ Success → **OrderConfirmationScreen**, cart cleared.
   - 🐞 *Bug-hunt:* `_FailedView` ("Réessayer"), or a `_secret_devbypass` intent
     silently skipping the charge (note whether real Stripe test charge appears).
9. **Confirmation** → tap **"Suivre ma commande"** → **OrderTrackingScreen**
   (`order_tracking.dart`).
10. **Track** — ☑ live stages via `/tracking` socket: preparing → onTheWay →
    delivered. Driver appears only once assigned; Google map; completion popup
    ("Commande livrée !" / "Commande récupérée !").
    - 🐞 *Bug-hunt:* socket not connecting, stage stuck, driver location not
      moving, no-driver decision card behaviour.

---

## 5. JOURNEY C — Driver: onboard → go online → claim → deliver

**Goal:** onboard a driver and run one delivery through both QR handoffs.

### C1 · Onboarding
1. Sign up as **driver**: Welcome → email signup → basic info → biometric
   "Passer" → legal → **role "C'est moi qui livre !"**.
2. **DOB + address** (`driver_dob_address_page.dart`, ≥18) → "Continuer".
3. **Vehicle** (`driver_vehicle_page.dart`) — pick a `DriverVehicleType`.
   `PUT /drivers/me/vehicle`.
4. **KYC ID** (`driver_kyc_id_page.dart`) + **KYC selfie** (`driver_kyc_selfie_page.dart`).
5. **Documents** (`driver_documents_page.dart`) — **only if the vehicle
   `requiresMotorizedDocs`** (license + carte grise). Pick a non-motorized
   vehicle to skip.
6. **Zone** (`driver_zone_page.dart`, ≥1 zone) → `PUT /drivers/me/zones`.
7. **Charter** (`driver_charter_page.dart`) — check commitments.
8. **Payout setup** (`payout_setup_page.dart`) — **skippable**; tap **"Terminer"**
   → `Get.offAll(DeliveryHomeScreen())`.
   - ⚠️ Drivers have **no subscription step**.

### C2 · Go online & claim
9. **DeliveryHomeScreen** (`delivery_home.dart`) — full-screen Google map +
   bottom sheet + `PayoutSetupBanner` (until Connect done).
10. Tap **"Go Online"** (`go_online_button.dart`). ☑ Status → online.
    - If KYC is not `APPROVED`, the button stays disabled and shows the KYC
      reason instead of calling `POST /drivers/me/online`.
11. When a buyer order is available, `showIncomingOrderModal`
    (`incoming_order_sheet.dart`) → **"Accepter"** (gated on `canDriverClaim` =
    KYC done; payout not required to claim) → `DeliveriesRepository.claim`.
    - 🐞 *Bug-hunt:* "Accepter" disabled (incomplete KYC), no incoming modal.

#### C2.1 Fast QA driver approval without the dashboard

Use this only on local/staging QA data. Connect with a Postgres URL that has
permission to update app tables, then approve the mirrored IncaCook driver row:

```bash
psql "$DATABASE_URL" -c "
update public.\"DriverProfile\" dp
set \"kycStatus\" = 'APPROVED',
    \"updatedAt\" = now()
from public.\"User\" u
where dp.\"userId\" = u.id
  and lower(u.email) = lower('driver@example.com')
returning dp.\"userId\", u.email, dp.\"kycStatus\";
"
```

After the update, sign out/in or trigger a profile refresh so the app reloads
`GET /users/me` and the delivery KYC gate re-evaluates.

### C3 · Job lifecycle (`job_lifecycle_card.dart`)
12. `prepared` → **"Arrivé au ramassage"** → `arrivedPickup`.
13. `arrivedPickup` → **"Commande récupérée"** → **scan the seller's pickup QR**
    (`QrScanScreen`) → `onTheWay`.
    - 🐞 *Bug-hunt:* QR won't scan, wrong-order QR accepted.
14. `onTheWay` → **"Arrivé chez le client"** → `arrivedDropoff`.
15. `arrivedDropoff` → **"Confirmer la livraison"** → **scan the buyer's reception
    QR** → `delivered`.
16. `delivered` → **"Terminé"** → job cleared.
    - **Fallbacks to test:** seller absent → `SellerUnavailableScreen`
      (cancel+refund); client absent → `AbsentDropoffScreen` (photo + GPS proof);
      "Signaler un problème" sheet on non-terminal stages.

---

## 6. Integration scenario — one order across all 3 roles (the real test)

This is the highest-value run: it proves the seller↔buyer↔driver chain end to
end. Needs the seller live (§2) and ideally 3 sessions.

1. **Seller** (online, ≥1 dish) — ready in **Commandes**.
2. **Buyer** orders that dish + **delivery** + pays (§4) → order created.
3. **Seller** — order appears in **Accueil → "Demandes de commande"** /
   **Commandes**. Tap **Accepter** → **"Démarrer la préparation"** → **"Marquer
   prêt"**. The seller now shows a **pickup QR**.
4. **Driver** — online, receives the incoming modal → **Accepter** → drives to
   pickup → **"Commande récupérée"** → **scans the seller's pickup QR**.
5. **Driver** → **"Arrivé chez le client"** → **"Confirmer la livraison"** →
   **scans the buyer's reception QR** → delivered.
6. **Buyer** tracking screen → completion popup; **Seller** order → Historique;
   **Driver** job cleared.

☑ Each transition should reflect within seconds on the other two screens (socket
push). Record any desync, stuck stage, or status mismatch between the three
views — that's exactly what this run is designed to surface.

---

## 7. Where bugs tend to hide — focused checklist

| Area | Watch for |
|---|---|
| Seller gate | "Terminer" not enabling after purchase; gated tab still showing paywall while active; lapse not soft-locking |
| Add product | €4.50 fait-maison price cap not enforced; allergens not required; photo upload fail; availability toggle not persisting |
| Payouts | Stripe Connect redirect not returning; status stuck "not configured" |
| Buyer feed | published dish not appearing; image 404; distance/location filtering hiding everything |
| Cart | single-seller lock dialog; quantity/add-on math; 5% platform fee + delivery fee total |
| Payment | real vs `devbypass` intent; `_FailedView` retry; double-charge on retry |
| Tracking socket | not connecting; stage stuck; driver marker not moving; no-driver card |
| Driver claim | "Accepter" gating (KYC); no incoming modal when online |
| QR handoffs | pickup/reception QR won't scan; wrong order accepted |
| Fallbacks | seller-unavailable refund; absent-dropoff proof capture |
| Cross-role sync | desync / status mismatch between seller, buyer, driver views |

---

## 8. Defect log (copy per run)

| # | Role | Step (§) | Expected | Actual | Severity | Notes / log line |
|---|---|---|---|---|---|---|
| 1 | | | | | | |
| 2 | | | | | | |
| 3 | | | | | | |

> Capture the relevant `[IncaCook:…]` log line for each defect (filter the
> console for `RevenueCat` / `Subscription` / the failing feature). Note the
> auto-seeded account email so a bug can be reproduced on the same user.
