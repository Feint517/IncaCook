import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:incacook/core/models/food_listing.dart';
import 'package:incacook/core/models/product_add_on.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

/// One line in the cart. Two buys of the same dish with different options
/// produce two separate line items so their state stays independent.
///
/// Producers (catalog sheet, quick-add) construct a draft with `id: ''`;
/// the cart controller assigns the sequence-based id on insert.
@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String id,
    required FoodListing listing,
    required int quantity,
    required List<ProductAddOn> selectedAddOns,
    required String note,
    @Default(true) bool isAvailable,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  double get unitPrice =>
      listing.price + selectedAddOns.fold(0.0, (sum, a) => sum + a.priceDelta);

  double get lineTotal => unitPrice * quantity;
}
