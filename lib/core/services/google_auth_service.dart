import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Thin wrapper around the `google_sign_in` plugin.
///
/// Single responsibility: prompt the OS account picker and return a
/// Google **ID token** the backend can forward to Supabase via
/// `POST /v1/auth/google`. The app never talks to Google over HTTP —
/// see `docs/flutter-integration.md` §"Google Sign-In" for the full
/// rationale.
///
/// Configuration lives here so client IDs are set in exactly one
/// place. They're sourced from `--dart-define` (consistent with
/// `MAPBOX_PUBLIC_TOKEN` / `API_BASE_URL`), falling back to the team's
/// published values from `docs/flutter-integration.md`.
///
/// **Audience caveat (iOS).** The integration doc claims `serverClientId`
/// controls the `aud` of the returned ID token. That's true on Android
/// — but on iOS, Google Sign-In SDK 8.x ignores it for the ID token
/// (only `serverAuthCode` is signed for `serverClientId`). The ID
/// token's `aud` is always the iOS OAuth client (`GIDClientID` from
/// Info.plist). Supabase therefore needs the iOS *and* Android client
/// IDs registered as additional accepted audiences for the Google
/// provider in `supabase/config.toml`, alongside the Web client ID.
/// Otherwise iOS sign-in returns 400 `Unacceptable audience in id_token`.
class GoogleAuthService extends GetxService {
  GoogleAuthService({GoogleSignIn? plugin})
      : _plugin = plugin ??
            GoogleSignIn(
              serverClientId: _webClientId,
              scopes: const ['email', 'profile'],
            );

  static GoogleAuthService get instance => Get.find();

  static const String _webClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
    defaultValue:
        '850527183709-ejcjec7majq565uo473n601ek9kj2ic5.apps.googleusercontent.com',
  );

  final GoogleSignIn _plugin;

  /// Triggers the native account picker.
  ///
  /// Returns the ID token to forward to `POST /v1/auth/google`. Throws
  /// [GoogleSignInCancelled] when the user dismisses the sheet, or
  /// [GoogleSignInException] for any other plugin-level failure. Higher
  /// layers should branch on those so cancellation stays silent while
  /// real failures surface a toast.
  Future<String> signIn() async {
    GoogleSignInAccount? account;
    try {
      account = await _plugin.signIn();
    } on Exception catch (e) {
      throw GoogleSignInException(e.toString());
    }
    if (account == null) throw const GoogleSignInCancelled();

    final auth = await account.authentication;
    final idToken = auth.idToken;
    if (idToken == null || idToken.isEmpty) {
      // Most often a misconfigured `serverClientId` (wrong project /
      // wrong Web client). The backend will respond with 400 "Bad ID
      // token" if we still post; failing earlier here gives a clearer
      // signal.
      throw const GoogleSignInException(
        'Google did not return an ID token. '
        'Check serverClientId matches the Web client in Google Cloud.',
      );
    }
    return idToken;
  }

  /// Signs the device's account out of the plugin's cache. Called from
  /// [SignOutService] so the next `signIn` shows the picker again
  /// instead of silently reusing the previous account.
  Future<void> signOut() async {
    await _plugin.signOut();
  }
}

/// Thrown when the user dismissed the Google account picker. Treat as
/// a no-op at the UI layer — no error toast.
class GoogleSignInCancelled implements Exception {
  const GoogleSignInCancelled();

  @override
  String toString() => 'GoogleSignInCancelled';
}

/// Plugin-level failure — usually misconfiguration (wrong client ID,
/// missing iOS URL scheme, unregistered Android SHA-1).
class GoogleSignInException implements Exception {
  const GoogleSignInException(this.message);
  final String message;

  @override
  String toString() => message;
}
