import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// Secure storage for the auth tokens.
///
/// Tokens MUST never live in `SharedPreferences` / `GetStorage` — those
/// are world-readable on rooted / jailbroken devices. `FlutterSecureStorage`
/// maps to Keychain on iOS and EncryptedSharedPreferences on Android.
class TokenStorage extends GetxService {
  TokenStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage(
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );

  static TokenStorage get instance => Get.find();

  static const _kAccessToken = 'incacook.access_token';
  static const _kRefreshToken = 'incacook.refresh_token';
  static const _kExpiresAt = 'incacook.expires_at';
  // Auth identity (email + OAuth name claims) lives next to the tokens
  // because they're created together (`Session.user.*` is part of every
  // auth response) and share a lifetime — clearing tokens always means
  // clearing the identity. Persisted so `UserController` can rehydrate
  // its `authEmail` / `authFirstName` / `authLastName` after hot
  // restart for the NoProfile path, where there's no User row to read.
  static const _kAuthEmail = 'incacook.auth_email';
  static const _kAuthFirstName = 'incacook.auth_first_name';
  static const _kAuthLastName = 'incacook.auth_last_name';

  final FlutterSecureStorage _storage;

  Future<String?> readAccessToken() => _storage.read(key: _kAccessToken);
  Future<String?> readRefreshToken() => _storage.read(key: _kRefreshToken);
  Future<String?> readAuthEmail() => _storage.read(key: _kAuthEmail);

  /// Reads every persisted auth-identity slot in a single roundtrip
  /// (three parallel Keychain reads). Returned as a value record so
  /// `UserController.hydrateFromStorage` can populate its reactive
  /// fields without three separate calls.
  Future<({String? email, String? firstName, String? lastName})>
      readAuthIdentity() async {
    final values = await Future.wait([
      _storage.read(key: _kAuthEmail),
      _storage.read(key: _kAuthFirstName),
      _storage.read(key: _kAuthLastName),
    ]);
    return (
      email: values[0],
      firstName: values[1],
      lastName: values[2],
    );
  }

  Future<int?> readExpiresAt() async {
    final raw = await _storage.read(key: _kExpiresAt);
    if (raw == null) return null;
    return int.tryParse(raw);
  }

  /// [email] / [firstName] / [lastName] are optional so the silent-
  /// refresh path in [AuthInterceptor] (which only knows new tokens,
  /// not user info) can keep the existing stored identity instead of
  /// overwriting it with null.
  Future<void> writeTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresAt,
    String? email,
    String? firstName,
    String? lastName,
  }) async {
    await Future.wait([
      _storage.write(key: _kAccessToken, value: accessToken),
      _storage.write(key: _kRefreshToken, value: refreshToken),
      _storage.write(key: _kExpiresAt, value: expiresAt.toString()),
      if (email != null) _storage.write(key: _kAuthEmail, value: email),
      if (firstName != null)
        _storage.write(key: _kAuthFirstName, value: firstName),
      if (lastName != null)
        _storage.write(key: _kAuthLastName, value: lastName),
    ]);
  }

  Future<void> clear() async {
    await Future.wait([
      _storage.delete(key: _kAccessToken),
      _storage.delete(key: _kRefreshToken),
      _storage.delete(key: _kExpiresAt),
      _storage.delete(key: _kAuthEmail),
      _storage.delete(key: _kAuthFirstName),
      _storage.delete(key: _kAuthLastName),
    ]);
  }

  Future<bool> hasSession() async {
    final access = await readAccessToken();
    return access != null && access.isNotEmpty;
  }
}
