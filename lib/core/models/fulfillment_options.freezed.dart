// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fulfillment_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FulfillmentOptions {

 bool get deliveryAvailable; int get deliveryMinMinutes; int get deliveryMaxMinutes; double get deliveryFee; bool get pickupAvailable; String get pickupNeighborhood; bool get userHasAddress;
/// Create a copy of FulfillmentOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FulfillmentOptionsCopyWith<FulfillmentOptions> get copyWith => _$FulfillmentOptionsCopyWithImpl<FulfillmentOptions>(this as FulfillmentOptions, _$identity);

  /// Serializes this FulfillmentOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FulfillmentOptions&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.deliveryMinMinutes, deliveryMinMinutes) || other.deliveryMinMinutes == deliveryMinMinutes)&&(identical(other.deliveryMaxMinutes, deliveryMaxMinutes) || other.deliveryMaxMinutes == deliveryMaxMinutes)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.pickupAvailable, pickupAvailable) || other.pickupAvailable == pickupAvailable)&&(identical(other.pickupNeighborhood, pickupNeighborhood) || other.pickupNeighborhood == pickupNeighborhood)&&(identical(other.userHasAddress, userHasAddress) || other.userHasAddress == userHasAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deliveryAvailable,deliveryMinMinutes,deliveryMaxMinutes,deliveryFee,pickupAvailable,pickupNeighborhood,userHasAddress);

@override
String toString() {
  return 'FulfillmentOptions(deliveryAvailable: $deliveryAvailable, deliveryMinMinutes: $deliveryMinMinutes, deliveryMaxMinutes: $deliveryMaxMinutes, deliveryFee: $deliveryFee, pickupAvailable: $pickupAvailable, pickupNeighborhood: $pickupNeighborhood, userHasAddress: $userHasAddress)';
}


}

/// @nodoc
abstract mixin class $FulfillmentOptionsCopyWith<$Res>  {
  factory $FulfillmentOptionsCopyWith(FulfillmentOptions value, $Res Function(FulfillmentOptions) _then) = _$FulfillmentOptionsCopyWithImpl;
@useResult
$Res call({
 bool deliveryAvailable, int deliveryMinMinutes, int deliveryMaxMinutes, double deliveryFee, bool pickupAvailable, String pickupNeighborhood, bool userHasAddress
});




}
/// @nodoc
class _$FulfillmentOptionsCopyWithImpl<$Res>
    implements $FulfillmentOptionsCopyWith<$Res> {
  _$FulfillmentOptionsCopyWithImpl(this._self, this._then);

  final FulfillmentOptions _self;
  final $Res Function(FulfillmentOptions) _then;

/// Create a copy of FulfillmentOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deliveryAvailable = null,Object? deliveryMinMinutes = null,Object? deliveryMaxMinutes = null,Object? deliveryFee = null,Object? pickupAvailable = null,Object? pickupNeighborhood = null,Object? userHasAddress = null,}) {
  return _then(_self.copyWith(
deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,deliveryMinMinutes: null == deliveryMinMinutes ? _self.deliveryMinMinutes : deliveryMinMinutes // ignore: cast_nullable_to_non_nullable
as int,deliveryMaxMinutes: null == deliveryMaxMinutes ? _self.deliveryMaxMinutes : deliveryMaxMinutes // ignore: cast_nullable_to_non_nullable
as int,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,pickupAvailable: null == pickupAvailable ? _self.pickupAvailable : pickupAvailable // ignore: cast_nullable_to_non_nullable
as bool,pickupNeighborhood: null == pickupNeighborhood ? _self.pickupNeighborhood : pickupNeighborhood // ignore: cast_nullable_to_non_nullable
as String,userHasAddress: null == userHasAddress ? _self.userHasAddress : userHasAddress // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FulfillmentOptions].
extension FulfillmentOptionsPatterns on FulfillmentOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FulfillmentOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FulfillmentOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FulfillmentOptions value)  $default,){
final _that = this;
switch (_that) {
case _FulfillmentOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FulfillmentOptions value)?  $default,){
final _that = this;
switch (_that) {
case _FulfillmentOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool deliveryAvailable,  int deliveryMinMinutes,  int deliveryMaxMinutes,  double deliveryFee,  bool pickupAvailable,  String pickupNeighborhood,  bool userHasAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FulfillmentOptions() when $default != null:
return $default(_that.deliveryAvailable,_that.deliveryMinMinutes,_that.deliveryMaxMinutes,_that.deliveryFee,_that.pickupAvailable,_that.pickupNeighborhood,_that.userHasAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool deliveryAvailable,  int deliveryMinMinutes,  int deliveryMaxMinutes,  double deliveryFee,  bool pickupAvailable,  String pickupNeighborhood,  bool userHasAddress)  $default,) {final _that = this;
switch (_that) {
case _FulfillmentOptions():
return $default(_that.deliveryAvailable,_that.deliveryMinMinutes,_that.deliveryMaxMinutes,_that.deliveryFee,_that.pickupAvailable,_that.pickupNeighborhood,_that.userHasAddress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool deliveryAvailable,  int deliveryMinMinutes,  int deliveryMaxMinutes,  double deliveryFee,  bool pickupAvailable,  String pickupNeighborhood,  bool userHasAddress)?  $default,) {final _that = this;
switch (_that) {
case _FulfillmentOptions() when $default != null:
return $default(_that.deliveryAvailable,_that.deliveryMinMinutes,_that.deliveryMaxMinutes,_that.deliveryFee,_that.pickupAvailable,_that.pickupNeighborhood,_that.userHasAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FulfillmentOptions extends FulfillmentOptions {
  const _FulfillmentOptions({required this.deliveryAvailable, required this.deliveryMinMinutes, required this.deliveryMaxMinutes, required this.deliveryFee, required this.pickupAvailable, required this.pickupNeighborhood, this.userHasAddress = true}): super._();
  factory _FulfillmentOptions.fromJson(Map<String, dynamic> json) => _$FulfillmentOptionsFromJson(json);

@override final  bool deliveryAvailable;
@override final  int deliveryMinMinutes;
@override final  int deliveryMaxMinutes;
@override final  double deliveryFee;
@override final  bool pickupAvailable;
@override final  String pickupNeighborhood;
@override@JsonKey() final  bool userHasAddress;

/// Create a copy of FulfillmentOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FulfillmentOptionsCopyWith<_FulfillmentOptions> get copyWith => __$FulfillmentOptionsCopyWithImpl<_FulfillmentOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FulfillmentOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FulfillmentOptions&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.deliveryMinMinutes, deliveryMinMinutes) || other.deliveryMinMinutes == deliveryMinMinutes)&&(identical(other.deliveryMaxMinutes, deliveryMaxMinutes) || other.deliveryMaxMinutes == deliveryMaxMinutes)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.pickupAvailable, pickupAvailable) || other.pickupAvailable == pickupAvailable)&&(identical(other.pickupNeighborhood, pickupNeighborhood) || other.pickupNeighborhood == pickupNeighborhood)&&(identical(other.userHasAddress, userHasAddress) || other.userHasAddress == userHasAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deliveryAvailable,deliveryMinMinutes,deliveryMaxMinutes,deliveryFee,pickupAvailable,pickupNeighborhood,userHasAddress);

@override
String toString() {
  return 'FulfillmentOptions(deliveryAvailable: $deliveryAvailable, deliveryMinMinutes: $deliveryMinMinutes, deliveryMaxMinutes: $deliveryMaxMinutes, deliveryFee: $deliveryFee, pickupAvailable: $pickupAvailable, pickupNeighborhood: $pickupNeighborhood, userHasAddress: $userHasAddress)';
}


}

/// @nodoc
abstract mixin class _$FulfillmentOptionsCopyWith<$Res> implements $FulfillmentOptionsCopyWith<$Res> {
  factory _$FulfillmentOptionsCopyWith(_FulfillmentOptions value, $Res Function(_FulfillmentOptions) _then) = __$FulfillmentOptionsCopyWithImpl;
@override @useResult
$Res call({
 bool deliveryAvailable, int deliveryMinMinutes, int deliveryMaxMinutes, double deliveryFee, bool pickupAvailable, String pickupNeighborhood, bool userHasAddress
});




}
/// @nodoc
class __$FulfillmentOptionsCopyWithImpl<$Res>
    implements _$FulfillmentOptionsCopyWith<$Res> {
  __$FulfillmentOptionsCopyWithImpl(this._self, this._then);

  final _FulfillmentOptions _self;
  final $Res Function(_FulfillmentOptions) _then;

/// Create a copy of FulfillmentOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deliveryAvailable = null,Object? deliveryMinMinutes = null,Object? deliveryMaxMinutes = null,Object? deliveryFee = null,Object? pickupAvailable = null,Object? pickupNeighborhood = null,Object? userHasAddress = null,}) {
  return _then(_FulfillmentOptions(
deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,deliveryMinMinutes: null == deliveryMinMinutes ? _self.deliveryMinMinutes : deliveryMinMinutes // ignore: cast_nullable_to_non_nullable
as int,deliveryMaxMinutes: null == deliveryMaxMinutes ? _self.deliveryMaxMinutes : deliveryMaxMinutes // ignore: cast_nullable_to_non_nullable
as int,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,pickupAvailable: null == pickupAvailable ? _self.pickupAvailable : pickupAvailable // ignore: cast_nullable_to_non_nullable
as bool,pickupNeighborhood: null == pickupNeighborhood ? _self.pickupNeighborhood : pickupNeighborhood // ignore: cast_nullable_to_non_nullable
as String,userHasAddress: null == userHasAddress ? _self.userHasAddress : userHasAddress // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FulfillmentSelection {

 FulfillmentChoice get choice; double get fee;
/// Create a copy of FulfillmentSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FulfillmentSelectionCopyWith<FulfillmentSelection> get copyWith => _$FulfillmentSelectionCopyWithImpl<FulfillmentSelection>(this as FulfillmentSelection, _$identity);

  /// Serializes this FulfillmentSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FulfillmentSelection&&(identical(other.choice, choice) || other.choice == choice)&&(identical(other.fee, fee) || other.fee == fee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,choice,fee);

@override
String toString() {
  return 'FulfillmentSelection(choice: $choice, fee: $fee)';
}


}

/// @nodoc
abstract mixin class $FulfillmentSelectionCopyWith<$Res>  {
  factory $FulfillmentSelectionCopyWith(FulfillmentSelection value, $Res Function(FulfillmentSelection) _then) = _$FulfillmentSelectionCopyWithImpl;
@useResult
$Res call({
 FulfillmentChoice choice, double fee
});




}
/// @nodoc
class _$FulfillmentSelectionCopyWithImpl<$Res>
    implements $FulfillmentSelectionCopyWith<$Res> {
  _$FulfillmentSelectionCopyWithImpl(this._self, this._then);

  final FulfillmentSelection _self;
  final $Res Function(FulfillmentSelection) _then;

/// Create a copy of FulfillmentSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? choice = null,Object? fee = null,}) {
  return _then(_self.copyWith(
choice: null == choice ? _self.choice : choice // ignore: cast_nullable_to_non_nullable
as FulfillmentChoice,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FulfillmentSelection].
extension FulfillmentSelectionPatterns on FulfillmentSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FulfillmentSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FulfillmentSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FulfillmentSelection value)  $default,){
final _that = this;
switch (_that) {
case _FulfillmentSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FulfillmentSelection value)?  $default,){
final _that = this;
switch (_that) {
case _FulfillmentSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FulfillmentChoice choice,  double fee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FulfillmentSelection() when $default != null:
return $default(_that.choice,_that.fee);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FulfillmentChoice choice,  double fee)  $default,) {final _that = this;
switch (_that) {
case _FulfillmentSelection():
return $default(_that.choice,_that.fee);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FulfillmentChoice choice,  double fee)?  $default,) {final _that = this;
switch (_that) {
case _FulfillmentSelection() when $default != null:
return $default(_that.choice,_that.fee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FulfillmentSelection implements FulfillmentSelection {
  const _FulfillmentSelection({required this.choice, required this.fee});
  factory _FulfillmentSelection.fromJson(Map<String, dynamic> json) => _$FulfillmentSelectionFromJson(json);

@override final  FulfillmentChoice choice;
@override final  double fee;

/// Create a copy of FulfillmentSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FulfillmentSelectionCopyWith<_FulfillmentSelection> get copyWith => __$FulfillmentSelectionCopyWithImpl<_FulfillmentSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FulfillmentSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FulfillmentSelection&&(identical(other.choice, choice) || other.choice == choice)&&(identical(other.fee, fee) || other.fee == fee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,choice,fee);

@override
String toString() {
  return 'FulfillmentSelection(choice: $choice, fee: $fee)';
}


}

/// @nodoc
abstract mixin class _$FulfillmentSelectionCopyWith<$Res> implements $FulfillmentSelectionCopyWith<$Res> {
  factory _$FulfillmentSelectionCopyWith(_FulfillmentSelection value, $Res Function(_FulfillmentSelection) _then) = __$FulfillmentSelectionCopyWithImpl;
@override @useResult
$Res call({
 FulfillmentChoice choice, double fee
});




}
/// @nodoc
class __$FulfillmentSelectionCopyWithImpl<$Res>
    implements _$FulfillmentSelectionCopyWith<$Res> {
  __$FulfillmentSelectionCopyWithImpl(this._self, this._then);

  final _FulfillmentSelection _self;
  final $Res Function(_FulfillmentSelection) _then;

/// Create a copy of FulfillmentSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? choice = null,Object? fee = null,}) {
  return _then(_FulfillmentSelection(
choice: null == choice ? _self.choice : choice // ignore: cast_nullable_to_non_nullable
as FulfillmentChoice,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
