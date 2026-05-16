// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fulfillment_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FulfillmentOptions _$FulfillmentOptionsFromJson(Map<String, dynamic> json) =>
    _FulfillmentOptions(
      deliveryAvailable: json['deliveryAvailable'] as bool,
      deliveryMinMinutes: (json['deliveryMinMinutes'] as num).toInt(),
      deliveryMaxMinutes: (json['deliveryMaxMinutes'] as num).toInt(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      pickupAvailable: json['pickupAvailable'] as bool,
      pickupNeighborhood: json['pickupNeighborhood'] as String,
      userHasAddress: json['userHasAddress'] as bool? ?? true,
    );

Map<String, dynamic> _$FulfillmentOptionsToJson(_FulfillmentOptions instance) =>
    <String, dynamic>{
      'deliveryAvailable': instance.deliveryAvailable,
      'deliveryMinMinutes': instance.deliveryMinMinutes,
      'deliveryMaxMinutes': instance.deliveryMaxMinutes,
      'deliveryFee': instance.deliveryFee,
      'pickupAvailable': instance.pickupAvailable,
      'pickupNeighborhood': instance.pickupNeighborhood,
      'userHasAddress': instance.userHasAddress,
    };

_FulfillmentSelection _$FulfillmentSelectionFromJson(
  Map<String, dynamic> json,
) => _FulfillmentSelection(
  choice: $enumDecode(_$FulfillmentChoiceEnumMap, json['choice']),
  fee: (json['fee'] as num).toDouble(),
);

Map<String, dynamic> _$FulfillmentSelectionToJson(
  _FulfillmentSelection instance,
) => <String, dynamic>{
  'choice': _$FulfillmentChoiceEnumMap[instance.choice]!,
  'fee': instance.fee,
};

const _$FulfillmentChoiceEnumMap = {
  FulfillmentChoice.delivery: 'delivery',
  FulfillmentChoice.pickup: 'pickup',
};
