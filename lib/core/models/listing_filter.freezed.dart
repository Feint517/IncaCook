// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListingFilter {

 SellerCategory? get category; Set<CuisineType> get cuisines; Set<DietaryTag> get diets; Set<DishType> get dishTypes; Set<Allergen> get allergensToExclude; double? get maxDistanceKm; bool get inStockOnly;
/// Create a copy of ListingFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListingFilterCopyWith<ListingFilter> get copyWith => _$ListingFilterCopyWithImpl<ListingFilter>(this as ListingFilter, _$identity);

  /// Serializes this ListingFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListingFilter&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.cuisines, cuisines)&&const DeepCollectionEquality().equals(other.diets, diets)&&const DeepCollectionEquality().equals(other.dishTypes, dishTypes)&&const DeepCollectionEquality().equals(other.allergensToExclude, allergensToExclude)&&(identical(other.maxDistanceKm, maxDistanceKm) || other.maxDistanceKm == maxDistanceKm)&&(identical(other.inStockOnly, inStockOnly) || other.inStockOnly == inStockOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,const DeepCollectionEquality().hash(cuisines),const DeepCollectionEquality().hash(diets),const DeepCollectionEquality().hash(dishTypes),const DeepCollectionEquality().hash(allergensToExclude),maxDistanceKm,inStockOnly);

@override
String toString() {
  return 'ListingFilter(category: $category, cuisines: $cuisines, diets: $diets, dishTypes: $dishTypes, allergensToExclude: $allergensToExclude, maxDistanceKm: $maxDistanceKm, inStockOnly: $inStockOnly)';
}


}

/// @nodoc
abstract mixin class $ListingFilterCopyWith<$Res>  {
  factory $ListingFilterCopyWith(ListingFilter value, $Res Function(ListingFilter) _then) = _$ListingFilterCopyWithImpl;
@useResult
$Res call({
 SellerCategory? category, Set<CuisineType> cuisines, Set<DietaryTag> diets, Set<DishType> dishTypes, Set<Allergen> allergensToExclude, double? maxDistanceKm, bool inStockOnly
});




}
/// @nodoc
class _$ListingFilterCopyWithImpl<$Res>
    implements $ListingFilterCopyWith<$Res> {
  _$ListingFilterCopyWithImpl(this._self, this._then);

  final ListingFilter _self;
  final $Res Function(ListingFilter) _then;

/// Create a copy of ListingFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = freezed,Object? cuisines = null,Object? diets = null,Object? dishTypes = null,Object? allergensToExclude = null,Object? maxDistanceKm = freezed,Object? inStockOnly = null,}) {
  return _then(_self.copyWith(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SellerCategory?,cuisines: null == cuisines ? _self.cuisines : cuisines // ignore: cast_nullable_to_non_nullable
as Set<CuisineType>,diets: null == diets ? _self.diets : diets // ignore: cast_nullable_to_non_nullable
as Set<DietaryTag>,dishTypes: null == dishTypes ? _self.dishTypes : dishTypes // ignore: cast_nullable_to_non_nullable
as Set<DishType>,allergensToExclude: null == allergensToExclude ? _self.allergensToExclude : allergensToExclude // ignore: cast_nullable_to_non_nullable
as Set<Allergen>,maxDistanceKm: freezed == maxDistanceKm ? _self.maxDistanceKm : maxDistanceKm // ignore: cast_nullable_to_non_nullable
as double?,inStockOnly: null == inStockOnly ? _self.inStockOnly : inStockOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ListingFilter].
extension ListingFilterPatterns on ListingFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListingFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListingFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListingFilter value)  $default,){
final _that = this;
switch (_that) {
case _ListingFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListingFilter value)?  $default,){
final _that = this;
switch (_that) {
case _ListingFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SellerCategory? category,  Set<CuisineType> cuisines,  Set<DietaryTag> diets,  Set<DishType> dishTypes,  Set<Allergen> allergensToExclude,  double? maxDistanceKm,  bool inStockOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListingFilter() when $default != null:
return $default(_that.category,_that.cuisines,_that.diets,_that.dishTypes,_that.allergensToExclude,_that.maxDistanceKm,_that.inStockOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SellerCategory? category,  Set<CuisineType> cuisines,  Set<DietaryTag> diets,  Set<DishType> dishTypes,  Set<Allergen> allergensToExclude,  double? maxDistanceKm,  bool inStockOnly)  $default,) {final _that = this;
switch (_that) {
case _ListingFilter():
return $default(_that.category,_that.cuisines,_that.diets,_that.dishTypes,_that.allergensToExclude,_that.maxDistanceKm,_that.inStockOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SellerCategory? category,  Set<CuisineType> cuisines,  Set<DietaryTag> diets,  Set<DishType> dishTypes,  Set<Allergen> allergensToExclude,  double? maxDistanceKm,  bool inStockOnly)?  $default,) {final _that = this;
switch (_that) {
case _ListingFilter() when $default != null:
return $default(_that.category,_that.cuisines,_that.diets,_that.dishTypes,_that.allergensToExclude,_that.maxDistanceKm,_that.inStockOnly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListingFilter extends ListingFilter {
  const _ListingFilter({this.category, final  Set<CuisineType> cuisines = const <CuisineType>{}, final  Set<DietaryTag> diets = const <DietaryTag>{}, final  Set<DishType> dishTypes = const <DishType>{}, final  Set<Allergen> allergensToExclude = const <Allergen>{}, this.maxDistanceKm, this.inStockOnly = false}): _cuisines = cuisines,_diets = diets,_dishTypes = dishTypes,_allergensToExclude = allergensToExclude,super._();
  factory _ListingFilter.fromJson(Map<String, dynamic> json) => _$ListingFilterFromJson(json);

@override final  SellerCategory? category;
 final  Set<CuisineType> _cuisines;
@override@JsonKey() Set<CuisineType> get cuisines {
  if (_cuisines is EqualUnmodifiableSetView) return _cuisines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_cuisines);
}

 final  Set<DietaryTag> _diets;
@override@JsonKey() Set<DietaryTag> get diets {
  if (_diets is EqualUnmodifiableSetView) return _diets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_diets);
}

 final  Set<DishType> _dishTypes;
@override@JsonKey() Set<DishType> get dishTypes {
  if (_dishTypes is EqualUnmodifiableSetView) return _dishTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_dishTypes);
}

 final  Set<Allergen> _allergensToExclude;
@override@JsonKey() Set<Allergen> get allergensToExclude {
  if (_allergensToExclude is EqualUnmodifiableSetView) return _allergensToExclude;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_allergensToExclude);
}

@override final  double? maxDistanceKm;
@override@JsonKey() final  bool inStockOnly;

/// Create a copy of ListingFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListingFilterCopyWith<_ListingFilter> get copyWith => __$ListingFilterCopyWithImpl<_ListingFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListingFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListingFilter&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._cuisines, _cuisines)&&const DeepCollectionEquality().equals(other._diets, _diets)&&const DeepCollectionEquality().equals(other._dishTypes, _dishTypes)&&const DeepCollectionEquality().equals(other._allergensToExclude, _allergensToExclude)&&(identical(other.maxDistanceKm, maxDistanceKm) || other.maxDistanceKm == maxDistanceKm)&&(identical(other.inStockOnly, inStockOnly) || other.inStockOnly == inStockOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,const DeepCollectionEquality().hash(_cuisines),const DeepCollectionEquality().hash(_diets),const DeepCollectionEquality().hash(_dishTypes),const DeepCollectionEquality().hash(_allergensToExclude),maxDistanceKm,inStockOnly);

@override
String toString() {
  return 'ListingFilter(category: $category, cuisines: $cuisines, diets: $diets, dishTypes: $dishTypes, allergensToExclude: $allergensToExclude, maxDistanceKm: $maxDistanceKm, inStockOnly: $inStockOnly)';
}


}

/// @nodoc
abstract mixin class _$ListingFilterCopyWith<$Res> implements $ListingFilterCopyWith<$Res> {
  factory _$ListingFilterCopyWith(_ListingFilter value, $Res Function(_ListingFilter) _then) = __$ListingFilterCopyWithImpl;
@override @useResult
$Res call({
 SellerCategory? category, Set<CuisineType> cuisines, Set<DietaryTag> diets, Set<DishType> dishTypes, Set<Allergen> allergensToExclude, double? maxDistanceKm, bool inStockOnly
});




}
/// @nodoc
class __$ListingFilterCopyWithImpl<$Res>
    implements _$ListingFilterCopyWith<$Res> {
  __$ListingFilterCopyWithImpl(this._self, this._then);

  final _ListingFilter _self;
  final $Res Function(_ListingFilter) _then;

/// Create a copy of ListingFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = freezed,Object? cuisines = null,Object? diets = null,Object? dishTypes = null,Object? allergensToExclude = null,Object? maxDistanceKm = freezed,Object? inStockOnly = null,}) {
  return _then(_ListingFilter(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SellerCategory?,cuisines: null == cuisines ? _self._cuisines : cuisines // ignore: cast_nullable_to_non_nullable
as Set<CuisineType>,diets: null == diets ? _self._diets : diets // ignore: cast_nullable_to_non_nullable
as Set<DietaryTag>,dishTypes: null == dishTypes ? _self._dishTypes : dishTypes // ignore: cast_nullable_to_non_nullable
as Set<DishType>,allergensToExclude: null == allergensToExclude ? _self._allergensToExclude : allergensToExclude // ignore: cast_nullable_to_non_nullable
as Set<Allergen>,maxDistanceKm: freezed == maxDistanceKm ? _self.maxDistanceKm : maxDistanceKm // ignore: cast_nullable_to_non_nullable
as double?,inStockOnly: null == inStockOnly ? _self.inStockOnly : inStockOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
