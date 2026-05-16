// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SellerProfileRequest _$SellerProfileRequestFromJson(
  Map<String, dynamic> json,
) => _SellerProfileRequest(
  category: $enumDecode(_$SellerCategoryEnumMap, json['category']),
  displayName: json['displayName'] as String,
  bio: json['bio'] as String?,
  profilePhotoUrl: json['profilePhotoUrl'] as String,
  dateOfBirth: json['dateOfBirth'] as String,
  neighborhood: json['neighborhood'] as String?,
  deliveryRadiusKm: (json['deliveryRadiusKm'] as num?)?.toInt(),
  deliveryFeeCents: (json['deliveryFeeCents'] as num?)?.toInt(),
  prepMinMinutes: (json['prepMinMinutes'] as num?)?.toInt(),
  prepMaxMinutes: (json['prepMaxMinutes'] as num?)?.toInt(),
  hygieneCommitment: json['hygieneCommitment'] as bool?,
  faitMaisonCommitment: json['faitMaisonCommitment'] as bool?,
);

Map<String, dynamic> _$SellerProfileRequestToJson(
  _SellerProfileRequest instance,
) => <String, dynamic>{
  'category': _$SellerCategoryEnumMap[instance.category]!,
  'displayName': instance.displayName,
  'bio': ?instance.bio,
  'profilePhotoUrl': instance.profilePhotoUrl,
  'dateOfBirth': instance.dateOfBirth,
  'neighborhood': ?instance.neighborhood,
  'deliveryRadiusKm': ?instance.deliveryRadiusKm,
  'deliveryFeeCents': ?instance.deliveryFeeCents,
  'prepMinMinutes': ?instance.prepMinMinutes,
  'prepMaxMinutes': ?instance.prepMaxMinutes,
  'hygieneCommitment': ?instance.hygieneCommitment,
  'faitMaisonCommitment': ?instance.faitMaisonCommitment,
};

const _$SellerCategoryEnumMap = {
  SellerCategory.faitMaison: 'FAIT_MAISON',
  SellerCategory.traiteur: 'TRAITEUR',
  SellerCategory.restaurant: 'RESTAURANT',
};
