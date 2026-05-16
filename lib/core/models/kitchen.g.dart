// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Kitchen _$KitchenFromJson(Map<String, dynamic> json) => _Kitchen(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  chefImageUrl: json['chefImageUrl'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  isVerified: json['isVerified'] as bool,
  hasFreeDelivery: json['hasFreeDelivery'] as bool,
  deliveryTime: json['deliveryTime'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$KitchenToJson(_Kitchen instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'chefImageUrl': instance.chefImageUrl,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'isVerified': instance.isVerified,
  'hasFreeDelivery': instance.hasFreeDelivery,
  'deliveryTime': instance.deliveryTime,
  'tags': instance.tags,
};
