// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
  fullAddress: json['fullAddress'] as String,
  city: json['city'] as String,
  postalCode: json['postalCode'] as String,
  coordinate: json['coordinate'] == null
      ? null
      : MapPoint.fromJson(json['coordinate'] as Map<String, dynamic>),
  id: json['id'] as String?,
  type: $enumDecodeNullable(_$SavedAddressTypeEnumMap, json['type']),
  customLabel: json['customLabel'] as String?,
  apartment: json['apartment'] as String?,
  floor: json['floor'] as String?,
  digicode: json['digicode'] as String?,
  deliveryNotes: json['deliveryNotes'] as String?,
);

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
  'fullAddress': instance.fullAddress,
  'city': instance.city,
  'postalCode': instance.postalCode,
  'coordinate': ?instance.coordinate?.toJson(),
  'id': ?instance.id,
  'type': ?_$SavedAddressTypeEnumMap[instance.type],
  'customLabel': ?instance.customLabel,
  'apartment': ?instance.apartment,
  'floor': ?instance.floor,
  'digicode': ?instance.digicode,
  'deliveryNotes': ?instance.deliveryNotes,
};

const _$SavedAddressTypeEnumMap = {
  SavedAddressType.home: 'home',
  SavedAddressType.work: 'work',
  SavedAddressType.other: 'other',
};
