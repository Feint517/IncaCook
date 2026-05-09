// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SellerStats {

/// Overall average rating (0..5).
 double get rating; int get reviewCount; int get mealsSold;/// Bookmarks/favorites — listings the seller has had saved by buyers.
 int get mealsSaved;/// 0..100, percent of orders the seller responds to within SLA.
 int get responseRatePercent;/// Per-criterion ratings (hygiene / food quality / packaging).
 List<SellerRating> get criteriaRatings;/// Stars (1..5) → review count for that bucket.
 Map<int, double> get ratingDistribution;/// Most-mentioned tags from review text.
 List<SentimentTag> get sentimentTags;
/// Create a copy of SellerStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerStatsCopyWith<SellerStats> get copyWith => _$SellerStatsCopyWithImpl<SellerStats>(this as SellerStats, _$identity);

  /// Serializes this SellerStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerStats&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.mealsSold, mealsSold) || other.mealsSold == mealsSold)&&(identical(other.mealsSaved, mealsSaved) || other.mealsSaved == mealsSaved)&&(identical(other.responseRatePercent, responseRatePercent) || other.responseRatePercent == responseRatePercent)&&const DeepCollectionEquality().equals(other.criteriaRatings, criteriaRatings)&&const DeepCollectionEquality().equals(other.ratingDistribution, ratingDistribution)&&const DeepCollectionEquality().equals(other.sentimentTags, sentimentTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,reviewCount,mealsSold,mealsSaved,responseRatePercent,const DeepCollectionEquality().hash(criteriaRatings),const DeepCollectionEquality().hash(ratingDistribution),const DeepCollectionEquality().hash(sentimentTags));

@override
String toString() {
  return 'SellerStats(rating: $rating, reviewCount: $reviewCount, mealsSold: $mealsSold, mealsSaved: $mealsSaved, responseRatePercent: $responseRatePercent, criteriaRatings: $criteriaRatings, ratingDistribution: $ratingDistribution, sentimentTags: $sentimentTags)';
}


}

/// @nodoc
abstract mixin class $SellerStatsCopyWith<$Res>  {
  factory $SellerStatsCopyWith(SellerStats value, $Res Function(SellerStats) _then) = _$SellerStatsCopyWithImpl;
@useResult
$Res call({
 double rating, int reviewCount, int mealsSold, int mealsSaved, int responseRatePercent, List<SellerRating> criteriaRatings, Map<int, double> ratingDistribution, List<SentimentTag> sentimentTags
});




}
/// @nodoc
class _$SellerStatsCopyWithImpl<$Res>
    implements $SellerStatsCopyWith<$Res> {
  _$SellerStatsCopyWithImpl(this._self, this._then);

  final SellerStats _self;
  final $Res Function(SellerStats) _then;

/// Create a copy of SellerStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? reviewCount = null,Object? mealsSold = null,Object? mealsSaved = null,Object? responseRatePercent = null,Object? criteriaRatings = null,Object? ratingDistribution = null,Object? sentimentTags = null,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,mealsSold: null == mealsSold ? _self.mealsSold : mealsSold // ignore: cast_nullable_to_non_nullable
as int,mealsSaved: null == mealsSaved ? _self.mealsSaved : mealsSaved // ignore: cast_nullable_to_non_nullable
as int,responseRatePercent: null == responseRatePercent ? _self.responseRatePercent : responseRatePercent // ignore: cast_nullable_to_non_nullable
as int,criteriaRatings: null == criteriaRatings ? _self.criteriaRatings : criteriaRatings // ignore: cast_nullable_to_non_nullable
as List<SellerRating>,ratingDistribution: null == ratingDistribution ? _self.ratingDistribution : ratingDistribution // ignore: cast_nullable_to_non_nullable
as Map<int, double>,sentimentTags: null == sentimentTags ? _self.sentimentTags : sentimentTags // ignore: cast_nullable_to_non_nullable
as List<SentimentTag>,
  ));
}

}


/// Adds pattern-matching-related methods to [SellerStats].
extension SellerStatsPatterns on SellerStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SellerStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellerStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SellerStats value)  $default,){
final _that = this;
switch (_that) {
case _SellerStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SellerStats value)?  $default,){
final _that = this;
switch (_that) {
case _SellerStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double rating,  int reviewCount,  int mealsSold,  int mealsSaved,  int responseRatePercent,  List<SellerRating> criteriaRatings,  Map<int, double> ratingDistribution,  List<SentimentTag> sentimentTags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellerStats() when $default != null:
return $default(_that.rating,_that.reviewCount,_that.mealsSold,_that.mealsSaved,_that.responseRatePercent,_that.criteriaRatings,_that.ratingDistribution,_that.sentimentTags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double rating,  int reviewCount,  int mealsSold,  int mealsSaved,  int responseRatePercent,  List<SellerRating> criteriaRatings,  Map<int, double> ratingDistribution,  List<SentimentTag> sentimentTags)  $default,) {final _that = this;
switch (_that) {
case _SellerStats():
return $default(_that.rating,_that.reviewCount,_that.mealsSold,_that.mealsSaved,_that.responseRatePercent,_that.criteriaRatings,_that.ratingDistribution,_that.sentimentTags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double rating,  int reviewCount,  int mealsSold,  int mealsSaved,  int responseRatePercent,  List<SellerRating> criteriaRatings,  Map<int, double> ratingDistribution,  List<SentimentTag> sentimentTags)?  $default,) {final _that = this;
switch (_that) {
case _SellerStats() when $default != null:
return $default(_that.rating,_that.reviewCount,_that.mealsSold,_that.mealsSaved,_that.responseRatePercent,_that.criteriaRatings,_that.ratingDistribution,_that.sentimentTags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SellerStats implements SellerStats {
  const _SellerStats({required this.rating, required this.reviewCount, required this.mealsSold, required this.mealsSaved, required this.responseRatePercent, required final  List<SellerRating> criteriaRatings, required final  Map<int, double> ratingDistribution, required final  List<SentimentTag> sentimentTags}): _criteriaRatings = criteriaRatings,_ratingDistribution = ratingDistribution,_sentimentTags = sentimentTags;
  factory _SellerStats.fromJson(Map<String, dynamic> json) => _$SellerStatsFromJson(json);

/// Overall average rating (0..5).
@override final  double rating;
@override final  int reviewCount;
@override final  int mealsSold;
/// Bookmarks/favorites — listings the seller has had saved by buyers.
@override final  int mealsSaved;
/// 0..100, percent of orders the seller responds to within SLA.
@override final  int responseRatePercent;
/// Per-criterion ratings (hygiene / food quality / packaging).
 final  List<SellerRating> _criteriaRatings;
/// Per-criterion ratings (hygiene / food quality / packaging).
@override List<SellerRating> get criteriaRatings {
  if (_criteriaRatings is EqualUnmodifiableListView) return _criteriaRatings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_criteriaRatings);
}

/// Stars (1..5) → review count for that bucket.
 final  Map<int, double> _ratingDistribution;
/// Stars (1..5) → review count for that bucket.
@override Map<int, double> get ratingDistribution {
  if (_ratingDistribution is EqualUnmodifiableMapView) return _ratingDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratingDistribution);
}

/// Most-mentioned tags from review text.
 final  List<SentimentTag> _sentimentTags;
/// Most-mentioned tags from review text.
@override List<SentimentTag> get sentimentTags {
  if (_sentimentTags is EqualUnmodifiableListView) return _sentimentTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sentimentTags);
}


/// Create a copy of SellerStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerStatsCopyWith<_SellerStats> get copyWith => __$SellerStatsCopyWithImpl<_SellerStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SellerStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerStats&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.mealsSold, mealsSold) || other.mealsSold == mealsSold)&&(identical(other.mealsSaved, mealsSaved) || other.mealsSaved == mealsSaved)&&(identical(other.responseRatePercent, responseRatePercent) || other.responseRatePercent == responseRatePercent)&&const DeepCollectionEquality().equals(other._criteriaRatings, _criteriaRatings)&&const DeepCollectionEquality().equals(other._ratingDistribution, _ratingDistribution)&&const DeepCollectionEquality().equals(other._sentimentTags, _sentimentTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,reviewCount,mealsSold,mealsSaved,responseRatePercent,const DeepCollectionEquality().hash(_criteriaRatings),const DeepCollectionEquality().hash(_ratingDistribution),const DeepCollectionEquality().hash(_sentimentTags));

@override
String toString() {
  return 'SellerStats(rating: $rating, reviewCount: $reviewCount, mealsSold: $mealsSold, mealsSaved: $mealsSaved, responseRatePercent: $responseRatePercent, criteriaRatings: $criteriaRatings, ratingDistribution: $ratingDistribution, sentimentTags: $sentimentTags)';
}


}

/// @nodoc
abstract mixin class _$SellerStatsCopyWith<$Res> implements $SellerStatsCopyWith<$Res> {
  factory _$SellerStatsCopyWith(_SellerStats value, $Res Function(_SellerStats) _then) = __$SellerStatsCopyWithImpl;
@override @useResult
$Res call({
 double rating, int reviewCount, int mealsSold, int mealsSaved, int responseRatePercent, List<SellerRating> criteriaRatings, Map<int, double> ratingDistribution, List<SentimentTag> sentimentTags
});




}
/// @nodoc
class __$SellerStatsCopyWithImpl<$Res>
    implements _$SellerStatsCopyWith<$Res> {
  __$SellerStatsCopyWithImpl(this._self, this._then);

  final _SellerStats _self;
  final $Res Function(_SellerStats) _then;

/// Create a copy of SellerStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? reviewCount = null,Object? mealsSold = null,Object? mealsSaved = null,Object? responseRatePercent = null,Object? criteriaRatings = null,Object? ratingDistribution = null,Object? sentimentTags = null,}) {
  return _then(_SellerStats(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,mealsSold: null == mealsSold ? _self.mealsSold : mealsSold // ignore: cast_nullable_to_non_nullable
as int,mealsSaved: null == mealsSaved ? _self.mealsSaved : mealsSaved // ignore: cast_nullable_to_non_nullable
as int,responseRatePercent: null == responseRatePercent ? _self.responseRatePercent : responseRatePercent // ignore: cast_nullable_to_non_nullable
as int,criteriaRatings: null == criteriaRatings ? _self._criteriaRatings : criteriaRatings // ignore: cast_nullable_to_non_nullable
as List<SellerRating>,ratingDistribution: null == ratingDistribution ? _self._ratingDistribution : ratingDistribution // ignore: cast_nullable_to_non_nullable
as Map<int, double>,sentimentTags: null == sentimentTags ? _self._sentimentTags : sentimentTags // ignore: cast_nullable_to_non_nullable
as List<SentimentTag>,
  ));
}


}


/// @nodoc
mixin _$SellerProfile {

// Identity
 String get id; String get name; String get avatarUrl; SellerCategory get category; String get categoryTag; String get cuisineType; String get bio;// Service
 String get neighborhood; MapPoint get location; double get deliveryRadiusKm; double get deliveryFee; int get prepMinMinutes; int get prepMaxMinutes;// Profile metadata
 List<String> get languageCodes; DateTime get memberSince; String get availabilitySchedule; List<String> get verifications;// Aggregates
 SellerStats get stats;// Buyer context (transient)
 double get distanceKm; String get lastActiveAgo;// Denormalized loads
 List<String> get menuCategories; List<FoodListing> get listings; List<SellerReview> get recentReviews; String? get promoText;
/// Create a copy of SellerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerProfileCopyWith<SellerProfile> get copyWith => _$SellerProfileCopyWithImpl<SellerProfile>(this as SellerProfile, _$identity);

  /// Serializes this SellerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryTag, categoryTag) || other.categoryTag == categoryTag)&&(identical(other.cuisineType, cuisineType) || other.cuisineType == cuisineType)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.location, location) || other.location == location)&&(identical(other.deliveryRadiusKm, deliveryRadiusKm) || other.deliveryRadiusKm == deliveryRadiusKm)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.prepMinMinutes, prepMinMinutes) || other.prepMinMinutes == prepMinMinutes)&&(identical(other.prepMaxMinutes, prepMaxMinutes) || other.prepMaxMinutes == prepMaxMinutes)&&const DeepCollectionEquality().equals(other.languageCodes, languageCodes)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.availabilitySchedule, availabilitySchedule) || other.availabilitySchedule == availabilitySchedule)&&const DeepCollectionEquality().equals(other.verifications, verifications)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.lastActiveAgo, lastActiveAgo) || other.lastActiveAgo == lastActiveAgo)&&const DeepCollectionEquality().equals(other.menuCategories, menuCategories)&&const DeepCollectionEquality().equals(other.listings, listings)&&const DeepCollectionEquality().equals(other.recentReviews, recentReviews)&&(identical(other.promoText, promoText) || other.promoText == promoText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,avatarUrl,category,categoryTag,cuisineType,bio,neighborhood,location,deliveryRadiusKm,deliveryFee,prepMinMinutes,prepMaxMinutes,const DeepCollectionEquality().hash(languageCodes),memberSince,availabilitySchedule,const DeepCollectionEquality().hash(verifications),stats,distanceKm,lastActiveAgo,const DeepCollectionEquality().hash(menuCategories),const DeepCollectionEquality().hash(listings),const DeepCollectionEquality().hash(recentReviews),promoText]);

@override
String toString() {
  return 'SellerProfile(id: $id, name: $name, avatarUrl: $avatarUrl, category: $category, categoryTag: $categoryTag, cuisineType: $cuisineType, bio: $bio, neighborhood: $neighborhood, location: $location, deliveryRadiusKm: $deliveryRadiusKm, deliveryFee: $deliveryFee, prepMinMinutes: $prepMinMinutes, prepMaxMinutes: $prepMaxMinutes, languageCodes: $languageCodes, memberSince: $memberSince, availabilitySchedule: $availabilitySchedule, verifications: $verifications, stats: $stats, distanceKm: $distanceKm, lastActiveAgo: $lastActiveAgo, menuCategories: $menuCategories, listings: $listings, recentReviews: $recentReviews, promoText: $promoText)';
}


}

/// @nodoc
abstract mixin class $SellerProfileCopyWith<$Res>  {
  factory $SellerProfileCopyWith(SellerProfile value, $Res Function(SellerProfile) _then) = _$SellerProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String avatarUrl, SellerCategory category, String categoryTag, String cuisineType, String bio, String neighborhood, MapPoint location, double deliveryRadiusKm, double deliveryFee, int prepMinMinutes, int prepMaxMinutes, List<String> languageCodes, DateTime memberSince, String availabilitySchedule, List<String> verifications, SellerStats stats, double distanceKm, String lastActiveAgo, List<String> menuCategories, List<FoodListing> listings, List<SellerReview> recentReviews, String? promoText
});


$MapPointCopyWith<$Res> get location;$SellerStatsCopyWith<$Res> get stats;

}
/// @nodoc
class _$SellerProfileCopyWithImpl<$Res>
    implements $SellerProfileCopyWith<$Res> {
  _$SellerProfileCopyWithImpl(this._self, this._then);

  final SellerProfile _self;
  final $Res Function(SellerProfile) _then;

/// Create a copy of SellerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatarUrl = null,Object? category = null,Object? categoryTag = null,Object? cuisineType = null,Object? bio = null,Object? neighborhood = null,Object? location = null,Object? deliveryRadiusKm = null,Object? deliveryFee = null,Object? prepMinMinutes = null,Object? prepMaxMinutes = null,Object? languageCodes = null,Object? memberSince = null,Object? availabilitySchedule = null,Object? verifications = null,Object? stats = null,Object? distanceKm = null,Object? lastActiveAgo = null,Object? menuCategories = null,Object? listings = null,Object? recentReviews = null,Object? promoText = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SellerCategory,categoryTag: null == categoryTag ? _self.categoryTag : categoryTag // ignore: cast_nullable_to_non_nullable
as String,cuisineType: null == cuisineType ? _self.cuisineType : cuisineType // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as MapPoint,deliveryRadiusKm: null == deliveryRadiusKm ? _self.deliveryRadiusKm : deliveryRadiusKm // ignore: cast_nullable_to_non_nullable
as double,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,prepMinMinutes: null == prepMinMinutes ? _self.prepMinMinutes : prepMinMinutes // ignore: cast_nullable_to_non_nullable
as int,prepMaxMinutes: null == prepMaxMinutes ? _self.prepMaxMinutes : prepMaxMinutes // ignore: cast_nullable_to_non_nullable
as int,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,memberSince: null == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as DateTime,availabilitySchedule: null == availabilitySchedule ? _self.availabilitySchedule : availabilitySchedule // ignore: cast_nullable_to_non_nullable
as String,verifications: null == verifications ? _self.verifications : verifications // ignore: cast_nullable_to_non_nullable
as List<String>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as SellerStats,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,lastActiveAgo: null == lastActiveAgo ? _self.lastActiveAgo : lastActiveAgo // ignore: cast_nullable_to_non_nullable
as String,menuCategories: null == menuCategories ? _self.menuCategories : menuCategories // ignore: cast_nullable_to_non_nullable
as List<String>,listings: null == listings ? _self.listings : listings // ignore: cast_nullable_to_non_nullable
as List<FoodListing>,recentReviews: null == recentReviews ? _self.recentReviews : recentReviews // ignore: cast_nullable_to_non_nullable
as List<SellerReview>,promoText: freezed == promoText ? _self.promoText : promoText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SellerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapPointCopyWith<$Res> get location {
  
  return $MapPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of SellerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SellerStatsCopyWith<$Res> get stats {
  
  return $SellerStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [SellerProfile].
extension SellerProfilePatterns on SellerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SellerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SellerProfile value)  $default,){
final _that = this;
switch (_that) {
case _SellerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SellerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _SellerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String avatarUrl,  SellerCategory category,  String categoryTag,  String cuisineType,  String bio,  String neighborhood,  MapPoint location,  double deliveryRadiusKm,  double deliveryFee,  int prepMinMinutes,  int prepMaxMinutes,  List<String> languageCodes,  DateTime memberSince,  String availabilitySchedule,  List<String> verifications,  SellerStats stats,  double distanceKm,  String lastActiveAgo,  List<String> menuCategories,  List<FoodListing> listings,  List<SellerReview> recentReviews,  String? promoText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellerProfile() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.category,_that.categoryTag,_that.cuisineType,_that.bio,_that.neighborhood,_that.location,_that.deliveryRadiusKm,_that.deliveryFee,_that.prepMinMinutes,_that.prepMaxMinutes,_that.languageCodes,_that.memberSince,_that.availabilitySchedule,_that.verifications,_that.stats,_that.distanceKm,_that.lastActiveAgo,_that.menuCategories,_that.listings,_that.recentReviews,_that.promoText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String avatarUrl,  SellerCategory category,  String categoryTag,  String cuisineType,  String bio,  String neighborhood,  MapPoint location,  double deliveryRadiusKm,  double deliveryFee,  int prepMinMinutes,  int prepMaxMinutes,  List<String> languageCodes,  DateTime memberSince,  String availabilitySchedule,  List<String> verifications,  SellerStats stats,  double distanceKm,  String lastActiveAgo,  List<String> menuCategories,  List<FoodListing> listings,  List<SellerReview> recentReviews,  String? promoText)  $default,) {final _that = this;
switch (_that) {
case _SellerProfile():
return $default(_that.id,_that.name,_that.avatarUrl,_that.category,_that.categoryTag,_that.cuisineType,_that.bio,_that.neighborhood,_that.location,_that.deliveryRadiusKm,_that.deliveryFee,_that.prepMinMinutes,_that.prepMaxMinutes,_that.languageCodes,_that.memberSince,_that.availabilitySchedule,_that.verifications,_that.stats,_that.distanceKm,_that.lastActiveAgo,_that.menuCategories,_that.listings,_that.recentReviews,_that.promoText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String avatarUrl,  SellerCategory category,  String categoryTag,  String cuisineType,  String bio,  String neighborhood,  MapPoint location,  double deliveryRadiusKm,  double deliveryFee,  int prepMinMinutes,  int prepMaxMinutes,  List<String> languageCodes,  DateTime memberSince,  String availabilitySchedule,  List<String> verifications,  SellerStats stats,  double distanceKm,  String lastActiveAgo,  List<String> menuCategories,  List<FoodListing> listings,  List<SellerReview> recentReviews,  String? promoText)?  $default,) {final _that = this;
switch (_that) {
case _SellerProfile() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.category,_that.categoryTag,_that.cuisineType,_that.bio,_that.neighborhood,_that.location,_that.deliveryRadiusKm,_that.deliveryFee,_that.prepMinMinutes,_that.prepMaxMinutes,_that.languageCodes,_that.memberSince,_that.availabilitySchedule,_that.verifications,_that.stats,_that.distanceKm,_that.lastActiveAgo,_that.menuCategories,_that.listings,_that.recentReviews,_that.promoText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SellerProfile implements SellerProfile {
  const _SellerProfile({required this.id, required this.name, required this.avatarUrl, required this.category, required this.categoryTag, required this.cuisineType, required this.bio, required this.neighborhood, required this.location, required this.deliveryRadiusKm, required this.deliveryFee, required this.prepMinMinutes, required this.prepMaxMinutes, required final  List<String> languageCodes, required this.memberSince, required this.availabilitySchedule, required final  List<String> verifications, required this.stats, this.distanceKm = 0, this.lastActiveAgo = '', final  List<String> menuCategories = const <String>[], final  List<FoodListing> listings = const <FoodListing>[], final  List<SellerReview> recentReviews = const <SellerReview>[], this.promoText}): _languageCodes = languageCodes,_verifications = verifications,_menuCategories = menuCategories,_listings = listings,_recentReviews = recentReviews;
  factory _SellerProfile.fromJson(Map<String, dynamic> json) => _$SellerProfileFromJson(json);

// Identity
@override final  String id;
@override final  String name;
@override final  String avatarUrl;
@override final  SellerCategory category;
@override final  String categoryTag;
@override final  String cuisineType;
@override final  String bio;
// Service
@override final  String neighborhood;
@override final  MapPoint location;
@override final  double deliveryRadiusKm;
@override final  double deliveryFee;
@override final  int prepMinMinutes;
@override final  int prepMaxMinutes;
// Profile metadata
 final  List<String> _languageCodes;
// Profile metadata
@override List<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageCodes);
}

@override final  DateTime memberSince;
@override final  String availabilitySchedule;
 final  List<String> _verifications;
@override List<String> get verifications {
  if (_verifications is EqualUnmodifiableListView) return _verifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verifications);
}

// Aggregates
@override final  SellerStats stats;
// Buyer context (transient)
@override@JsonKey() final  double distanceKm;
@override@JsonKey() final  String lastActiveAgo;
// Denormalized loads
 final  List<String> _menuCategories;
// Denormalized loads
@override@JsonKey() List<String> get menuCategories {
  if (_menuCategories is EqualUnmodifiableListView) return _menuCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuCategories);
}

 final  List<FoodListing> _listings;
@override@JsonKey() List<FoodListing> get listings {
  if (_listings is EqualUnmodifiableListView) return _listings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listings);
}

 final  List<SellerReview> _recentReviews;
@override@JsonKey() List<SellerReview> get recentReviews {
  if (_recentReviews is EqualUnmodifiableListView) return _recentReviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentReviews);
}

@override final  String? promoText;

/// Create a copy of SellerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerProfileCopyWith<_SellerProfile> get copyWith => __$SellerProfileCopyWithImpl<_SellerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SellerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryTag, categoryTag) || other.categoryTag == categoryTag)&&(identical(other.cuisineType, cuisineType) || other.cuisineType == cuisineType)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.location, location) || other.location == location)&&(identical(other.deliveryRadiusKm, deliveryRadiusKm) || other.deliveryRadiusKm == deliveryRadiusKm)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.prepMinMinutes, prepMinMinutes) || other.prepMinMinutes == prepMinMinutes)&&(identical(other.prepMaxMinutes, prepMaxMinutes) || other.prepMaxMinutes == prepMaxMinutes)&&const DeepCollectionEquality().equals(other._languageCodes, _languageCodes)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.availabilitySchedule, availabilitySchedule) || other.availabilitySchedule == availabilitySchedule)&&const DeepCollectionEquality().equals(other._verifications, _verifications)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.lastActiveAgo, lastActiveAgo) || other.lastActiveAgo == lastActiveAgo)&&const DeepCollectionEquality().equals(other._menuCategories, _menuCategories)&&const DeepCollectionEquality().equals(other._listings, _listings)&&const DeepCollectionEquality().equals(other._recentReviews, _recentReviews)&&(identical(other.promoText, promoText) || other.promoText == promoText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,avatarUrl,category,categoryTag,cuisineType,bio,neighborhood,location,deliveryRadiusKm,deliveryFee,prepMinMinutes,prepMaxMinutes,const DeepCollectionEquality().hash(_languageCodes),memberSince,availabilitySchedule,const DeepCollectionEquality().hash(_verifications),stats,distanceKm,lastActiveAgo,const DeepCollectionEquality().hash(_menuCategories),const DeepCollectionEquality().hash(_listings),const DeepCollectionEquality().hash(_recentReviews),promoText]);

@override
String toString() {
  return 'SellerProfile(id: $id, name: $name, avatarUrl: $avatarUrl, category: $category, categoryTag: $categoryTag, cuisineType: $cuisineType, bio: $bio, neighborhood: $neighborhood, location: $location, deliveryRadiusKm: $deliveryRadiusKm, deliveryFee: $deliveryFee, prepMinMinutes: $prepMinMinutes, prepMaxMinutes: $prepMaxMinutes, languageCodes: $languageCodes, memberSince: $memberSince, availabilitySchedule: $availabilitySchedule, verifications: $verifications, stats: $stats, distanceKm: $distanceKm, lastActiveAgo: $lastActiveAgo, menuCategories: $menuCategories, listings: $listings, recentReviews: $recentReviews, promoText: $promoText)';
}


}

/// @nodoc
abstract mixin class _$SellerProfileCopyWith<$Res> implements $SellerProfileCopyWith<$Res> {
  factory _$SellerProfileCopyWith(_SellerProfile value, $Res Function(_SellerProfile) _then) = __$SellerProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String avatarUrl, SellerCategory category, String categoryTag, String cuisineType, String bio, String neighborhood, MapPoint location, double deliveryRadiusKm, double deliveryFee, int prepMinMinutes, int prepMaxMinutes, List<String> languageCodes, DateTime memberSince, String availabilitySchedule, List<String> verifications, SellerStats stats, double distanceKm, String lastActiveAgo, List<String> menuCategories, List<FoodListing> listings, List<SellerReview> recentReviews, String? promoText
});


@override $MapPointCopyWith<$Res> get location;@override $SellerStatsCopyWith<$Res> get stats;

}
/// @nodoc
class __$SellerProfileCopyWithImpl<$Res>
    implements _$SellerProfileCopyWith<$Res> {
  __$SellerProfileCopyWithImpl(this._self, this._then);

  final _SellerProfile _self;
  final $Res Function(_SellerProfile) _then;

/// Create a copy of SellerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = null,Object? category = null,Object? categoryTag = null,Object? cuisineType = null,Object? bio = null,Object? neighborhood = null,Object? location = null,Object? deliveryRadiusKm = null,Object? deliveryFee = null,Object? prepMinMinutes = null,Object? prepMaxMinutes = null,Object? languageCodes = null,Object? memberSince = null,Object? availabilitySchedule = null,Object? verifications = null,Object? stats = null,Object? distanceKm = null,Object? lastActiveAgo = null,Object? menuCategories = null,Object? listings = null,Object? recentReviews = null,Object? promoText = freezed,}) {
  return _then(_SellerProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SellerCategory,categoryTag: null == categoryTag ? _self.categoryTag : categoryTag // ignore: cast_nullable_to_non_nullable
as String,cuisineType: null == cuisineType ? _self.cuisineType : cuisineType // ignore: cast_nullable_to_non_nullable
as String,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as MapPoint,deliveryRadiusKm: null == deliveryRadiusKm ? _self.deliveryRadiusKm : deliveryRadiusKm // ignore: cast_nullable_to_non_nullable
as double,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,prepMinMinutes: null == prepMinMinutes ? _self.prepMinMinutes : prepMinMinutes // ignore: cast_nullable_to_non_nullable
as int,prepMaxMinutes: null == prepMaxMinutes ? _self.prepMaxMinutes : prepMaxMinutes // ignore: cast_nullable_to_non_nullable
as int,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,memberSince: null == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as DateTime,availabilitySchedule: null == availabilitySchedule ? _self.availabilitySchedule : availabilitySchedule // ignore: cast_nullable_to_non_nullable
as String,verifications: null == verifications ? _self._verifications : verifications // ignore: cast_nullable_to_non_nullable
as List<String>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as SellerStats,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,lastActiveAgo: null == lastActiveAgo ? _self.lastActiveAgo : lastActiveAgo // ignore: cast_nullable_to_non_nullable
as String,menuCategories: null == menuCategories ? _self._menuCategories : menuCategories // ignore: cast_nullable_to_non_nullable
as List<String>,listings: null == listings ? _self._listings : listings // ignore: cast_nullable_to_non_nullable
as List<FoodListing>,recentReviews: null == recentReviews ? _self._recentReviews : recentReviews // ignore: cast_nullable_to_non_nullable
as List<SellerReview>,promoText: freezed == promoText ? _self.promoText : promoText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SellerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapPointCopyWith<$Res> get location {
  
  return $MapPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of SellerProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SellerStatsCopyWith<$Res> get stats {
  
  return $SellerStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// @nodoc
mixin _$SentimentTag {

 String get label; int get count;
/// Create a copy of SentimentTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentTagCopyWith<SentimentTag> get copyWith => _$SentimentTagCopyWithImpl<SentimentTag>(this as SentimentTag, _$identity);

  /// Serializes this SentimentTag to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentTag&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,count);

@override
String toString() {
  return 'SentimentTag(label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class $SentimentTagCopyWith<$Res>  {
  factory $SentimentTagCopyWith(SentimentTag value, $Res Function(SentimentTag) _then) = _$SentimentTagCopyWithImpl;
@useResult
$Res call({
 String label, int count
});




}
/// @nodoc
class _$SentimentTagCopyWithImpl<$Res>
    implements $SentimentTagCopyWith<$Res> {
  _$SentimentTagCopyWithImpl(this._self, this._then);

  final SentimentTag _self;
  final $Res Function(SentimentTag) _then;

/// Create a copy of SentimentTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? count = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SentimentTag].
extension SentimentTagPatterns on SentimentTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentimentTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentimentTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentimentTag value)  $default,){
final _that = this;
switch (_that) {
case _SentimentTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentimentTag value)?  $default,){
final _that = this;
switch (_that) {
case _SentimentTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentimentTag() when $default != null:
return $default(_that.label,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int count)  $default,) {final _that = this;
switch (_that) {
case _SentimentTag():
return $default(_that.label,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int count)?  $default,) {final _that = this;
switch (_that) {
case _SentimentTag() when $default != null:
return $default(_that.label,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SentimentTag implements SentimentTag {
  const _SentimentTag({required this.label, required this.count});
  factory _SentimentTag.fromJson(Map<String, dynamic> json) => _$SentimentTagFromJson(json);

@override final  String label;
@override final  int count;

/// Create a copy of SentimentTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentTagCopyWith<_SentimentTag> get copyWith => __$SentimentTagCopyWithImpl<_SentimentTag>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SentimentTagToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentTag&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,count);

@override
String toString() {
  return 'SentimentTag(label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class _$SentimentTagCopyWith<$Res> implements $SentimentTagCopyWith<$Res> {
  factory _$SentimentTagCopyWith(_SentimentTag value, $Res Function(_SentimentTag) _then) = __$SentimentTagCopyWithImpl;
@override @useResult
$Res call({
 String label, int count
});




}
/// @nodoc
class __$SentimentTagCopyWithImpl<$Res>
    implements _$SentimentTagCopyWith<$Res> {
  __$SentimentTagCopyWithImpl(this._self, this._then);

  final _SentimentTag _self;
  final $Res Function(_SentimentTag) _then;

/// Create a copy of SentimentTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? count = null,}) {
  return _then(_SentimentTag(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SellerReview {

 String get authorName; String get avatarUrl; int get rating; String get body; String get timeAgoLabel; int get helpfulCount;
/// Create a copy of SellerReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerReviewCopyWith<SellerReview> get copyWith => _$SellerReviewCopyWithImpl<SellerReview>(this as SellerReview, _$identity);

  /// Serializes this SellerReview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerReview&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.body, body) || other.body == body)&&(identical(other.timeAgoLabel, timeAgoLabel) || other.timeAgoLabel == timeAgoLabel)&&(identical(other.helpfulCount, helpfulCount) || other.helpfulCount == helpfulCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorName,avatarUrl,rating,body,timeAgoLabel,helpfulCount);

@override
String toString() {
  return 'SellerReview(authorName: $authorName, avatarUrl: $avatarUrl, rating: $rating, body: $body, timeAgoLabel: $timeAgoLabel, helpfulCount: $helpfulCount)';
}


}

/// @nodoc
abstract mixin class $SellerReviewCopyWith<$Res>  {
  factory $SellerReviewCopyWith(SellerReview value, $Res Function(SellerReview) _then) = _$SellerReviewCopyWithImpl;
@useResult
$Res call({
 String authorName, String avatarUrl, int rating, String body, String timeAgoLabel, int helpfulCount
});




}
/// @nodoc
class _$SellerReviewCopyWithImpl<$Res>
    implements $SellerReviewCopyWith<$Res> {
  _$SellerReviewCopyWithImpl(this._self, this._then);

  final SellerReview _self;
  final $Res Function(SellerReview) _then;

/// Create a copy of SellerReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authorName = null,Object? avatarUrl = null,Object? rating = null,Object? body = null,Object? timeAgoLabel = null,Object? helpfulCount = null,}) {
  return _then(_self.copyWith(
authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,timeAgoLabel: null == timeAgoLabel ? _self.timeAgoLabel : timeAgoLabel // ignore: cast_nullable_to_non_nullable
as String,helpfulCount: null == helpfulCount ? _self.helpfulCount : helpfulCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SellerReview].
extension SellerReviewPatterns on SellerReview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SellerReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellerReview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SellerReview value)  $default,){
final _that = this;
switch (_that) {
case _SellerReview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SellerReview value)?  $default,){
final _that = this;
switch (_that) {
case _SellerReview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String authorName,  String avatarUrl,  int rating,  String body,  String timeAgoLabel,  int helpfulCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellerReview() when $default != null:
return $default(_that.authorName,_that.avatarUrl,_that.rating,_that.body,_that.timeAgoLabel,_that.helpfulCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String authorName,  String avatarUrl,  int rating,  String body,  String timeAgoLabel,  int helpfulCount)  $default,) {final _that = this;
switch (_that) {
case _SellerReview():
return $default(_that.authorName,_that.avatarUrl,_that.rating,_that.body,_that.timeAgoLabel,_that.helpfulCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String authorName,  String avatarUrl,  int rating,  String body,  String timeAgoLabel,  int helpfulCount)?  $default,) {final _that = this;
switch (_that) {
case _SellerReview() when $default != null:
return $default(_that.authorName,_that.avatarUrl,_that.rating,_that.body,_that.timeAgoLabel,_that.helpfulCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SellerReview implements SellerReview {
  const _SellerReview({required this.authorName, required this.avatarUrl, required this.rating, required this.body, required this.timeAgoLabel, required this.helpfulCount});
  factory _SellerReview.fromJson(Map<String, dynamic> json) => _$SellerReviewFromJson(json);

@override final  String authorName;
@override final  String avatarUrl;
@override final  int rating;
@override final  String body;
@override final  String timeAgoLabel;
@override final  int helpfulCount;

/// Create a copy of SellerReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerReviewCopyWith<_SellerReview> get copyWith => __$SellerReviewCopyWithImpl<_SellerReview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SellerReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerReview&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.body, body) || other.body == body)&&(identical(other.timeAgoLabel, timeAgoLabel) || other.timeAgoLabel == timeAgoLabel)&&(identical(other.helpfulCount, helpfulCount) || other.helpfulCount == helpfulCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorName,avatarUrl,rating,body,timeAgoLabel,helpfulCount);

@override
String toString() {
  return 'SellerReview(authorName: $authorName, avatarUrl: $avatarUrl, rating: $rating, body: $body, timeAgoLabel: $timeAgoLabel, helpfulCount: $helpfulCount)';
}


}

/// @nodoc
abstract mixin class _$SellerReviewCopyWith<$Res> implements $SellerReviewCopyWith<$Res> {
  factory _$SellerReviewCopyWith(_SellerReview value, $Res Function(_SellerReview) _then) = __$SellerReviewCopyWithImpl;
@override @useResult
$Res call({
 String authorName, String avatarUrl, int rating, String body, String timeAgoLabel, int helpfulCount
});




}
/// @nodoc
class __$SellerReviewCopyWithImpl<$Res>
    implements _$SellerReviewCopyWith<$Res> {
  __$SellerReviewCopyWithImpl(this._self, this._then);

  final _SellerReview _self;
  final $Res Function(_SellerReview) _then;

/// Create a copy of SellerReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authorName = null,Object? avatarUrl = null,Object? rating = null,Object? body = null,Object? timeAgoLabel = null,Object? helpfulCount = null,}) {
  return _then(_SellerReview(
authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,timeAgoLabel: null == timeAgoLabel ? _self.timeAgoLabel : timeAgoLabel // ignore: cast_nullable_to_non_nullable
as String,helpfulCount: null == helpfulCount ? _self.helpfulCount : helpfulCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
