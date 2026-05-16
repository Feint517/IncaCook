// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingState _$OnboardingStateFromJson(Map<String, dynamic> json) =>
    _OnboardingState(
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      next: json['next'] as String?,
      steps:
          (json['steps'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, $enumDecode(_$OnboardingStatusEnumMap, e)),
          ) ??
          const <String, OnboardingStatus>{},
      kycReviewState: $enumDecodeNullable(
        _$KycReviewStateEnumMap,
        json['kycReviewState'],
      ),
      canList: json['canList'] as bool?,
      canDeliver: json['canDeliver'] as bool?,
    );

Map<String, dynamic> _$OnboardingStateToJson(_OnboardingState instance) =>
    <String, dynamic>{
      'role': _$UserRoleEnumMap[instance.role]!,
      'next': ?instance.next,
      'steps': instance.steps.map(
        (k, e) => MapEntry(k, _$OnboardingStatusEnumMap[e]!),
      ),
      'kycReviewState': ?_$KycReviewStateEnumMap[instance.kycReviewState],
      'canList': ?instance.canList,
      'canDeliver': ?instance.canDeliver,
    };

const _$UserRoleEnumMap = {
  UserRole.buyer: 'BUYER',
  UserRole.seller: 'SELLER',
  UserRole.driver: 'DRIVER',
};

const _$OnboardingStatusEnumMap = {
  OnboardingStatus.complete: 'complete',
  OnboardingStatus.incomplete: 'incomplete',
  OnboardingStatus.skipped: 'skipped',
  OnboardingStatus.pendingReview: 'pending_review',
};

const _$KycReviewStateEnumMap = {
  KycReviewState.pending: 'PENDING',
  KycReviewState.approved: 'APPROVED',
  KycReviewState.rejected: 'REJECTED',
};
