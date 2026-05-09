// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => _OrderDetail(
  id: json['id'] as String,
  orderNumber: json['order_number'] as String,
  placedAt: DateTime.parse(json['placed_at'] as String),
  stage: $enumDecode(_$OrderStageEnumMap, json['stage']),
  seller: SellerProfile.fromJson(json['seller'] as Map<String, dynamic>),
  items: (json['items'] as List<dynamic>)
      .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  subtotal: (json['subtotal'] as num).toDouble(),
  deliveryFee: (json['delivery_fee'] as num).toDouble(),
  serviceFee: (json['service_fee'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
  fulfillment: FulfillmentSelection.fromJson(
    json['fulfillment'] as Map<String, dynamic>,
  ),
  fulfillmentOptions: FulfillmentOptions.fromJson(
    json['fulfillment_options'] as Map<String, dynamic>,
  ),
  paymentMethod: PaymentMethod.fromJson(
    json['payment_method'] as Map<String, dynamic>,
  ),
  deliveryDetails: json['delivery_details'] == null
      ? null
      : DeliveryDetails.fromJson(
          json['delivery_details'] as Map<String, dynamic>,
        ),
  deliverer: json['deliverer'] == null
      ? null
      : DelivererInfo.fromJson(json['deliverer'] as Map<String, dynamic>),
  expectedAt: json['expected_at'] == null
      ? null
      : DateTime.parse(json['expected_at'] as String),
  note: json['note'] as String?,
);

Map<String, dynamic> _$OrderDetailToJson(_OrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'placed_at': instance.placedAt.toIso8601String(),
      'stage': _$OrderStageEnumMap[instance.stage]!,
      'seller': instance.seller.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'subtotal': instance.subtotal,
      'delivery_fee': instance.deliveryFee,
      'service_fee': instance.serviceFee,
      'total': instance.total,
      'fulfillment': instance.fulfillment.toJson(),
      'fulfillment_options': instance.fulfillmentOptions.toJson(),
      'payment_method': instance.paymentMethod.toJson(),
      'delivery_details': ?instance.deliveryDetails?.toJson(),
      'deliverer': ?instance.deliverer?.toJson(),
      'expected_at': ?instance.expectedAt?.toIso8601String(),
      'note': ?instance.note,
    };

const _$OrderStageEnumMap = {
  OrderStage.prepared: 'prepared',
  OrderStage.arrivedPickup: 'arrivedPickup',
  OrderStage.onTheWay: 'onTheWay',
  OrderStage.arrivedDropoff: 'arrivedDropoff',
  OrderStage.delivered: 'delivered',
  OrderStage.failed: 'failed',
};

_DelivererInfo _$DelivererInfoFromJson(Map<String, dynamic> json) =>
    _DelivererInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      completedDeliveries: (json['completed_deliveries'] as num).toInt(),
      vehicleType: json['vehicle_type'] as String,
      licensePlate: json['license_plate'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$DelivererInfoToJson(_DelivererInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'rating': instance.rating,
      'completed_deliveries': instance.completedDeliveries,
      'vehicle_type': instance.vehicleType,
      'license_plate': ?instance.licensePlate,
      'phone_number': ?instance.phoneNumber,
    };
