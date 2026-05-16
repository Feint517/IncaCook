// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: json['id'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  emailConfirmedAt: json['emailConfirmedAt'] as String?,
  phoneConfirmedAt: json['phoneConfirmedAt'] as String?,
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'phone': ?instance.phone,
  'emailConfirmedAt': ?instance.emailConfirmedAt,
  'phoneConfirmedAt': ?instance.phoneConfirmedAt,
};
