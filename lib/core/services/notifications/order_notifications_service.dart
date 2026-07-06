import 'dart:async';

import 'package:get/get.dart';

/// One order-related push notification, normalised to the two fields the
/// app cares about. [type] is the backend's snake_case event name
/// (`order_paid`, `order_ready`, `delivery_assigned`, …) and [orderId] is
/// the affected order.
class OrderNotificationEvent {
  const OrderNotificationEvent({required this.type, required this.orderId});

  final String type;
  final String orderId;

  bool get isOrderEvent => type.startsWith('order_');
  bool get isDeliveryEvent => type.startsWith('delivery_');

  /// A brand-new paid order landing on the seller — the "new order" push.
  bool get isNewOrder => type == 'order_paid';
}

/// App-wide bus for order/delivery push notifications.
///
/// The push layer publishes here whenever an `order_*` / `delivery_*`
/// notification is **received in the foreground** or **opened from the
/// background** — the two states we treat as the source of truth for order
/// state. Screens that show orders (the seller's "Demandes de commande"
/// carousel and "Commandes" tab) listen and reload, so a new/updated order
/// appears the moment its notification arrives, without polling.
///
/// Permanent GetX singleton registered in `main.dart`.
class OrderNotificationsService extends GetxService {
  static OrderNotificationsService get instance => Get.find();

  final StreamController<OrderNotificationEvent> _controller =
      StreamController<OrderNotificationEvent>.broadcast();

  /// Broadcast stream of order/delivery notification events. Multiple
  /// screens can listen at once.
  Stream<OrderNotificationEvent> get events => _controller.stream;

  /// Publish an event. No-op after [onClose]. Safe to call from anywhere.
  void emit(OrderNotificationEvent event) {
    if (!_controller.isClosed) _controller.add(event);
  }

  @override
  void onClose() {
    _controller.close();
    super.onClose();
  }
}
