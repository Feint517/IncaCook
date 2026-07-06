/// Public Google OAuth client IDs used by native Google Sign-In.
///
/// `webClientId` is the server client ID Google uses to mint an ID token for
/// Supabase. `iosClientId` is the iOS app client ID used by the native iOS SDK.
/// Both are public OAuth identifiers, not secrets.
class GoogleAuthConfig {
  GoogleAuthConfig._();

  static const String webClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
    defaultValue:
        '623882469274-m407udagsoph90ttmt1fg35popv7h9fr.apps.googleusercontent.com',
  );

  static const String iosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
    defaultValue:
        '623882469274-h4uol69lflf0r39n8eg6t9lr2tpnsp6m.apps.googleusercontent.com',
  );

  static bool get isConfigured => webClientId.isNotEmpty;
}
