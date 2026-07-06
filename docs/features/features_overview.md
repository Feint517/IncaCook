# IncaCook Feature Overview

Sources: the Flutter app under `lib/features/*`, the ground-truth wiring doc
`docs/backend-communication.md`, the signup contract `docs/signup-flow.md`,
the client review `docs/client-feedback.md`, the RevenueCat QA in
`docs/qa/revenuecat-testing.md`, and the backend (`IncaCook-Server`) module
+ controller surface (`src/modules/*`, `prisma/schema.prisma`).

## Current Product State

The **backend is ~95% complete** (git tag `df36447 backend ready 95%`):
the full marketplace, delivery, payments, wallet, moderation, messaging,
subscriptions, and admin surface is implemented with tests. The **mobile
app is ~90% wired** (app version `1.0.0+13`): authentication, the multi-role
signup wizard, profiles/KYC/charters/uploads, listings (seller publish +
buyer feed), the map, the full order→pay→track chain, deliveries, wallet,
subscriptions, reviews, moderation, messaging, supply catalog, and settings
all talk to the backend. What remains is a short list of **mock leaks,
hardcoded dashboard widgets, compliance/UX rules, store-side config, and
dead-code cleanup** — not "build the marketplace".

> ⚠️ `docs/backend-communication.md` is a **dated snapshot** and still
> describes listings/feed/map/orders as mock-backed. A live code read shows
> they are now wired; this overview and `docs/FEATURE-ASSESSMENT.md` reflect
> the **code**.

## Feature Inventory

States below are from a live read of `lib/features/*` (Done / Partial / Todo).

| Phase | Feature area | Mobile module(s) | Mobile state | Backend endpoints (exist) |
|---|---|---|---|---|
| 1 | Auth (email/password, Google) | `authentication` | **Done** | `POST /v1/auth/{signup,signin,google,oauth/sync,refresh,signout,password/*,phone/*,email/*,social/email/*}` |
| 1 | Signup wizard (buyer/seller/driver, 2 gates) | `authentication`, `onboarding` | **Done** | `POST /v1/users`, `GET /v1/users/me/onboarding`, role PUTs |
| 1 | Profile / addresses / charters / KYC / uploads | `authentication`, `settings`, `legal` | **Done** | `GET/PATCH /v1/users/me`, `PUT /v1/users/me/addresses/:kind`, `POST /v1/users/me/charters`, `/v1/kyc/documents`, `/v1/uploads`, `/v1/charters/active`, `/v1/legal-documents/active` |
| 1 | Buyer prefs (dietary/allergens) | `client`, `authentication` | **Done** | `PUT /v1/buyers/me/preferences` |
| 1 | Seller profile/business/cuisines | `seller`, `authentication` | **Done** | `PUT /v1/sellers/me/{profile,business,cuisines}` |
| 1 | Driver vehicle/zones | `delivery`, `authentication` | **Done** | `PUT /v1/drivers/me/{vehicle,zones}` |
| 1 | Kitchens feed (buyer → sellers) | `client` | **Done** | `GET /v1/sellers` |
| 1 | Listings — seller publish | `catalog`, `seller` | **Done** — `ListingsRepository` wired (`getMyListings`, create, `setAvailability`); **gaps:** €4.50 cap + allergen UI rules | `POST/GET/PATCH/DELETE /v1/listings`, `GET /v1/sellers/me/listings`, bookmarks |
| 1 | Buyer feed / discovery | `client`, `catalog` | **Done** — `ListingsRepository.getFeed`; **leak:** public seller profile fed `SellerMockData` | `GET /v1/listings`, `GET /v1/sellers` |
| 1 | Dish detail + extras | `catalog` | **Partial** — real listing; seller info/reviews + extras still mock/demo | `GET /v1/listings/:id` (+ requested `sellers/me/extras`, not built) |
| 1 | Geolocated discovery (map) | `map` | **Done** — `ListingsRepository().getFeed`; `MapMockData` now dead | `GET /v1/listings` (PostGIS), `GET /v1/sellers` |
| 1 | Cart | `cart` | **Done** — local in-memory by design | n/a |
| 1 | Checkout / payment chain | `orders`, `payments` | **Done** — `my_cart→order_summary→payment→confirmation`; `checkout` module is a dead `Placeholder()` stub | `POST /v1/orders`, `POST /v1/orders/:id/confirm-payment` |
| 1 | Orders (lifecycle) | `orders` | **Done** — full chain wired; **leak:** order seeded from `OrderMockData` template; **bug:** pickup-vs-delivery copy | `POST /v1/orders`, `GET /v1/orders/me`, `GET /v1/sellers/me/orders`, lifecycle + QR + tracking + disputes |
| 1 | Deliveries (driver) | `delivery` | **Partial** — real lifecycle; **leaks:** `today_stats_card` mock + `_hydrateMock` filler | `/v1/drivers/me/{online,location,deliveries,deliveries/:id/{claim,arrive-pickup,confirm-pickup,confirm-delivery,confirm-absent-dropoff,report-*}}` |
| 1 | Live tracking (websocket) | `core/services`, `orders` | **Done** — `tracking_socket_client` registered | `tracking.gateway.ts` (Socket.io) + `GET /v1/orders/:id/tracking` |
| 1 | Wallet & payouts | `wallet`, `payments` | **Done** | `GET /v1/wallet/me`, `POST /v1/wallet/me/withdraw`, `POST /v1/stripe/onboarding/account-link` |
| 1/2 | Reviews & ratings | `reviews` | **Done** | `POST /v1/orders/:orderId/review`, `GET /v1/sellers/:id/{reviews,stats}` |
| 2 | Seller subscriptions (RevenueCat) | `subscriptions` | **Partial** — client complete; store/dashboard config pending | `GET/POST /v1/sellers/me/subscription`, `POST .../portal`, `.../sync`, `POST /v1/webhooks/revenuecat` |
| 2 | Messaging / chat | `chat` | **Done** — `conversations_list`/`chat` real; orphan `chat_list` mock dead | `/v1/conversations`, `/v1/conversations/:id/messages`, `.../read` |
| 2 | Notifications (push) | `core/services` | **Done** — FCM wired, taps open tracking | `POST/DELETE /v1/device-tokens`, `POST /v1/notifications/test` |
| 2 | Moderation / reports | `moderation` | **Done** | `POST /v1/reports` (+ admin) |
| X | Supply catalog (B2B) | `supply_catalog` | **Done** | `/v1/catalog/products`, `/v1/catalog/orders`, `/v1/catalog/claims` (+ admin) |
| X | Settings / theming / legal | `settings`, `legal`, `bootstrap` | **Done** — light/dark theme, GetStorage | n/a (client-side) + `legal-documents` |
| 1 | Seller dashboard KPIs | `seller` | **Partial** — `today_snapshot_card` hardcoded `'€34.50'` | (no endpoint wired; `/v1/admin/dashboard/*` is admin-only) |
| Admin | KYC review, disputes, strikes, stats, users, catalog-claims | n/a (separate `incacook-admin` repo) | n/a in this app | `/v1/admin/*` (full surface) |

> Dead/orphan modules to clean up: `lib/features/home/`,
> `chat/.../chat_list.dart`, `client/data/client_mock_data.dart`,
> `map/data/map_mock_data.dart`, seller `*_mock_data.dart`, and the
> `checkout` `Placeholder()` screen.

## Backend module surface (for reference)

`auth`, `users` (+ onboarding), `buyers`, `sellers` (+ buyer-facing feed),
`drivers`, `listings` (+ bookmarks), `catalog` (+ admin), `orders`,
`deliveries`, `payments` (stripe onboarding/webhook + revenuecat webhook),
`wallets`, `subscriptions`, `reviews`, `messaging`, `notifications`
(device-tokens), `moderation` (reports + admin), `tracking` (Socket.io),
`compliance` (charters, kyc, legal-documents), `files` (uploads),
`strikes`, `admin` (disputes, kyc, notifications, stats dashboard, strikes,
users, catalog-claims, legal-documents). Placeholder-only modules with no
controller: `boosts`, `geo`, `search`.

## Recommended Reading Order

1. `docs/prd/prd.md` — product intent and scope.
2. `docs/FEATURE-ASSESSMENT.md` — code-vs-intent, mock-vs-real verdict.
3. `docs/backend-communication.md` — exact mobile↔backend wire contract.
4. `docs/signup-flow.md` — signup wizard + endpoint reference.
5. `docs/client-feedback.md` — current client blockers and requests.
6. `docs/specs/` — per-feature condensed specs (current behavior + gaps).
7. `docs/tasks/board.md` — the build-task backlog.
