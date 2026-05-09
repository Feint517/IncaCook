// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fulfillment_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FulfillmentOptions _$FulfillmentOptionsFromJson(Map<String, dynamic> json) =>
    _FulfillmentOptions(
      deliveryAvailable: json['delivery_available'] as bool,
      deliveryMinMinutes: (json['delivery_min_minutes'] as num).toInt(),
      deliveryMaxMinutes: (json['delivery_max_minutes'] as num).toInt(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      pickupAvailable: json['pickup_available'] as bool,
      pickupNeighborhood: json['pickup_neighborhood'] as String,
      userHasAddress: json['user_has_address'] as bool? ?? true,
    );

Map<String, dynamic> _$FulfillmentOptionsToJson(_FulfillmentOptions instance) =>
    <String, dynamic>{
      'delivery_available': instance.deliveryAvailable,
      'delivery_min_minutes': instance.deliveryMinMinutes,
      'delivery_max_minutes': instance.deliveryMaxMinutes,
      'delivery_fee': instance.deliveryFee,
      'pickup_available': instance.pickupAvailable,
      'pickup_neighborhood': instance.pickupNeighborhood,
      'user_has_address': instance.userHasAddress,
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
