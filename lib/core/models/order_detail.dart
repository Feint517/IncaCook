import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:incacook/core/enums/order_stage.dart';
import 'package:incacook/core/models/cart_item.dart';
import 'package:incacook/core/models/delivery_details.dart';
import 'package:incacook/core/models/fulfillment_options.dart';
import 'package:incacook/core/models/payment_method.dart';
import 'package:incacook/core/models/seller_profile.dart';

part 'order_detail.freezed.dart';
part 'order_detail.g.dart';

/// Snapshot of a single placed order. Bundles every piece of data the
/// post-checkout screens need (confirmation, tracking, history).
///
/// [deliveryDetails] is non-null only when [fulfillment.choice] is
/// [FulfillmentChoice.delivery]; pickup orders carry a null here.
@freezed
abstract class OrderDetail with _$OrderDetail {
  const OrderDetail._();

  const factory OrderDetail({
    required String id,
    required String orderNumber,
    required DateTime placedAt,
    required OrderStage stage,
    required SellerProfile seller,
    required List<CartItem> items,
    required double subtotal,
    required double deliveryFee,
    required double serviceFee,
    required double total,
    required FulfillmentSelection fulfillment,
    required FulfillmentOptions fulfillmentOptions,
    required PaymentMethod paymentMethod,
    DeliveryDetails? deliveryDetails,
    DelivererInfo? deliverer,
    DateTime? expectedAt,
    String? note,
  }) = _OrderDetail;

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  bool get isDelivery => fulfillment.choice == FulfillmentChoice.delivery;
  bool get isPickup => fulfillment.choice == FulfillmentChoice.pickup;

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);
}

/// Person delivering an order. Optional on [OrderDetail] — only set once
/// a courier has been assigned (i.e. stage ≥ [OrderStage.onTheWay]).
@freezed
abstract class DelivererInfo with _$DelivererInfo {
  const factory DelivererInfo({
    required String id,
    required String name,
    required String avatarUrl,
    required double rating,
    required int completedDeliveries,
    required String vehicleType,
    String? licensePlate,
    String? phoneNumber,
  }) = _DelivererInfo;

  factory DelivererInfo.fromJson(Map<String, dynamic> json) =>
      _$DelivererInfoFromJson(json);
}
