// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Kitchen _$KitchenFromJson(Map<String, dynamic> json) => _Kitchen(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['image_url'] as String,
  chefImageUrl: json['chef_image_url'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['review_count'] as num).toInt(),
  isVerified: json['is_verified'] as bool,
  hasFreeDelivery: json['has_free_delivery'] as bool,
  deliveryTime: json['delivery_time'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$KitchenToJson(_Kitchen instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image_url': instance.imageUrl,
  'chef_image_url': instance.chefImageUrl,
  'rating': instance.rating,
  'review_count': instance.reviewCount,
  'is_verified': instance.isVerified,
  'has_free_delivery': instance.hasFreeDelivery,
  'delivery_time': instance.deliveryTime,
  'tags': instance.tags,
};
