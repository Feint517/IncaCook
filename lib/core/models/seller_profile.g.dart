// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SellerStats _$SellerStatsFromJson(Map<String, dynamic> json) => _SellerStats(
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  mealsSold: (json['mealsSold'] as num).toInt(),
  mealsSaved: (json['mealsSaved'] as num).toInt(),
  responseRatePercent: (json['responseRatePercent'] as num).toInt(),
  criteriaRatings: (json['criteriaRatings'] as List<dynamic>)
      .map((e) => SellerRating.fromJson(e as Map<String, dynamic>))
      .toList(),
  ratingDistribution: (json['ratingDistribution'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
  ),
  sentimentTags: (json['sentimentTags'] as List<dynamic>)
      .map((e) => SentimentTag.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SellerStatsToJson(
  _SellerStats instance,
) => <String, dynamic>{
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'mealsSold': instance.mealsSold,
  'mealsSaved': instance.mealsSaved,
  'responseRatePercent': instance.responseRatePercent,
  'criteriaRatings': instance.criteriaRatings.map((e) => e.toJson()).toList(),
  'ratingDistribution': instance.ratingDistribution.map(
    (k, e) => MapEntry(k.toString(), e),
  ),
  'sentimentTags': instance.sentimentTags.map((e) => e.toJson()).toList(),
};

_SellerProfile _$SellerProfileFromJson(Map<String, dynamic> json) =>
    _SellerProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      category: $enumDecode(_$SellerCategoryEnumMap, json['category']),
      categoryTag: json['categoryTag'] as String,
      cuisineType: json['cuisineType'] as String,
      bio: json['bio'] as String,
      neighborhood: json['neighborhood'] as String,
      location: MapPoint.fromJson(json['location'] as Map<String, dynamic>),
      deliveryRadiusKm: (json['deliveryRadiusKm'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      prepMinMinutes: (json['prepMinMinutes'] as num).toInt(),
      prepMaxMinutes: (json['prepMaxMinutes'] as num).toInt(),
      languageCodes: (json['languageCodes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      memberSince: DateTime.parse(json['memberSince'] as String),
      availabilitySchedule: json['availabilitySchedule'] as String,
      verifications: (json['verifications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      stats: SellerStats.fromJson(json['stats'] as Map<String, dynamic>),
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0,
      lastActiveAgo: json['lastActiveAgo'] as String? ?? '',
      menuCategories:
          (json['menuCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      listings:
          (json['listings'] as List<dynamic>?)
              ?.map((e) => FoodListing.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FoodListing>[],
      recentReviews:
          (json['recentReviews'] as List<dynamic>?)
              ?.map((e) => SellerReview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SellerReview>[],
      promoText: json['promoText'] as String?,
    );

Map<String, dynamic> _$SellerProfileToJson(_SellerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'category': _$SellerCategoryEnumMap[instance.category]!,
      'categoryTag': instance.categoryTag,
      'cuisineType': instance.cuisineType,
      'bio': instance.bio,
      'neighborhood': instance.neighborhood,
      'location': instance.location.toJson(),
      'deliveryRadiusKm': instance.deliveryRadiusKm,
      'deliveryFee': instance.deliveryFee,
      'prepMinMinutes': instance.prepMinMinutes,
      'prepMaxMinutes': instance.prepMaxMinutes,
      'languageCodes': instance.languageCodes,
      'memberSince': instance.memberSince.toIso8601String(),
      'availabilitySchedule': instance.availabilitySchedule,
      'verifications': instance.verifications,
      'stats': instance.stats.toJson(),
      'distanceKm': instance.distanceKm,
      'lastActiveAgo': instance.lastActiveAgo,
      'menuCategories': instance.menuCategories,
      'listings': instance.listings.map((e) => e.toJson()).toList(),
      'recentReviews': instance.recentReviews.map((e) => e.toJson()).toList(),
      'promoText': ?instance.promoText,
    };

const _$SellerCategoryEnumMap = {
  SellerCategory.faitMaison: 'FAIT_MAISON',
  SellerCategory.traiteur: 'TRAITEUR',
  SellerCategory.restaurant: 'RESTAURANT',
};

_SentimentTag _$SentimentTagFromJson(Map<String, dynamic> json) =>
    _SentimentTag(
      label: json['label'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$SentimentTagToJson(_SentimentTag instance) =>
    <String, dynamic>{'label': instance.label, 'count': instance.count};

_SellerReview _$SellerReviewFromJson(Map<String, dynamic> json) =>
    _SellerReview(
      authorName: json['authorName'] as String,
      avatarUrl: json['avatarUrl'] as String,
      rating: (json['rating'] as num).toInt(),
      body: json['body'] as String,
      timeAgoLabel: json['timeAgoLabel'] as String,
      helpfulCount: (json['helpfulCount'] as num).toInt(),
    );

Map<String, dynamic> _$SellerReviewToJson(_SellerReview instance) =>
    <String, dynamic>{
      'authorName': instance.authorName,
      'avatarUrl': instance.avatarUrl,
      'rating': instance.rating,
      'body': instance.body,
      'timeAgoLabel': instance.timeAgoLabel,
      'helpfulCount': instance.helpfulCount,
    };
