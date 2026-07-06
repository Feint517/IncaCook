# Requirements — accounts, keys, secrets & access

What we need (accounts to open, access to grant, credentials to hand over) to
finish integrating IncaCook and go to production. Forward this to the client
as-is. Companion: the issue register in
[../issues/payments-subscription-issues.md](../issues/payments-subscription-issues.md).

Last updated: 2026-07-01.

Legend: ✅ **blocks the urgent 🔴 fixes** · 🟡 needed soon · ⚪ optional/decision.

---

## 1. Accounts to OPEN (don't exist yet)

| Account | Why | Notes |
|---|---|---|
| 🟡 **Firebase project** | Push notifications (FCM). Backend uses `firebase-admin`; iOS needs APNs. | Provide backend **service-account JSON** + upload an **APNs auth key** to Firebase + `GoogleService-Info.plist` for iOS. `google-services.json` (Android) already present. |
| 🟡 **Railway — production environment** | Separate prod env mirroring dev settings, holding all secrets below. | Distinct from the current dev/prod-mixed deploy. |
| 🟡 **Google Play Console** (developer, $25 one-time) | Android IAP subscriptions + Android payouts. | App created with package `com.incacook.app`. |
| 🟡 **Google Cloud service account** (in the Play/GCP project) | Lets RevenueCat validate Play purchases. | Download JSON → RevenueCat. ~36h to propagate. |
| ✅ **Stripe Connect activation** (on existing Stripe account) | Express payouts to sellers/drivers. | Confirm Connect **enabled** for country **FR**. |
| ⚪ **Apple Pay merchant ID + cert / PayPal Business** | Only if those payment methods are meant to be real (today they're demo). | Otherwise remove them from the payment UI. |

## 2. Access to GRANT us (accounts that already exist)

| Service | What we need | Unblocks |
|---|---|---|
| ✅ **Stripe** | Dashboard access **or** the keys below; configure the webhook to listen to **connected-account `account.updated`**. | ISSUE-2, ISSUE-3, payouts |
| ✅ **RevenueCat** | Dashboard access **or** the `sk_` secret key; set a **webhook auth token**; add the **Android app** + `goog_` key. | ISSUE-1, Android |
| ✅ **Supabase** | Project access to set the **`listings` storage bucket** `file_size_limit` + `allowed_mime_types`. | ISSUE-9 (photo upload) |
| 🟡 **App Store Connect** | **App Manager** role: finish `traiteur`/`sauve_ton_panier` product localization, fix swapped products, copy the **App-Specific Shared Secret** into RevenueCat. | ISSUE-5, iOS validation |
| ✅ **Railway** | Access to set env vars **or** the client sets the values we compute. | all backend config |

## 3. Keys / secrets / env vars needed

### Backend (Railway env)
| Var | Status | For |
|---|---|---|
| `STRIPE_SECRET_KEY` | confirm present | Stripe API |
| `STRIPE_WEBHOOK_SECRET` | ✅ **needed** — from the endpoint w/ connected-account events | ISSUE-3 |
| `STRIPE_ONBOARDING_RETURN_URL` / `..._REFRESH_URL` | ✅ set to the new `incacook://` bridge routes | ISSUE-2 |
| `REVENUECAT_WEBHOOK_AUTH_TOKEN` | ✅ **needed** (generate) | ISSUE-1 |
| `REVENUECAT_SECRET_API_KEY` (`sk_`) | ✅ **needed** | ISSUE-1 |
| Firebase service-account JSON / creds | 🟡 needed | Push (prod) |
| Mapbox **server** token (Geocoding API) | 🟡 needed | GAP-9 geocoding |
| `RESEND_API_KEY` + verified domain | 🟡 needed | GAP-10 email |
| Twilio creds | ⚪ optional | GAP-11 generic SMS |

### Client (`.vscode/dart_defines.json` — public values only)
| Var | Status | For |
|---|---|---|
| `REVENUECAT_ANDROID_KEY` (`goog_`) | 🟡 **empty** — needed | Android IAP |
| `REVENUECAT_IOS_KEY` (`appl_`) | ✅ set | iOS IAP |
| `STRIPE_PUBLISHABLE_KEY` (`pk_`) | ✅ set (test) | payments |
| `MAPBOX_PUBLIC_TOKEN` (`pk.`) | ✅ set | maps |
| `SUPABASE_URL` / `SUPABASE_ANON_KEY` / `API_BASE_URL` | ✅ set | core |

> iOS device builds also need a Mapbox **`sk.` DOWNLOADS:READ** token in `~/.netrc`
> to fetch the native SDK at build time (build-machine only, not shipped).

## 4. Decisions the client must make

1. **Subscription source of truth** — RevenueCat-only on mobile, or keep the Stripe card subscription too? (Both write the same fields — ISSUE-4.)
2. **Test vs production cutover** — validate in sandbox/test first, then swap to live keys?
3. **Apple Pay / PayPal** — make real or remove from the payment UI (GAP-2).
4. **Map provider** — keep Mapbox or move to Google/Firebase (see ISSUE-19). Affects the geocoding fix (GAP-9).
5. **Android release keystore** — client owns & holds it, or we generate and hand over? (Play App Signing recommended.)
6. **Support email** — confirm `support@incacook.app` or replace.

## 5. Fastest urgent path

Getting **§2 Stripe + RevenueCat + Supabase** (all ✅, ~15 min in dashboards)
unblocks closing **ISSUE-1 / ISSUE-2 / ISSUE-3 / ISSUE-9** end-to-end. The
credential-free code work can start in parallel.
</content>
