import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_add_on.freezed.dart';
part 'product_add_on.g.dart';

/// Optional choice on a listing — extra topping, larger portion, etc.
/// Selected add-ons attach to a [CartItem]; their [priceDelta] folds
/// into the line's unit price.
@freezed
abstract class ProductAddOn with _$ProductAddOn {
  const factory ProductAddOn({
    required String id,
    required String label,
    required double priceDelta,
    @Default(false) bool isSelectedByDefault,
  }) = _ProductAddOn;

  factory ProductAddOn.fromJson(Map<String, dynamic> json) =>
      _$ProductAddOnFromJson(json);
}
