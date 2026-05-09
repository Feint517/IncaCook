// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeliveryDetails _$DeliveryDetailsFromJson(Map<String, dynamic> json) =>
    _DeliveryDetails(
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      instructions: json['instructions'] as String,
      timing: $enumDecode(_$DeliveryTimingEnumMap, json['timing']),
      scheduledAt: json['scheduled_at'] == null
          ? null
          : DateTime.parse(json['scheduled_at'] as String),
    );

Map<String, dynamic> _$DeliveryDetailsToJson(_DeliveryDetails instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'instructions': instance.instructions,
      'timing': _$DeliveryTimingEnumMap[instance.timing]!,
      'scheduled_at': ?instance.scheduledAt?.toIso8601String(),
    };

const _$DeliveryTimingEnumMap = {
  DeliveryTiming.asap: 'asap',
  DeliveryTiming.scheduled: 'scheduled',
};
