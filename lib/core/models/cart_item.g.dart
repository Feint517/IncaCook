// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
  id: json['id'] as String,
  listing: FoodListing.fromJson(json['listing'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num).toInt(),
  selectedAddOns: (json['selectedAddOns'] as List<dynamic>)
      .map((e) => ProductAddOn.fromJson(e as Map<String, dynamic>))
      .toList(),
  note: json['note'] as String,
  isAvailable: json['isAvailable'] as bool? ?? true,
);

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
  'id': instance.id,
  'listing': instance.listing.toJson(),
  'quantity': instance.quantity,
  'selectedAddOns': instance.selectedAddOns.map((e) => e.toJson()).toList(),
  'note': instance.note,
  'isAvailable': instance.isAvailable,
};
