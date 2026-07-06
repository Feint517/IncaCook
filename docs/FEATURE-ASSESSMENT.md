# IncaCook — Feature Assessment (mobile code vs. backend vs. intent)

Checked on: 2026-06-30.

What the **Flutter app actually does today** (from a live read of
`lib/features/*` + `lib/core/*`) measured against the **backend**
(`IncaCook-Server`, `src/modules/*`, `prisma/schema.prisma`) and the
**product intent** (`docs/prd/prd.md`, `docs/client-feedback.md`).

> ⚠️ **`docs/backend-communication.md` is a dated snapshot.** It still
> describes `ListingsRepository` as unregistered and the buyer feed / map /
> orders as mock-backed. A live code read shows those are now **wired** (git
> milestones `1b2d4c4 90% ready`, `86234e3` kitchens repo + map, etc.). Where
> the two disagree, the code wins; this file reflects the code.

## Verdict

Both halves of the project are mature. The backend is ~95% complete (full
marketplace + delivery + payments + wallet + moderation + messaging +
subscriptions + admin, with tests). The mobile app is **~90% wired to real
endpoints**: authentication, the multi-role signup wizard, profiles/KYC/
charters/uploads, listings (seller publish + buyer feed), the map, the full
order→pay→track chain, deliveries, wallet, subscriptions, reviews,
moderation, messaging, supply catalog, and settings all talk to the backend.

The remaining work is **not "wire the marketplace"** — it is a short list of
**mock leaks, hardcoded dashboard widgets, compliance/UX rules, store-side
config, and dead-code cleanup**. The single role-management fact: roles are
**buyer / seller / driver** (`user_role.dart`); admin has no mobile surface
(see the separate `incacook-admin` repo).

## Status legend

- **Done** — wired to the backend and functioning.
- **Partial** — real core wiring, but with a mock/hardcoded leak or a known
  correctness/compliance gap.
- **Todo** — no real wiring (stub/dead), or net-new work.

## Completion matrix (feature → status)

| Feature | Status | Evidence (lib/…) |
|---|---|---|
| Auth: email/password + Google | **Done** | `authentication/data/repositories/auth_repository.dart`; `post_auth_router.dart` |
| Signup wizard (Gate 1 + 2, role branches) | **Done** | `signup_flow_controller.dart`; `/v1/users`; onboarding cursor |
| Phone verification | **Partial** | `core/config/feature_flags.dart` `skipPhoneVerification = true` (OTP UI intact, currently bypassed) |
| Profile / addresses / charters / KYC / uploads | **Done** | `users_/kyc_/charters_/uploads_repository.dart` |
| Buyer preferences | **Done** | `buyers_repository.dart` → `/v1/buyers/me/preferences` |
| Seller profile/business/cuisines | **Done** | `sellers_repository.dart` |
| Driver vehicle/zones | **Done** | `drivers_repository.dart` |
| Kitchens feed (buyer→sellers) | **Done** | `client/data/kitchens_repository.dart` → `GET /v1/sellers` |
| Listings — seller publish | **Done (cap/allergen gaps)** | `catalog/data/repositories/listings_repository.dart` (`getMyListings`, create, `setAvailability`); `add_product_controller.dart` real |
| Buyer feed / discovery | **Done (1 mock leak)** | `client_home.dart` uses `ListingsRepository.getFeed`; **leak:** public seller profile fed `SellerMockData.demoSeller()` (`client_home.dart:326`) |
| Dish detail + extras | **Partial** | `product_detail.dart` real listing, but seller info/reviews from `SellerMockData`; extras still demo (`docs/client-feedback.md` §3) |
| Geolocated map | **Done** | `map/presentation/.../map_controller.dart` → `ListingsRepository().getFeed`; `map_mock_data.dart` now **dead** |
| Cart | **Done (local by design)** | `cart/.../cart_controller.dart` in-memory cart |
| Checkout / payment | **Done** | real chain lives in `orders/`: `my_cart → order_summary → payment → order_confirmation`; `orders_repository.dart` + Stripe |
| `checkout` module | **Todo (dead stub)** | `checkout/presentation/screens/checkout.dart` = `Placeholder()`, unreferenced — delete or repurpose |
| Orders lifecycle | **Done (1 template leak + copy bug)** | `orders_repository.dart`, `order_tracking_controller.dart`; **leak:** `OrderMockData.demoOrder()` used as a template hydrated with real fields |
| Order tracking copy (pickup vs delivery) | **Partial (bug)** | same subtitle for both paths (`docs/client-feedback.md` §1.4) |
| Deliveries (driver) | **Partial** | `deliveries_repository.dart` real lifecycle; **leaks:** `today_stats_card` uses `delivery_driver_mock_data`; `incoming_order_controller._hydrateMock` overlays real data on a mock order |
| Live tracking (Socket.io) | **Done** | `core/services/.../tracking_socket_client.dart` registered in `general_bindings.dart` |
| Wallet & payouts | **Done** | `wallet_repository.dart` (`/wallet/me`, withdraw); `payout_onboarding_service.dart` (Stripe Connect) |
| Reviews & ratings | **Done** | `reviews_repository.dart` (`/orders/:id/review`, `/sellers/:id/reviews`) |
| Seller subscriptions (RevenueCat) | **Partial** | client code complete (`subscription_repository.dart`, `subscription_gate`); blocked on App Store Connect + dashboard config (`docs/qa/revenuecat-testing.md`) |
| Messaging / chat | **Done (orphan mock)** | `conversations_/messages_repository.dart` real; **dead:** `chat/.../chat_list.dart` mock |
| Push notifications | **Done** | `core/services/.../push_notification_service.dart` → `/v1/device-tokens`, taps open tracking |
| Moderation / reports | **Done** | `moderation/data/reports_repository.dart` → `POST /v1/reports` |
| Supply catalog (B2B) | **Done** | `supply_catalog/.../supply_catalog_repository.dart` → `/v1/catalog/*` |
| Settings / legal / theming | **Done** | `settings.dart`, `legal_documents_repository.dart`, `ThemeController` (light/dark) |
| Seller dashboard KPIs | **Partial (hardcoded)** | `seller/.../widgets/today_snapshot_card.dart` literal `'€34.50'` — not wired |
| Admin (KYC/disputes/strikes/stats) | **n/a here** | backend `/v1/admin/*`; UI in `incacook-admin` repo |

## Remaining real work (what's actually left)

**Mock / hardcoded leaks to remove**

- Public **seller profile** view fed `SellerMockData.demoSeller()`
  (`client_home.dart:326`, and seller info/reviews in `product_detail.dart`).
- Seller **dashboard KPIs** hardcoded (`today_snapshot_card.dart`).
- Driver **stats card** + incoming-order **filler** on mock
  (`delivery/.../today_stats_card.dart`, `incoming_order_controller._hydrateMock`).
- Order **template** still seeded from `OrderMockData.demoOrder()`.

**Compliance / UX rules (client blockers, `docs/client-feedback.md` §1–§4)**

- §1.2 Fait-maison **€4.50 hard input block** + helper text (verify
  `add_product_controller.dart`).
- §2.2 Mandatory **allergen declaration** + minimum description length.
- §1.4 Pickup-vs-delivery **tracking copy**.
- §1.5 **Facebook** login: a `facebook_email_completion` screen exists but the
  client reports login impossible — finish or remove the button.
- §1.3 Empty filters must show everything (verify against live feed).
- §3 Seller-declared **extras** pantry (backend table + `/sellers/me/extras` + UI).
- §4 Onboarding copy rewrite; §5.5 rename the "partage solitaire" rubric.

**Config / ops**

- RevenueCat: App Store Connect Paid-Apps agreement, fix swapped products in
  `traiteur` / `sauve_ton_panier`, set webhook auth token
  (`docs/qa/revenuecat-testing.md`).
- Re-enable phone OTP (`skipPhoneVerification`) when SMS provider is live.

**Dead-code cleanup**

- `lib/features/home/` (old nav tabs), `chat/.../chat_list.dart`,
  `client/data/client_mock_data.dart`, `map/data/map_mock_data.dart`, seller
  `order_request_mock_data` / `accepted_order_mock_data` /
  `seller_product_mock_data`, `checkout/.../checkout.dart` placeholder.

## Notable signals

- **No `TODO`/`FIXME`/"coming soon"** strings in the codebase. Unfinished work
  is signalled by `MockData` usage and the dead `checkout` `Placeholder`, not
  by comment markers. Several "hardcoded" comments document values that were
  *already replaced* with real data.
- App version `1.0.0+13`. Deps confirm the stack: `dio`, `get`,
  `flutter_stripe`, `purchases_flutter`, `google_maps_flutter`, `geolocator`,
  `firebase_messaging`, `socket_io_client`, `qr_flutter`, `mobile_scanner`.
