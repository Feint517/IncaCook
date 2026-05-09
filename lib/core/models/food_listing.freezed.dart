// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FoodListing {

 String get id; String get name; String get imageUrl; String get sellerName; SellerCategory get category; double get price; int get portionsLeft; Fulfillment get fulfillment; DateTime get expiresAt; double get distanceKm; double get rating; int get reviewCount; double? get originalPrice; int get discountPercent; int? get prepMinutes; bool get isAvailable; bool get isVeg;/// Seller-defined sub-category (e.g. "Pizza mixte", "Plat du jour").
/// Free text. Independent of the platform-level [category].
 String? get menuCategory; List<DietaryTag> get dietaryTags; CuisineType? get cuisineType; DishType? get dishType; List<Allergen> get allergens;/// Free-text "other" allergens not covered by [Allergen]'s 14
/// EU-mandated categories. Null/empty when the seller has nothing to
/// declare here.
 String? get otherAllergens;
/// Create a copy of FoodListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodListingCopyWith<FoodListing> get copyWith => _$FoodListingCopyWithImpl<FoodListing>(this as FoodListing, _$identity);

  /// Serializes this FoodListing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodListing&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.portionsLeft, portionsLeft) || other.portionsLeft == portionsLeft)&&(identical(other.fulfillment, fulfillment) || other.fulfillment == fulfillment)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent)&&(identical(other.prepMinutes, prepMinutes) || other.prepMinutes == prepMinutes)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isVeg, isVeg) || other.isVeg == isVeg)&&(identical(other.menuCategory, menuCategory) || other.menuCategory == menuCategory)&&const DeepCollectionEquality().equals(other.dietaryTags, dietaryTags)&&(identical(other.cuisineType, cuisineType) || other.cuisineType == cuisineType)&&(identical(other.dishType, dishType) || other.dishType == dishType)&&const DeepCollectionEquality().equals(other.allergens, allergens)&&(identical(other.otherAllergens, otherAllergens) || other.otherAllergens == otherAllergens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,imageUrl,sellerName,category,price,portionsLeft,fulfillment,expiresAt,distanceKm,rating,reviewCount,originalPrice,discountPercent,prepMinutes,isAvailable,isVeg,menuCategory,const DeepCollectionEquality().hash(dietaryTags),cuisineType,dishType,const DeepCollectionEquality().hash(allergens),otherAllergens]);

@override
String toString() {
  return 'FoodListing(id: $id, name: $name, imageUrl: $imageUrl, sellerName: $sellerName, category: $category, price: $price, portionsLeft: $portionsLeft, fulfillment: $fulfillment, expiresAt: $expiresAt, distanceKm: $distanceKm, rating: $rating, reviewCount: $reviewCount, originalPrice: $originalPrice, discountPercent: $discountPercent, prepMinutes: $prepMinutes, isAvailable: $isAvailable, isVeg: $isVeg, menuCategory: $menuCategory, dietaryTags: $dietaryTags, cuisineType: $cuisineType, dishType: $dishType, allergens: $allergens, otherAllergens: $otherAllergens)';
}


}

/// @nodoc
abstract mixin class $FoodListingCopyWith<$Res>  {
  factory $FoodListingCopyWith(FoodListing value, $Res Function(FoodListing) _then) = _$FoodListingCopyWithImpl;
@useResult
$Res call({
 String id, String name, String imageUrl, String sellerName, SellerCategory category, double price, int portionsLeft, Fulfillment fulfillment, DateTime expiresAt, double distanceKm, double rating, int reviewCount, double? originalPrice, int discountPercent, int? prepMinutes, bool isAvailable, bool isVeg, String? menuCategory, List<DietaryTag> dietaryTags, CuisineType? cuisineType, DishType? dishType, List<Allergen> allergens, String? otherAllergens
});




}
/// @nodoc
class _$FoodListingCopyWithImpl<$Res>
    implements $FoodListingCopyWith<$Res> {
  _$FoodListingCopyWithImpl(this._self, this._then);

  final FoodListing _self;
  final $Res Function(FoodListing) _then;

/// Create a copy of FoodListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? sellerName = null,Object? category = null,Object? price = null,Object? portionsLeft = null,Object? fulfillment = null,Object? expiresAt = null,Object? distanceKm = null,Object? rating = null,Object? reviewCount = null,Object? originalPrice = freezed,Object? discountPercent = null,Object? prepMinutes = freezed,Object? isAvailable = null,Object? isVeg = null,Object? menuCategory = freezed,Object? dietaryTags = null,Object? cuisineType = freezed,Object? dishType = freezed,Object? allergens = null,Object? otherAllergens = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SellerCategory,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,portionsLeft: null == portionsLeft ? _self.portionsLeft : portionsLeft // ignore: cast_nullable_to_non_nullable
as int,fulfillment: null == fulfillment ? _self.fulfillment : fulfillment // ignore: cast_nullable_to_non_nullable
as Fulfillment,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,originalPrice: freezed == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as double?,discountPercent: null == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int,prepMinutes: freezed == prepMinutes ? _self.prepMinutes : prepMinutes // ignore: cast_nullable_to_non_nullable
as int?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isVeg: null == isVeg ? _self.isVeg : isVeg // ignore: cast_nullable_to_non_nullable
as bool,menuCategory: freezed == menuCategory ? _self.menuCategory : menuCategory // ignore: cast_nullable_to_non_nullable
as String?,dietaryTags: null == dietaryTags ? _self.dietaryTags : dietaryTags // ignore: cast_nullable_to_non_nullable
as List<DietaryTag>,cuisineType: freezed == cuisineType ? _self.cuisineType : cuisineType // ignore: cast_nullable_to_non_nullable
as CuisineType?,dishType: freezed == dishType ? _self.dishType : dishType // ignore: cast_nullable_to_non_nullable
as DishType?,allergens: null == allergens ? _self.allergens : allergens // ignore: cast_nullable_to_non_nullable
as List<Allergen>,otherAllergens: freezed == otherAllergens ? _self.otherAllergens : otherAllergens // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodListing].
extension FoodListingPatterns on FoodListing {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodListing() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodListing value)  $default,){
final _that = this;
switch (_that) {
case _FoodListing():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodListing value)?  $default,){
final _that = this;
switch (_that) {
case _FoodListing() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  String sellerName,  SellerCategory category,  double price,  int portionsLeft,  Fulfillment fulfillment,  DateTime expiresAt,  double distanceKm,  double rating,  int reviewCount,  double? originalPrice,  int discountPercent,  int? prepMinutes,  bool isAvailable,  bool isVeg,  String? menuCategory,  List<DietaryTag> dietaryTags,  CuisineType? cuisineType,  DishType? dishType,  List<Allergen> allergens,  String? otherAllergens)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodListing() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.sellerName,_that.category,_that.price,_that.portionsLeft,_that.fulfillment,_that.expiresAt,_that.distanceKm,_that.rating,_that.reviewCount,_that.originalPrice,_that.discountPercent,_that.prepMinutes,_that.isAvailable,_that.isVeg,_that.menuCategory,_that.dietaryTags,_that.cuisineType,_that.dishType,_that.allergens,_that.otherAllergens);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String imageUrl,  String sellerName,  SellerCategory category,  double price,  int portionsLeft,  Fulfillment fulfillment,  DateTime expiresAt,  double distanceKm,  double rating,  int reviewCount,  double? originalPrice,  int discountPercent,  int? prepMinutes,  bool isAvailable,  bool isVeg,  String? menuCategory,  List<DietaryTag> dietaryTags,  CuisineType? cuisineType,  DishType? dishType,  List<Allergen> allergens,  String? otherAllergens)  $default,) {final _that = this;
switch (_that) {
case _FoodListing():
return $default(_that.id,_that.name,_that.imageUrl,_that.sellerName,_that.category,_that.price,_that.portionsLeft,_that.fulfillment,_that.expiresAt,_that.distanceKm,_that.rating,_that.reviewCount,_that.originalPrice,_that.discountPercent,_that.prepMinutes,_that.isAvailable,_that.isVeg,_that.menuCategory,_that.dietaryTags,_that.cuisineType,_that.dishType,_that.allergens,_that.otherAllergens);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String imageUrl,  String sellerName,  SellerCategory category,  double price,  int portionsLeft,  Fulfillment fulfillment,  DateTime expiresAt,  double distanceKm,  double rating,  int reviewCount,  double? originalPrice,  int discountPercent,  int? prepMinutes,  bool isAvailable,  bool isVeg,  String? menuCategory,  List<DietaryTag> dietaryTags,  CuisineType? cuisineType,  DishType? dishType,  List<Allergen> allergens,  String? otherAllergens)?  $default,) {final _that = this;
switch (_that) {
case _FoodListing() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl,_that.sellerName,_that.category,_that.price,_that.portionsLeft,_that.fulfillment,_that.expiresAt,_that.distanceKm,_that.rating,_that.reviewCount,_that.originalPrice,_that.discountPercent,_that.prepMinutes,_that.isAvailable,_that.isVeg,_that.menuCategory,_that.dietaryTags,_that.cuisineType,_that.dishType,_that.allergens,_that.otherAllergens);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoodListing implements FoodListing {
  const _FoodListing({required this.id, required this.name, required this.imageUrl, required this.sellerName, required this.category, required this.price, required this.portionsLeft, required this.fulfillment, required this.expiresAt, this.distanceKm = 0, this.rating = 0, this.reviewCount = 0, this.originalPrice, this.discountPercent = 0, this.prepMinutes, this.isAvailable = true, this.isVeg = false, this.menuCategory, final  List<DietaryTag> dietaryTags = const <DietaryTag>[], this.cuisineType, this.dishType, final  List<Allergen> allergens = const <Allergen>[], this.otherAllergens}): _dietaryTags = dietaryTags,_allergens = allergens;
  factory _FoodListing.fromJson(Map<String, dynamic> json) => _$FoodListingFromJson(json);

@override final  String id;
@override final  String name;
@override final  String imageUrl;
@override final  String sellerName;
@override final  SellerCategory category;
@override final  double price;
@override final  int portionsLeft;
@override final  Fulfillment fulfillment;
@override final  DateTime expiresAt;
@override@JsonKey() final  double distanceKm;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
@override final  double? originalPrice;
@override@JsonKey() final  int discountPercent;
@override final  int? prepMinutes;
@override@JsonKey() final  bool isAvailable;
@override@JsonKey() final  bool isVeg;
/// Seller-defined sub-category (e.g. "Pizza mixte", "Plat du jour").
/// Free text. Independent of the platform-level [category].
@override final  String? menuCategory;
 final  List<DietaryTag> _dietaryTags;
@override@JsonKey() List<DietaryTag> get dietaryTags {
  if (_dietaryTags is EqualUnmodifiableListView) return _dietaryTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dietaryTags);
}

@override final  CuisineType? cuisineType;
@override final  DishType? dishType;
 final  List<Allergen> _allergens;
@override@JsonKey() List<Allergen> get allergens {
  if (_allergens is EqualUnmodifiableListView) return _allergens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allergens);
}

/// Free-text "other" allergens not covered by [Allergen]'s 14
/// EU-mandated categories. Null/empty when the seller has nothing to
/// declare here.
@override final  String? otherAllergens;

/// Create a copy of FoodListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodListingCopyWith<_FoodListing> get copyWith => __$FoodListingCopyWithImpl<_FoodListing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoodListingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodListing&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price)&&(identical(other.portionsLeft, portionsLeft) || other.portionsLeft == portionsLeft)&&(identical(other.fulfillment, fulfillment) || other.fulfillment == fulfillment)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.originalPrice, originalPrice) || other.originalPrice == originalPrice)&&(identical(other.discountPercent, discountPercent) || other.discountPercent == discountPercent)&&(identical(other.prepMinutes, prepMinutes) || other.prepMinutes == prepMinutes)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isVeg, isVeg) || other.isVeg == isVeg)&&(identical(other.menuCategory, menuCategory) || other.menuCategory == menuCategory)&&const DeepCollectionEquality().equals(other._dietaryTags, _dietaryTags)&&(identical(other.cuisineType, cuisineType) || other.cuisineType == cuisineType)&&(identical(other.dishType, dishType) || other.dishType == dishType)&&const DeepCollectionEquality().equals(other._allergens, _allergens)&&(identical(other.otherAllergens, otherAllergens) || other.otherAllergens == otherAllergens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,imageUrl,sellerName,category,price,portionsLeft,fulfillment,expiresAt,distanceKm,rating,reviewCount,originalPrice,discountPercent,prepMinutes,isAvailable,isVeg,menuCategory,const DeepCollectionEquality().hash(_dietaryTags),cuisineType,dishType,const DeepCollectionEquality().hash(_allergens),otherAllergens]);

@override
String toString() {
  return 'FoodListing(id: $id, name: $name, imageUrl: $imageUrl, sellerName: $sellerName, category: $category, price: $price, portionsLeft: $portionsLeft, fulfillment: $fulfillment, expiresAt: $expiresAt, distanceKm: $distanceKm, rating: $rating, reviewCount: $reviewCount, originalPrice: $originalPrice, discountPercent: $discountPercent, prepMinutes: $prepMinutes, isAvailable: $isAvailable, isVeg: $isVeg, menuCategory: $menuCategory, dietaryTags: $dietaryTags, cuisineType: $cuisineType, dishType: $dishType, allergens: $allergens, otherAllergens: $otherAllergens)';
}


}

/// @nodoc
abstract mixin class _$FoodListingCopyWith<$Res> implements $FoodListingCopyWith<$Res> {
  factory _$FoodListingCopyWith(_FoodListing value, $Res Function(_FoodListing) _then) = __$FoodListingCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String imageUrl, String sellerName, SellerCategory category, double price, int portionsLeft, Fulfillment fulfillment, DateTime expiresAt, double distanceKm, double rating, int reviewCount, double? originalPrice, int discountPercent, int? prepMinutes, bool isAvailable, bool isVeg, String? menuCategory, List<DietaryTag> dietaryTags, CuisineType? cuisineType, DishType? dishType, List<Allergen> allergens, String? otherAllergens
});




}
/// @nodoc
class __$FoodListingCopyWithImpl<$Res>
    implements _$FoodListingCopyWith<$Res> {
  __$FoodListingCopyWithImpl(this._self, this._then);

  final _FoodListing _self;
  final $Res Function(_FoodListing) _then;

/// Create a copy of FoodListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = null,Object? sellerName = null,Object? category = null,Object? price = null,Object? portionsLeft = null,Object? fulfillment = null,Object? expiresAt = null,Object? distanceKm = null,Object? rating = null,Object? reviewCount = null,Object? originalPrice = freezed,Object? discountPercent = null,Object? prepMinutes = freezed,Object? isAvailable = null,Object? isVeg = null,Object? menuCategory = freezed,Object? dietaryTags = null,Object? cuisineType = freezed,Object? dishType = freezed,Object? allergens = null,Object? otherAllergens = freezed,}) {
  return _then(_FoodListing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SellerCategory,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,portionsLeft: null == portionsLeft ? _self.portionsLeft : portionsLeft // ignore: cast_nullable_to_non_nullable
as int,fulfillment: null == fulfillment ? _self.fulfillment : fulfillment // ignore: cast_nullable_to_non_nullable
as Fulfillment,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,originalPrice: freezed == originalPrice ? _self.originalPrice : originalPrice // ignore: cast_nullable_to_non_nullable
as double?,discountPercent: null == discountPercent ? _self.discountPercent : discountPercent // ignore: cast_nullable_to_non_nullable
as int,prepMinutes: freezed == prepMinutes ? _self.prepMinutes : prepMinutes // ignore: cast_nullable_to_non_nullable
as int?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isVeg: null == isVeg ? _self.isVeg : isVeg // ignore: cast_nullable_to_non_nullable
as bool,menuCategory: freezed == menuCategory ? _self.menuCategory : menuCategory // ignore: cast_nullable_to_non_nullable
as String?,dietaryTags: null == dietaryTags ? _self._dietaryTags : dietaryTags // ignore: cast_nullable_to_non_nullable
as List<DietaryTag>,cuisineType: freezed == cuisineType ? _self.cuisineType : cuisineType // ignore: cast_nullable_to_non_nullable
as CuisineType?,dishType: freezed == dishType ? _self.dishType : dishType // ignore: cast_nullable_to_non_nullable
as DishType?,allergens: null == allergens ? _self._allergens : allergens // ignore: cast_nullable_to_non_nullable
as List<Allergen>,otherAllergens: freezed == otherAllergens ? _self.otherAllergens : otherAllergens // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
