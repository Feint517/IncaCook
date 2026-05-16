// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => _OrderDetail(
  id: json['id'] as String,
  orderNumber: json['orderNumber'] as String,
  placedAt: DateTime.parse(json['placedAt'] as String),
  stage: $enumDecode(_$OrderStageEnumMap, json['stage']),
  seller: SellerProfile.fromJson(json['seller'] as Map<String, dynamic>),
  items: (json['items'] as List<dynamic>)
      .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  subtotal: (json['subtotal'] as num).toDouble(),
  deliveryFee: (json['deliveryFee'] as num).toDouble(),
  serviceFee: (json['serviceFee'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
  fulfillment: FulfillmentSelection.fromJson(
    json['fulfillment'] as Map<String, dynamic>,
  ),
  fulfillmentOptions: FulfillmentOptions.fromJson(
    json['fulfillmentOptions'] as Map<String, dynamic>,
  ),
  paymentMethod: PaymentMethod.fromJson(
    json['paymentMethod'] as Map<String, dynamic>,
  ),
  deliveryDetails: json['deliveryDetails'] == null
      ? null
      : DeliveryDetails.fromJson(
          json['deliveryDetails'] as Map<String, dynamic>,
        ),
  deliverer: json['deliverer'] == null
      ? null
      : DelivererInfo.fromJson(json['deliverer'] as Map<String, dynamic>),
  expectedAt: json['expectedAt'] == null
      ? null
      : DateTime.parse(json['expectedAt'] as String),
  note: json['note'] as String?,
);

Map<String, dynamic> _$OrderDetailToJson(_OrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'placedAt': instance.placedAt.toIso8601String(),
      'stage': _$OrderStageEnumMap[instance.stage]!,
      'seller': instance.seller.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'subtotal': instance.subtotal,
      'deliveryFee': instance.deliveryFee,
      'serviceFee': instance.serviceFee,
      'total': instance.total,
      'fulfillment': instance.fulfillment.toJson(),
      'fulfillmentOptions': instance.fulfillmentOptions.toJson(),
      'paymentMethod': instance.paymentMethod.toJson(),
      'deliveryDetails': ?instance.deliveryDetails?.toJson(),
      'deliverer': ?instance.deliverer?.toJson(),
      'expectedAt': ?instance.expectedAt?.toIso8601String(),
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
      avatarUrl: json['avatarUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      completedDeliveries: (json['completedDeliveries'] as num).toInt(),
      vehicleType: json['vehicleType'] as String,
      licensePlate: json['licensePlate'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$DelivererInfoToJson(_DelivererInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'rating': instance.rating,
      'completedDeliveries': instance.completedDeliveries,
      'vehicleType': instance.vehicleType,
      'licensePlate': ?instance.licensePlate,
      'phoneNumber': ?instance.phoneNumber,
    };
