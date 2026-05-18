import 'dart:convert';

/// Decoded Supabase access-token payload, narrowed to the fields the
/// app actually reads. JWTs aren't encrypted — the payload is base64-
/// encoded JSON, so client-side decode is safe and standard practice
/// for pulling identity-provider claims (e.g. Google's `given_name`)
/// without an extra `/users/me` round-trip.
///
/// Field locations:
///   * `email`            → top-level claim.
///   * `givenName` / `familyName` / `fullName` → nested in
///     `user_metadata`, which Supabase populates from the upstream
///     OAuth provider (Google maps `given_name` / `family_name` /
///     `name` straight through).
///
/// For email-password signups Supabase emits an empty `user_metadata`,
/// so those fields stay null — callers should treat the names as
/// best-effort, not a guarantee.
class JwtPayload {
  const JwtPayload({
    this.email,
    this.givenName,
    this.familyName,
    this.fullName,
  });

  final String? email;
  final String? givenName;
  final String? familyName;
  final String? fullName;
}

/// Decodes a JWT's payload. Returns `null` if the input isn't a
/// well-formed three-part token — the caller can degrade silently.
JwtPayload? decodeJwtPayload(String token) {
  final parts = token.split('.');
  if (parts.length != 3) return null;
  Map<String, dynamic> json;
  try {
    json = jsonDecode(utf8.decode(base64Url.decode(_pad(parts[1]))))
        as Map<String, dynamic>;
  } catch (_) {
    return null;
  }

  final meta = json['user_metadata'];
  String? metaString(String key) {
    if (meta is! Map) return null;
    final v = meta[key];
    return v is String && v.isNotEmpty ? v : null;
  }

  return JwtPayload(
    email: json['email'] is String ? json['email'] as String : null,
    givenName: metaString('given_name'),
    familyName: metaString('family_name'),
    fullName: metaString('name') ?? metaString('full_name'),
  );
}

/// base64Url requires the input length to be a multiple of 4. The
/// JWT spec strips the padding `=`s; we add them back.
String _pad(String input) {
  final remainder = input.length % 4;
  if (remainder == 0) return input;
  return input + ('=' * (4 - remainder));
}
