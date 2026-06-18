import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:incacook/features/authentication/data/models/user_role.dart';

part 'complete_profile_request.freezed.dart';
part 'complete_profile_request.g.dart';

/// Body of `POST /v1/users` — "complete profile" after `/auth/signup`.
///
/// Fired once role + legal-acceptance are both committed. Creates the
/// IncaCook user row that the rest of the app depends on (the auth-side
/// user from [Session] is intentionally minimal).
@freezed
abstract class CompleteProfileRequest with _$CompleteProfileRequest {
  const factory CompleteProfileRequest({
    required String firstName,
    required String lastName,
    required UserRole role,
    required bool acceptedCgu,
    required bool acceptedCgv,
    // Phone collected during onboarding, saved unverified when SMS OTP is
    // skipped. Null when no number was captured. Sent only if non-null.
    @JsonKey(includeIfNull: false) String? phone,
  }) = _CompleteProfileRequest;

  factory CompleteProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileRequestFromJson(json);
}
