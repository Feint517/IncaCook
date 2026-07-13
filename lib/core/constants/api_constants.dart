import 'package:flutter/foundation.dart';

/// Backend API configuration.
///
/// [baseUrl] is resolved at build time from `--dart-define`s, in priority
/// order:
///   1. `API_BASE_URL`     — explicit override. Use for staging / prod, e.g.
///        --dart-define=API_BASE_URL=https://incacook-api-production-146b.up.railway.app
///   2. `LAN_API_BASE_URL` — your PC's IPv4, for testing on a **real phone**
///        on the same Wi-Fi, e.g.
///        --dart-define=LAN_API_BASE_URL=http://192.168.1.20:3000
///   3. platform-local default (no define):
///        - Android emulator : http://10.0.2.2:3000  (host loopback alias)
///        - other (iOS sim…) : http://localhost:3000
///
/// A real device can reach neither 10.0.2.2 nor localhost, so it MUST pass
/// `LAN_API_BASE_URL` (or `API_BASE_URL`). Likewise, **production builds MUST
/// pass `--dart-define=API_BASE_URL=https://…`** — the no-define default is
/// intentionally local for development.
///
/// All routes are prefixed with `/v1/`.
class ApiConstants {
  ApiConstants._();

  /// Explicit override — wins over everything. Empty string when not passed.
  /// The argument is the dart-define KEY name, e.g.
  /// `--dart-define=API_BASE_URL=https://incacook-api-production-146b.up.railway.app`.
  static const String _apiBaseUrlOverride = String.fromEnvironment('API_BASE_URL');

  /// LAN/IPv4 override for real-device testing. Empty string when not passed.
  /// e.g. `--dart-define=LAN_API_BASE_URL=http://192.168.100.94:3000`.
  static const String _lanApiBaseUrl = String.fromEnvironment('LAN_API_BASE_URL');

  /// Resolved once (lazily, on first read — after the binding is initialised,
  /// so [defaultTargetPlatform] is valid). It's just a host URL, never a
  /// secret, so it's safe to log at startup.
  static final String baseUrl = _resolveBaseUrl();

  static String _resolveBaseUrl() {
    if (_apiBaseUrlOverride.isNotEmpty) return _apiBaseUrlOverride;
    if (_lanApiBaseUrl.isNotEmpty) return _lanApiBaseUrl;
    return _defaultLocalBaseUrl;
  }

  /// Emulator/simulator-friendly default when no override is supplied.
  static String get _defaultLocalBaseUrl {
    // 10.0.2.2 is the Android emulator's alias for the host machine's
    // loopback; every other platform (iOS simulator, desktop) uses localhost.
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }

  static const String apiPrefix = '/v1';

  /// Supabase storage base for **public-bucket** object URLs. The stored
  /// `imageUrls` on a listing are `<bucket>/<path>`, so the public URL is
  /// `${supabaseStorageBaseUrl}/${storagePath}`.
  ///
  /// Defaults to the Android-emulator-friendly local Supabase address
  /// (port 54331 mirrors the backend's `SUPABASE_URL`). Override via
  /// `--dart-define=SUPABASE_STORAGE_BASE_URL=...` for staging / prod,
  /// and for the iOS simulator use `http://127.0.0.1:54331/...`.
  ///
  ///
  // static const String supabaseStorageBaseUrl = String.fromEnvironment(
  //   'SUPABASE_STORAGE_BASE_URL',
  //   // defaultValue: 'http://10.0.2.2:54331/storage/v1/object/public',
  //   defaultValue: 'https://eoxrrofpdtrwjbhywcvz.supabase.co/storage/v1/object/public',
  // );

  static const String supabaseStorageBaseUrl =
      'https://eoxrrofpdtrwjbhywcvz.supabase.co/storage/v1/object/public';

  /// Resolves a stored listing image path (`<bucket>/<path>`) to a
  /// fetchable HTTPS URL via [supabaseStorageBaseUrl]. Returns null for an
  /// empty path so callers can fall through to a placeholder.
  static String? publicImageUrl(String? storagePath) {
    if (storagePath == null || storagePath.isEmpty) return null;
    return '$supabaseStorageBaseUrl/$storagePath';
  }
}
