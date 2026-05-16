// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  avatarPath: json['avatarPath'] as String?,
  emailVerified: json['emailVerified'] as bool? ?? false,
  phoneVerified: json['phoneVerified'] as bool? ?? false,
  createdAt: json['createdAt'] as String?,
  buyerAccount: json['buyerProfile'] == null
      ? null
      : BuyerAccount.fromJson(json['buyerProfile'] as Map<String, dynamic>),
  sellerAccount: json['sellerProfile'] == null
      ? null
      : SellerAccount.fromJson(json['sellerProfile'] as Map<String, dynamic>),
  driverAccount: json['driverProfile'] == null
      ? null
      : DriverAccount.fromJson(json['driverProfile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'phone': ?instance.phone,
  'role': _$UserRoleEnumMap[instance.role]!,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatarPath': ?instance.avatarPath,
  'emailVerified': instance.emailVerified,
  'phoneVerified': instance.phoneVerified,
  'createdAt': ?instance.createdAt,
  'buyerProfile': ?instance.buyerAccount?.toJson(),
  'sellerProfile': ?instance.sellerAccount?.toJson(),
  'driverProfile': ?instance.driverAccount?.toJson(),
};

const _$UserRoleEnumMap = {
  UserRole.buyer: 'BUYER',
  UserRole.seller: 'SELLER',
  UserRole.driver: 'DRIVER',
};
