// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddressRecord _$AddressRecordFromJson(Map<String, dynamic> json) =>
    _AddressRecord(
      id: json['id'] as String,
      type: $enumDecodeNullable(_$AddressTypeEnumMap, json['type']),
      customLabel: json['customLabel'] as String?,
      fullAddress: json['fullAddress'] as String,
      city: json['city'] as String,
      postalCode: json['postalCode'] as String,
      apartment: json['apartment'] as String?,
      floor: json['floor'] as String?,
      digicode: json['digicode'] as String?,
      deliveryNotes: json['deliveryNotes'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AddressRecordToJson(_AddressRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': ?_$AddressTypeEnumMap[instance.type],
      'customLabel': ?instance.customLabel,
      'fullAddress': instance.fullAddress,
      'city': instance.city,
      'postalCode': instance.postalCode,
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
