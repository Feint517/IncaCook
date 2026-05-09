import 'package:freezed_annotation/freezed_annotation.dart';

part 'kitchen.freezed.dart';
part 'kitchen.g.dart';

@freezed
abstract class Kitchen with _$Kitchen {
  const factory Kitchen({
    required String id,
    required String name,
    required String imageUrl,
    required String chefImageUrl,
    required double rating,
    required int reviewCount,
    required bool isVerified,
    required bool hasFreeDelivery,
    required String deliveryTime,
    required List<String> tags,
  }) = _Kitchen;

  factory Kitchen.fromJson(Map<String, dynamic> json) =>
      _$KitchenFromJson(json);
}
