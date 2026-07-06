# QA - Supabase auth, Firebase project swap, Apple login, and DB reset

Step-by-step checklist for re-integrating auth and push config after changing
the Firebase project, then adding Sign in with Apple and resetting Supabase QA
data when a clean test run is needed.

Last updated: 2026-07-03.

Related docs:
- [full-user-journey-testing.md](full-user-journey-testing.md)
- [revenuecat-testing.md](revenuecat-testing.md)
- [../issues/payments-subscription-issues.md](../issues/payments-subscription-issues.md)

Sources checked while writing this runbook:
- Supabase Google provider:
  https://supabase.com/docs/guides/auth/social-login/auth-google
- Supabase Apple provider:
  https://supabase.com/docs/guides/auth/social-login/auth-apple
- Supabase mobile deep links:
  https://supabase.com/docs/guides/auth/native-mobile-deep-linking
- Supabase redirect URLs:
  https://supabase.com/docs/guides/auth/redirect-urls
- Firebase Android setup:
  https://firebase.google.com/docs/android/setup
- Firebase / FCM Flutter setup:
  https://firebase.google.com/docs/cloud-messaging/flutter/get-started

---

## 0. Current app facts

Use these as the ground truth before changing dashboards:

| Item | Current value / behavior |
|---|---|
| iOS bundle id | `com.incacook.app` |
| Android package | `com.incacook.app` |
| iOS signing team | `7DSQT22UZ7` |
| Supabase project | `https://eoxrrofpdtrwjbhywcvz.supabase.co` |
| Supabase OAuth callback | `incacook://auth/callback` |
| Complete-email callback | `incacook://auth/callback?flow=complete_email` |
| Firebase project currently in app files | `incacook-7b97c` |
| Google login path | Supabase hosted OAuth, not native Google Sign-In |
| Apple login path | Not exposed in the current welcome UI yet |

Important: the current Google button uses
`SupabaseOAuthService.signIn(OAuthProvider.google)`. That means Google auth is
configured in Supabase and Google Cloud. Firebase app files still matter for
push notifications, and for any Firebase product you later enable, but the
Google auth button itself does not use Firebase Auth or Android SHA
fingerprints.

---

## 1. Firebase project re-integration

Goal: make the mobile app and backend point at the new Firebase project, then
verify iOS/Android push can issue tokens and receive test notifications.

### 1.1 Create or verify the Firebase apps

1. Open Firebase Console -> the new project.
2. Add or verify the Android app:
   - Android package name: `com.incacook.app`
   - App nickname: `IncaCook Android`
   - SHA-1/SHA-256: optional for current hosted Supabase OAuth, but keep the
     release fingerprints recorded if you later enable Firebase Auth, Dynamic
     Links, or phone auth.
3. Add or verify the iOS app:
   - Bundle ID: `com.incacook.app`
   - App nickname: `IncaCook iOS`
   - App Store ID: optional until release metadata is final.
4. Confirm both Firebase apps are inside the same Firebase project you want the
   backend to use for FCM.

### 1.2 Replace app config files

1. Download the Android config from Firebase:
   - File name must be exactly `google-services.json`.
   - Put it at `android/app/google-services.json`.
2. Download the iOS config from Firebase:
   - File name must be exactly `GoogleService-Info.plist`.
   - Put it at `ios/Runner/GoogleService-Info.plist`.
   - If Xcode loses the file reference, open `ios/Runner.xcworkspace`, remove
     the old plist reference from Runner, then add the new plist to the Runner
     target with "Copy items if needed".
3. Verify both files point at the new project:
   ```bash
   jq -r '.project_info.project_id' android/app/google-services.json
   plutil -extract PROJECT_ID raw -o - ios/Runner/GoogleService-Info.plist
   ```
4. Confirm Android still applies the Google Services Gradle plugin:
   - `android/settings.gradle.kts` has `com.google.gms.google-services`.
   - `android/app/build.gradle.kts` applies `id("com.google.gms.google-services")`.

### 1.3 Configure iOS push in Apple and Firebase

1. Apple Developer -> Certificates, Identifiers & Profiles -> Identifiers.
2. Open the App ID for `com.incacook.app`.
3. Confirm the App ID has Push Notifications enabled.
4. Apple Developer -> Keys -> create or reuse an APNs Auth Key:
   - Enable Apple Push Notifications service.
   - Download the `.p8` file once.
   - Record Key ID and Team ID.
5. Firebase Console -> Project settings -> Cloud Messaging.
6. Under the iOS app configuration for `com.incacook.app`, upload the APNs key:
   - `.p8` file
   - Key ID
   - Team ID `7DSQT22UZ7`
7. In Xcode, confirm Runner has:
   - Push Notifications capability
   - Background Modes -> Remote notifications
8. In repo, confirm `ios/Runner/Info.plist` includes:
   ```xml
   <key>UIBackgroundModes</key>
   <array>
     <string>remote-notification</string>
   </array>
   ```
9. Build to a physical iPhone. Simulators do not prove real APNs delivery.

### 1.4 Configure backend Firebase Admin

Do not commit or paste the service account JSON into docs or source.

1. Firebase Console -> Project settings -> Service accounts.
2. Generate a new private key for Firebase Admin SDK.
3. In Railway, set the same Firebase Admin values on both API and worker:
   - `FIREBASE_PROJECT_ID`
   - `FIREBASE_CLIENT_EMAIL`
   - `FIREBASE_PRIVATE_KEY`
4. Preserve private-key newlines exactly. If Railway requires a single-line env
   value, use escaped `\n` newlines and confirm the backend parser expects that.
5. Redeploy API and worker.
6. QA smoke test:
   - Install a fresh app build.
   - Accept notification permission.
   - Confirm the app registers an FCM token and the backend records platform
     `IOS` or `ANDROID`.
   - Send a Firebase Console test notification to the token.

---

## 2. Re-integrate Google auth in Supabase

Goal: after the Firebase/Google Cloud project change, the "Continue with
Google" button still opens the hosted Google account chooser and returns to the
app through `incacook://auth/callback`.

### 2.1 Google Cloud / Google Auth Platform

1. Open Google Cloud Console for the same project behind the new Firebase
   project.
2. Go to Google Auth Platform.
3. Configure Audience / consent screen:
   - App name: `IncaCook`
   - Support email: a real monitored account
   - Scopes: `openid`, `.../auth/userinfo.email`,
     `.../auth/userinfo.profile`
   - Test users: add your QA Google accounts while the app is in testing mode.
4. Go to Clients -> Create OAuth client.
5. Application type: Web application.
6. Name: `IncaCook Supabase Auth`.
7. Authorized redirect URI:
   ```text
   https://eoxrrofpdtrwjbhywcvz.supabase.co/auth/v1/callback
   ```
   If Supabase shows a different callback URL in the Google provider page, use
   the dashboard value exactly.
8. Save the Web client ID and client secret.

### 2.2 Supabase dashboard

1. Supabase Dashboard -> project `eoxrrofpdtrwjbhywcvz`.
2. Authentication -> Providers -> Google.
3. Enable Google.
4. Paste the Google Web client ID and client secret.
5. Save.
6. Authentication -> URL Configuration -> Redirect URLs.
7. Add these exact app redirects:
   ```text
   incacook://auth/callback
   incacook://auth/callback?flow=complete_email
   ```
8. Keep the Site URL set to a real HTTPS app/admin URL if available. The mobile
   flow relies on the Redirect URLs above.

### 2.3 App verification

1. Confirm native deep links are registered:
   - iOS: `ios/Runner/Info.plist` includes scheme `incacook`.
   - Android: `android/app/src/main/AndroidManifest.xml` has an intent-filter
     for scheme `incacook`, host `auth`, path `/callback`.
2. Run the app.
3. Tap Google.
4. Expected logs:
   - `[Auth][Google] starting Supabase OAuth`
   - `[DeepLink] received`
   - `[Auth][Google] callback/session received: true`
   - backend `POST /v1/auth/oauth/sync` succeeds
5. If the browser shows `redirect_uri_mismatch`, fix the Google Cloud OAuth
   client's authorized redirect URI.
6. If the app never returns from the browser, fix Supabase Redirect URLs or the
   native deep-link registration.

---

## 3. Set up Sign in with Apple

Goal: enable Apple in Supabase and prepare the app work needed to expose an
Apple login button.

### 3.1 Apple Developer setup

1. Apple Developer -> Certificates, Identifiers & Profiles -> Identifiers.
2. Open or create the App ID for bundle `com.incacook.app`.
3. Enable "Sign in with Apple" on that App ID.
4. Create a Services ID, for example:
   ```text
   com.incacook.app.signin
   ```
5. Configure the Services ID:
   - Primary App ID: `com.incacook.app`
   - Web domain:
     ```text
     eoxrrofpdtrwjbhywcvz.supabase.co
     ```
   - Return URL:
     ```text
     https://eoxrrofpdtrwjbhywcvz.supabase.co/auth/v1/callback
     ```
6. Apple Developer -> Keys -> create a Sign in with Apple key.
7. Download and store the `.p8` key securely.
8. Record:
   - Team ID: `7DSQT22UZ7`
   - Key ID
   - Services ID
   - `.p8` private key

Apple OAuth client secrets expire. Set a reminder to rotate the generated
Apple client secret before its expiry.

### 3.2 Supabase Apple provider

1. Supabase Dashboard -> Authentication -> Providers -> Apple.
2. Enable Apple.
3. Client ID: the Services ID, for example `com.incacook.app.signin`.
4. Generate the Apple client secret using Supabase's Apple provider tool or your
   own JWT generator from:
   - Team ID
   - Key ID
   - Services ID
   - `.p8` private key
5. Paste the generated client secret.
6. Save.
7. Confirm Supabase Redirect URLs still include:
   ```text
   incacook://auth/callback
   incacook://auth/callback?flow=complete_email
   ```

### 3.3 App work still needed

The current app has Google and Facebook buttons only. To expose Apple login:

1. Add an Apple button/icon to the welcome social row.
2. Add `WelcomeController.signInWithApple()` that calls the existing shared
   flow with:
   ```dart
   provider: OAuthProvider.apple
   ```
3. In `SupabaseOAuthService._scopesFor`, return Apple scopes if needed:
   ```dart
   if (provider == OAuthProvider.apple) return 'name email';
   ```
4. Keep `redirectTo: SupabaseConfig.oauthRedirectUrl`; Apple should use the same
   `incacook://auth/callback` return path as Google/Facebook.
5. Keep the existing backend sync path:
   - persist Supabase session tokens
   - call `POST /v1/auth/oauth/sync`
   - run `PostAuthRouter.decide()`
6. QA on a real iPhone signed into an Apple ID:
   - first Apple login may return relay email and name
   - later Apple logins may not return full name again
   - if the user hides email, verify onboarding still sees a usable relay email

---

## 4. Empty Supabase data for QA

Use this only for non-production QA data unless the whole team explicitly agrees
to wipe production. Always back up first.

### 4.1 Choose the correct reset level

| Need | Use |
|---|---|
| Local clean state | `supabase db reset` in the local/backend setup |
| Hosted QA data wipe, keep schema/migrations | Dashboard SQL purge below |
| Hosted QA full rebuild from migrations | `supabase db reset --linked` only after backup and confirmation |

### 4.2 Backup first

Recommended before any hosted reset:

1. Supabase Dashboard -> Database -> Backups, confirm a recent backup exists.
2. Export critical tables or run a CLI dump if the project is linked:
   ```bash
   supabase db dump --linked --file supabase-backup-before-qa-reset.sql
   ```
3. Tell anyone testing that active sessions may keep working until their JWT
   expires. Deleting a Supabase user does not immediately invalidate already
   issued JWTs.

### 4.3 Hosted QA purge that keeps schema

This clears app data while preserving tables, functions, RLS policies, and
Prisma migration history.

1. Supabase Dashboard -> SQL Editor -> New query.
2. Run the dry-run count first:
   ```sql
   select schemaname, tablename
   from pg_tables
   where schemaname = 'public'
     and tablename not in ('_prisma_migrations', 'spatial_ref_sys')
   order by tablename;
   ```
3. If the table list is correct, run the purge:
   ```sql
   begin;

   -- Delete storage objects first so auth users that own objects can be removed.
   delete from storage.objects;

   -- Truncate all app-owned public tables, but keep migration history.
   do $$
   declare
     truncate_sql text;
   begin
     select 'truncate table ' ||
       string_agg(format('%I.%I', schemaname, tablename), ', ') ||
       ' restart identity cascade'
     into truncate_sql
     from pg_tables
     where schemaname = 'public'
       and tablename not in ('_prisma_migrations', 'spatial_ref_sys');

     if truncate_sql is not null then
       execute truncate_sql;
     end if;
   end $$;

   -- Remove Supabase Auth users last. Existing JWTs remain valid until expiry.
   delete from auth.users;

   commit;
   ```
4. Verify:
   ```sql
   select count(*) as auth_users from auth.users;

   select schemaname, tablename, n_live_tup
   from pg_stat_user_tables
   where schemaname = 'public'
   order by tablename;
   ```
5. Recreate required storage buckets if your purge or a later reset removed
   them. Current app flows expect buckets such as `avatars`, `listings`, and
   KYC/document buckets configured by the backend/local setup.
6. Restart the app or sign out test devices. For a hard QA reset, uninstall the
   app so local secure storage cannot reuse an old token.

### 4.4 Full hosted rebuild from migrations

Use this only when the schema itself is dirty and you want the remote database
to match local migrations.

1. Confirm the target Supabase project is not production.
2. Create a backup.
3. Link the Supabase CLI to the correct project.
4. Run:
   ```bash
   supabase db reset --linked
   ```
5. Re-apply backend migrations/seeds if the backend owns Prisma migrations.
6. Recreate storage buckets and policies.
7. Re-run the full signup QA journey.

Supabase's CLI docs state that a linked/db-url reset drops user-created remote
database entities and reapplies local migrations. Treat it as destructive.

---

## 5. Final smoke checklist

- [ ] `android/app/google-services.json` project id matches the new Firebase
      project.
- [ ] `ios/Runner/GoogleService-Info.plist` project id matches the new Firebase
      project.
- [ ] Firebase Cloud Messaging has APNs key uploaded for `com.incacook.app`.
- [ ] Railway API and worker have the new Firebase Admin env values.
- [ ] Supabase Google provider uses the new Google Cloud Web OAuth client.
- [ ] Google Cloud OAuth redirect URI is
      `https://eoxrrofpdtrwjbhywcvz.supabase.co/auth/v1/callback`.
- [ ] Supabase Redirect URLs include both `incacook://auth/callback` variants.
- [ ] Google login returns to the app and backend OAuth sync succeeds.
- [ ] Apple Developer App ID and Services ID are configured.
- [ ] Supabase Apple provider is enabled with a fresh client secret.
- [ ] Apple button/app code is implemented before marking Apple login done.
- [ ] QA DB reset path was chosen intentionally and backed up first.
