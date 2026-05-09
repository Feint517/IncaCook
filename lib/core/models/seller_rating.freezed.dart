// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SellerRating {

 RatingCriterion get criterion; double get value; int get sampleCount;
/// Create a copy of SellerRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerRatingCopyWith<SellerRating> get copyWith => _$SellerRatingCopyWithImpl<SellerRating>(this as SellerRating, _$identity);

  /// Serializes this SellerRating to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerRating&&(identical(other.criterion, criterion) || other.criterion == criterion)&&(identical(other.value, value) || other.value == value)&&(identical(other.sampleCount, sampleCount) || other.sampleCount == sampleCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,criterion,value,sampleCount);

@override
String toString() {
  return 'SellerRating(criterion: $criterion, value: $value, sampleCount: $sampleCount)';
}


}

/// @nodoc
abstract mixin class $SellerRatingCopyWith<$Res>  {
  factory $SellerRatingCopyWith(SellerRating value, $Res Function(SellerRating) _then) = _$SellerRatingCopyWithImpl;
@useResult
$Res call({
 RatingCriterion criterion, double value, int sampleCount
});




}
/// @nodoc
class _$SellerRatingCopyWithImpl<$Res>
    implements $SellerRatingCopyWith<$Res> {
  _$SellerRatingCopyWithImpl(this._self, this._then);

  final SellerRating _self;
  final $Res Function(SellerRating) _then;

/// Create a copy of SellerRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? criterion = null,Object? value = null,Object? sampleCount = null,}) {
  return _then(_self.copyWith(
criterion: null == criterion ? _self.criterion : criterion // ignore: cast_nullable_to_non_nullable
as RatingCriterion,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,sampleCount: null == sampleCount ? _self.sampleCount : sampleCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SellerRating].
extension SellerRatingPatterns on SellerRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SellerRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellerRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SellerRating value)  $default,){
final _that = this;
switch (_that) {
case _SellerRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SellerRating value)?  $default,){
final _that = this;
switch (_that) {
case _SellerRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RatingCriterion criterion,  double value,  int sampleCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellerRating() when $default != null:
return $default(_that.criterion,_that.value,_that.sampleCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RatingCriterion criterion,  double value,  int sampleCount)  $default,) {final _that = this;
switch (_that) {
case _SellerRating():
return $default(_that.criterion,_that.value,_that.sampleCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RatingCriterion criterion,  double value,  int sampleCount)?  $default,) {final _that = this;
switch (_that) {
case _SellerRating() when $default != null:
return $default(_that.criterion,_that.value,_that.sampleCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SellerRating extends SellerRating {
  const _SellerRating({required this.criterion, required this.value, required this.sampleCount}): super._();
  factory _SellerRating.fromJson(Map<String, dynamic> json) => _$SellerRatingFromJson(json);

@override final  RatingCriterion criterion;
@override final  double value;
@override final  int sampleCount;

/// Create a copy of SellerRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerRatingCopyWith<_SellerRating> get copyWith => __$SellerRatingCopyWithImpl<_SellerRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SellerRatingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerRating&&(identical(other.criterion, criterion) || other.criterion == criterion)&&(identical(other.value, value) || other.value == value)&&(identical(other.sampleCount, sampleCount) || other.sampleCount == sampleCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,criterion,value,sampleCount);

@override
String toString() {
  return 'SellerRating(criterion: $criterion, value: $value, sampleCount: $sampleCount)';
}


}

/// @nodoc
abstract mixin class _$SellerRatingCopyWith<$Res> implements $SellerRatingCopyWith<$Res> {
  factory _$SellerRatingCopyWith(_SellerRating value, $Res Function(_SellerRating) _then) = __$SellerRatingCopyWithImpl;
@override @useResult
$Res call({
 RatingCriterion criterion, double value, int sampleCount
});




}
/// @nodoc
class __$SellerRatingCopyWithImpl<$Res>
    implements _$SellerRatingCopyWith<$Res> {
  __$SellerRatingCopyWithImpl(this._self, this._then);

  final _SellerRating _self;
  final $Res Function(_SellerRating) _then;

/// Create a copy of SellerRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? criterion = null,Object? value = null,Object? sampleCount = null,}) {
  return _then(_SellerRating(
criterion: null == criterion ? _self.criterion : criterion // ignore: cast_nullable_to_non_nullable
as RatingCriterion,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,sampleCount: null == sampleCount ? _self.sampleCount : sampleCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
