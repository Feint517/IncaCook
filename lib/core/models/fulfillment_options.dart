import 'package:freezed_annotation/freezed_annotation.dart';

part 'fulfillment_options.freezed.dart';
part 'fulfillment_options.g.dart';

/// What the buyer picks at checkout. Subset of [Fulfillment] (which can be
/// `both` for a listing — never a checkout choice).
enum FulfillmentChoice { delivery, pickup }

/// Options the seller / system make available for a listing at checkout
/// time. Drives which option pills are selectable on the fulfillment sheet.
@freezed
abstract class FulfillmentOptions with _$FulfillmentOptions {
  const FulfillmentOptions._();

  const factory FulfillmentOptions({
    required bool deliveryAvailable,
    required int deliveryMinMinutes,
    required int deliveryMaxMinutes,
    required double deliveryFee,
    required bool pickupAvailable,
    required String pickupNeighborhood,
    @Default(true) bool userHasAddress,
  }) = _FulfillmentOptions;

  factory FulfillmentOptions.fromJson(Map<String, dynamic> json) =>
      _$FulfillmentOptionsFromJson(json);

  bool get deliverySelectable => deliveryAvailable && userHasAddress;
}

/// The buyer's confirmed choice + the resolved fee for that choice.
@freezed
abstract class FulfillmentSelection with _$FulfillmentSelection {
  const factory FulfillmentSelection({
    required FulfillmentChoice choice,
    required double fee,
  }) = _FulfillmentSelection;

  factory FulfillmentSelection.fromJson(Map<String, dynamic> json) =>
      _$FulfillmentSelectionFromJson(json);
}
