// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SellerRating _$SellerRatingFromJson(Map<String, dynamic> json) =>
    _SellerRating(
      criterion: $enumDecode(_$RatingCriterionEnumMap, json['criterion']),
      value: (json['value'] as num).toDouble(),
      sampleCount: (json['sampleCount'] as num).toInt(),
    );

Map<String, dynamic> _$SellerRatingToJson(_SellerRating instance) =>
    <String, dynamic>{
      'criterion': _$RatingCriterionEnumMap[instance.criterion]!,
      'value': instance.value,
      'sampleCount': instance.sampleCount,
    };

const _$RatingCriterionEnumMap = {
  RatingCriterion.hygiene: 'hygiene',
  RatingCriterion.foodQuality: 'foodQuality',
  RatingCriterion.packaging: 'packaging',
};
