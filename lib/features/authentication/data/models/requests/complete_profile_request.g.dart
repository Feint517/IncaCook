// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompleteProfileRequest _$CompleteProfileRequestFromJson(
  Map<String, dynamic> json,
) => _CompleteProfileRequest(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  acceptedCgu: json['acceptedCgu'] as bool,
  acceptedCgv: json['acceptedCgv'] as bool,
);

Map<String, dynamic> _$CompleteProfileRequestToJson(
  _CompleteProfileRequest instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'role': _$UserRoleEnumMap[instance.role]!,
  'acceptedCgu': instance.acceptedCgu,
  'acceptedCgv': instance.acceptedCgv,
};

const _$UserRoleEnumMap = {
  UserRole.buyer: 'BUYER',
  UserRole.seller: 'SELLER',
  UserRole.driver: 'DRIVER',
};
