/// Google Maps Platform client configuration.
///
/// This is a public mobile/web-service key used by the Flutter app for Maps
/// SDK rendering plus address search / route preview calls. Restrict it in
/// Google Cloud by application (Android package + SHA / iOS bundle id) and API.
/// The backend must use its own server-side `GOOGLE_MAPS_API_KEY` env value for
/// Geocoding API calls; never reuse a backend-only key in the app.
class GoogleMapsConfig {
  GoogleMapsConfig._();

  static const String apiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: '',
  );

  static bool get isConfigured => apiKey.isNotEmpty;

  static const String missingKeyMessage =
      'Google Maps API key is missing. Pass '
      '--dart-define=GOOGLE_MAPS_API_KEY=your_public_mobile_key.';
}
