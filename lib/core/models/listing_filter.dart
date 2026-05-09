import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:incacook/core/enums/food_enums.dart';

part 'listing_filter.freezed.dart';
part 'listing_filter.g.dart';

@freezed
abstract class ListingFilter with _$ListingFilter {
  const ListingFilter._();

  const factory ListingFilter({
    SellerCategory? category,
    @Default(<CuisineType>{}) Set<CuisineType> cuisines,
    @Default(<DietaryTag>{}) Set<DietaryTag> diets,
    @Default(<DishType>{}) Set<DishType> dishTypes,
    @Default(<Allergen>{}) Set<Allergen> allergensToExclude,
    double? maxDistanceKm,
    @Default(false) bool inStockOnly,
  }) = _ListingFilter;

  factory ListingFilter.fromJson(Map<String, dynamic> json) =>
      _$ListingFilterFromJson(json);

  static const double standardRadiusKm = 10.0;

  double get effectiveMaxRadiusKm =>
      maxDistanceKm ?? (category?.maxRadiusKm ?? standardRadiusKm);

  List<DishType> get applicableDishTypes =>
      category == null ? const [] : DishType.valuesFor(category!);

  bool get isEmpty =>
      category == null &&
      cuisines.isEmpty &&
      diets.isEmpty &&
      dishTypes.isEmpty &&
      allergensToExclude.isEmpty &&
      maxDistanceKm == null &&
      !inStockOnly;
}
