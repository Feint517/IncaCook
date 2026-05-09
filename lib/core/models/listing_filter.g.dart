// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListingFilter _$ListingFilterFromJson(Map<String, dynamic> json) =>
    _ListingFilter(
      category: $enumDecodeNullable(_$SellerCategoryEnumMap, json['category']),
      cuisines:
          (json['cuisines'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$CuisineTypeEnumMap, e))
              .toSet() ??
          const <CuisineType>{},
      diets:
          (json['diets'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DietaryTagEnumMap, e))
              .toSet() ??
          const <DietaryTag>{},
      dishTypes:
          (json['dish_types'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DishTypeEnumMap, e))
              .toSet() ??
          const <DishType>{},
      allergensToExclude:
          (json['allergens_to_exclude'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$AllergenEnumMap, e))
              .toSet() ??
          const <Allergen>{},
      maxDistanceKm: (json['max_distance_km'] as num?)?.toDouble(),
      inStockOnly: json['in_stock_only'] as bool? ?? false,
    );

Map<String, dynamic> _$ListingFilterToJson(
  _ListingFilter instance,
) => <String, dynamic>{
  'category': ?_$SellerCategoryEnumMap[instance.category],
  'cuisines': instance.cuisines.map((e) => _$CuisineTypeEnumMap[e]!).toList(),
  'diets': instance.diets.map((e) => _$DietaryTagEnumMap[e]!).toList(),
  'dish_types': instance.dishTypes.map((e) => _$DishTypeEnumMap[e]!).toList(),
  'allergens_to_exclude': instance.allergensToExclude
      .map((e) => _$AllergenEnumMap[e]!)
      .toList(),
  'max_distance_km': ?instance.maxDistanceKm,
  'in_stock_only': instance.inStockOnly,
};

const _$SellerCategoryEnumMap = {
  SellerCategory.faitMaison: 'faitMaison',
  SellerCategory.traiteur: 'traiteur',
  SellerCategory.restaurant: 'restaurant',
};

const _$CuisineTypeEnumMap = {
  CuisineType.orientale: 'orientale',
  CuisineType.francaise: 'francaise',
  CuisineType.africaine: 'africaine',
  CuisineType.portugaise: 'portugaise',
  CuisineType.italienne: 'italienne',
  CuisineType.espagnole: 'espagnole',
  CuisineType.latine: 'latine',
};

const _$DietaryTagEnumMap = {
  DietaryTag.halal: 'halal',
  DietaryTag.vegan: 'vegan',
  DietaryTag.glutenFree: 'glutenFree',
  DietaryTag.casher: 'casher',
};

const _$DishTypeEnumMap = {
  DishType.entree: 'entree',
  DishType.plat: 'plat',
  DishType.dessert: 'dessert',
  DishType.cocktailDinatoire: 'cocktailDinatoire',
};

const _$AllergenEnumMap = {
  Allergen.gluten: 'gluten',
  Allergen.crustaces: 'crustaces',
  Allergen.oeufs: 'oeufs',
  Allergen.poissons: 'poissons',
  Allergen.arachides: 'arachides',
  Allergen.soja: 'soja',
  Allergen.lait: 'lait',
  Allergen.fruitsACoque: 'fruitsACoque',
  Allergen.celeri: 'celeri',
  Allergen.moutarde: 'moutarde',
  Allergen.sesame: 'sesame',
  Allergen.sulfites: 'sulfites',
  Allergen.lupin: 'lupin',
  Allergen.mollusques: 'mollusques',
};
