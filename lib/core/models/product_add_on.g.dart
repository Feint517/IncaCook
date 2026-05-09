// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_add_on.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductAddOn _$ProductAddOnFromJson(Map<String, dynamic> json) =>
    _ProductAddOn(
      id: json['id'] as String,
      label: json['label'] as String,
      priceDelta: (json['price_delta'] as num).toDouble(),
      isSelectedByDefault: json['is_selected_by_default'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductAddOnToJson(_ProductAddOn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'price_delta': instance.priceDelta,
      'is_selected_by_default': instance.isSelectedByDefault,
    };
