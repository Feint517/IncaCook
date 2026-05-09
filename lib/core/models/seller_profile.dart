import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/core/services/map/models/map_route.dart';
import 'package:incacook/core/models/food_listing.dart';
import 'package:incacook/core/models/seller_rating.dart';

part 'seller_profile.freezed.dart';
part 'seller_profile.g.dart';

/// Aggregate metrics derived from orders and reviews. On the backend these
/// live in a stats view / cached projection — they are NOT canonical
/// columns on the seller record. Bundled here so consumers pull all the
/// "summary numbers" together.
@freezed
abstract class SellerStats with _$SellerStats {
  const factory SellerStats({
    /// Overall average rating (0..5).
    required double rating,
    required int reviewCount,
    required int mealsSold,

    /// Bookmarks/favorites — listings the seller has had saved by buyers.
    required int mealsSaved,

    /// 0..100, percent of orders the seller responds to within SLA.
    required int responseRatePercent,

    /// Per-criterion ratings (hygiene / food quality / packaging).
    required List<SellerRating> criteriaRatings,

    /// Stars (1..5) → review count for that bucket.
    required Map<int, double> ratingDistribution,

    /// Most-mentioned tags from review text.
    required List<SentimentTag> sentimentTags,
  }) = _SellerStats;

  factory SellerStats.fromJson(Map<String, dynamic> json) =>
      _$SellerStatsFromJson(json);
}

/// Canonical seller record + denormalized loads for the buyer-facing
/// profile screen.
@freezed
abstract class SellerProfile with _$SellerProfile {
  const factory SellerProfile({
    // Identity
    required String id,
    required String name,
    required String avatarUrl,
    required SellerCategory category,
    required String categoryTag,
    required String cuisineType,
    required String bio,

    // Service
    required String neighborhood,
    required MapPoint location,
    required double deliveryRadiusKm,
    required double deliveryFee,
    required int prepMinMinutes,
    required int prepMaxMinutes,

    // Profile metadata
    required List<String> languageCodes,
    required DateTime memberSince,
    required String availabilitySchedule,
    required List<String> verifications,

    // Aggregates
    required SellerStats stats,

    // Buyer context (transient)
    @Default(0) double distanceKm,
    @Default('') String lastActiveAgo,

    // Denormalized loads
    @Default(<String>[]) List<String> menuCategories,
    @Default(<FoodListing>[]) List<FoodListing> listings,
    @Default(<SellerReview>[]) List<SellerReview> recentReviews,
    String? promoText,
  }) = _SellerProfile;

  factory SellerProfile.fromJson(Map<String, dynamic> json) =>
      _$SellerProfileFromJson(json);
}

@freezed
abstract class SentimentTag with _$SentimentTag {
  const factory SentimentTag({
    required String label,
    required int count,
  }) = _SentimentTag;

  factory SentimentTag.fromJson(Map<String, dynamic> json) =>
      _$SentimentTagFromJson(json);
}

@freezed
abstract class SellerReview with _$SellerReview {
  const factory SellerReview({
    required String authorName,
    required String avatarUrl,
    required int rating,
    required String body,
    required String timeAgoLabel,
    required int helpfulCount,
  }) = _SellerReview;

  factory SellerReview.fromJson(Map<String, dynamic> json) =>
      _$SellerReviewFromJson(json);
}
