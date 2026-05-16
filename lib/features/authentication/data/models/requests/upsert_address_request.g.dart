// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpsertAddressRequest _$UpsertAddressRequestFromJson(
  Map<String, dynamic> json,
) => _UpsertAddressRequest(
  fullAddress: json['fullAddress'] as String,
  city: json['city'] as String,
  postalCode: json['postalCode'] as String,
  type: $enumDecodeNullable(_$AddressTypeEnumMap, json['type']),
  customLabel: json['customLabel'] as String?,
  apartment: json['apartment'] as String?,
  floor: json['floor'] as String?,
  digicode: json['digicode'] as String?,
  deliveryNotes: json['deliveryNotes'] as String?,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
);

Map<String, dynamic> _$UpsertAddressRequestToJson(
  _UpsertAddressRequest instance,
) => <String, dynamic>{
  'fullAddress': instance.fullAddress,
  'city': instance.city,
  'postalCode': instance.postalCode,
  'type': ?_$AddressTypeEnumMap[instance.type],
  'customLabel': ?instance.customLabel,
  'apartment': ?instance.apartment,
  'floor': ?instance.floor,
  'digicode': ?instance.digicode,
  'deliveryNotes': ?instance.deliveryNotes,
  'lat': ?instance.lat,
  'lng': ?instance.lng,
};

const _$AddressTypeEnumMap = {
  AddressType.home: 'HOME',
  AddressType.work: 'WORK',
  AddressType.other: 'OTHER',
};
