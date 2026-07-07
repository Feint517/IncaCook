# Note — Driver background persistence during an Active delivery (frontend)

Status: **implemented; on-device verification pending.** Captured during the
online-presence design (see
`docs/adr/0002-driver-online-presence-and-heartbeat.md`).

## Implementation (as shipped)

Chose **geolocator's native background location** over adding
`flutter_foreground_task` (the suich_drive pattern): geolocator is already a
dependency and covers the requirement directly, with a leaner native surface.
`LocationService.start(background: true)` (called from
`DeliveryRouteController.bootstrap` for the Active delivery only) uses an
Android LOCATION foreground service + persistent notification and iOS
`allowBackgroundLocationUpdates`; the existing throttled push loop keeps
running while backgrounded. Idle-online stays foreground-only. Added Android
`FOREGROUND_SERVICE[_LOCATION]` permissions + the iOS `location` background
mode. **Still needs device testing** — foreground-service behaviour, the
permission escalation to "Always", and background push can't be exercised in CI.

## What

While a driver has an **Active delivery** (see `CONTEXT.md`), the app must keep
running and heartbeating even when backgrounded, so Live tracking to the buyer
doesn't go dark and the driver can't accidentally "disappear" mid-delivery. The
plan is to use a **persistent / foreground notification** (Android foreground
service; iOS background location + `remote-notification`) to hold the app alive
for the duration of the Active delivery only.

Scope note: this is **only for the Active-delivery state**, not idle-online.
Idle-online deliberately tolerates backgrounding and relies on FCM-token
reachability (per ADR-0002) — no foreground service there, to save battery.

## Reference implementation

Model the frontend approach on the existing driver app in the sibling project:

`/Users/macbookpro/Documents/Projects/suich-mobile` → `apps/suich_drive`

Study how it wires the foreground service / persistent notification, background
location, and lifecycle so the delivery keeps tracking when the app is not in
the foreground. Reuse that pattern here rather than inventing one.

## When

Do this later — after the server-side pieces from ADR-0001 / ADR-0002 land
(one-active-per-driver guard, cron expiry, pre-pickup ETA timeout, cadence
changes). This note is the reminder + the pointer.

## Related

- `docs/adr/0002-driver-online-presence-and-heartbeat.md` — heartbeat cadence,
  loose expiry, two-clocks separation.
- `docs/adr/0001-pre-pickup-timeout-eta-source.md` — pre-pickup watchdog.
- `CONTEXT.md` — Heartbeat vs Live tracking vs Delivery watchdog.
