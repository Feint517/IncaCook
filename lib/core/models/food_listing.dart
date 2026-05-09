import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/core/enums/order_enums.dart';

part 'food_listing.freezed.dart';
part 'food_listing.g.dart';

/// A dish offered for sale. Shared by buyer-facing screens (feed, product
/// detail, cart) and seller-facing screens (dashboard product list).
///
/// Field groups:
/// - **Identity / catalog**: id, name, imageUrl, price, originalPrice,
///   menuCategory, dietary/cuisine/dish/allergen metadata
/// - **Inventory**: portionsLeft, expiresAt, isAvailable, prepMinutes,
///   discountPercent
/// - **Seller-attached**: sellerName, category (platform-level
///   classification: faitMaison / traiteur / restaurant)
/// - **Buyer-side aggregates** (denormalized for the feed; computed from
///   joins on the backend): distanceKm, rating, reviewCount
@freezed
abstract class FoodListing with _$FoodListing {
  const factory FoodListing({
    required String id,
    required String name,
    required String imageUrl,
    required String sellerName,
    required SellerCategory category,
    required double price,
    required int portionsLeft,
    required Fulfillment fulfillment,
    required DateTime expiresAt,
    @Default(0) double distanceKm,
    @Default(0) double rating,
    @Default(0) int reviewCount,
    double? originalPrice,
    @Default(0) int discountPercent,
    int? prepMinutes,
    @Default(true) bool isAvailable,
    @Default(false) bool isVeg,

    /// Seller-defined sub-category (e.g. "Pizza mixte", "Plat du jour").
    /// Free text. Independent of the platform-level [category].
    String? menuCategory,
    @Default(<DietaryTag>[]) List<DietaryTag> dietaryTags,
    CuisineType? cuisineType,
    DishType? dishType,
    @Default(<Allergen>[]) List<Allergen> allergens,

    /// Free-text "other" allergens not covered by [Allergen]'s 14
    /// EU-mandated categories. Null/empty when the seller has nothing to
    /// declare here.
    String? otherAllergens,
  }) = _FoodListing;

  factory FoodListing.fromJson(Map<String, dynamic> json) =>
      _$FoodListingFromJson(json);
}
