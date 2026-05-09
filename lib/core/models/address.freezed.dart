// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Address {

 String get fullAddress; String get city; String get postalCode; MapPoint? get coordinate; String? get id; SavedAddressType? get type; String? get customLabel; String? get apartment; String? get floor; String? get digicode; String? get deliveryNotes;@JsonKey(includeFromJson: false, includeToJson: false) bool get inRange;
/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressCopyWith<Address> get copyWith => _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Address&&(identical(other.fullAddress, fullAddress) || other.fullAddress == fullAddress)&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.coordinate, coordinate) || other.coordinate == coordinate)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.customLabel, customLabel) || other.customLabel == customLabel)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.digicode, digicode) || other.digicode == digicode)&&(identical(other.deliveryNotes, deliveryNotes) || other.deliveryNotes == deliveryNotes)&&(identical(other.inRange, inRange) || other.inRange == inRange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullAddress,city,postalCode,coordinate,id,type,customLabel,apartment,floor,digicode,deliveryNotes,inRange);

@override
String toString() {
  return 'Address(fullAddress: $fullAddress, city: $city, postalCode: $postalCode, coordinate: $coordinate, id: $id, type: $type, customLabel: $customLabel, apartment: $apartment, floor: $floor, digicode: $digicode, deliveryNotes: $deliveryNotes, inRange: $inRange)';
}


}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res>  {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) = _$AddressCopyWithImpl;
@useResult
$Res call({
 String fullAddress, String city, String postalCode, MapPoint? coordinate, String? id, SavedAddressType? type, String? customLabel, String? apartment, String? floor, String? digicode, String? deliveryNotes,@JsonKey(includeFromJson: false, includeToJson: false) bool inRange
});


$MapPointCopyWith<$Res>? get coordinate;

}
/// @nodoc
class _$AddressCopyWithImpl<$Res>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullAddress = null,Object? city = null,Object? postalCode = null,Object? coordinate = freezed,Object? id = freezed,Object? type = freezed,Object? customLabel = freezed,Object? apartment = freezed,Object? floor = freezed,Object? digicode = freezed,Object? deliveryNotes = freezed,Object? inRange = null,}) {
  return _then(_self.copyWith(
fullAddress: null == fullAddress ? _self.fullAddress : fullAddress // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,coordinate: freezed == coordinate ? _self.coordinate : coordinate // ignore: cast_nullable_to_non_nullable
as MapPoint?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SavedAddressType?,customLabel: freezed == customLabel ? _self.customLabel : customLabel // ignore: cast_nullable_to_non_nullable
as String?,apartment: freezed == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String?,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String?,digicode: freezed == digicode ? _self.digicode : digicode // ignore: cast_nullable_to_non_nullable
as String?,deliveryNotes: freezed == deliveryNotes ? _self.deliveryNotes : deliveryNotes // ignore: cast_nullable_to_non_nullable
as String?,inRange: null == inRange ? _self.inRange : inRange // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapPointCopyWith<$Res>? get coordinate {
    if (_self.coordinate == null) {
    return null;
  }

  return $MapPointCopyWith<$Res>(_self.coordinate!, (value) {
    return _then(_self.copyWith(coordinate: value));
  });
}
}


/// Adds pattern-matching-related methods to [Address].
extension AddressPatterns on Address {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Address value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Address() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Address value)  $default,){
final _that = this;
switch (_that) {
case _Address():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Address value)?  $default,){
final _that = this;
switch (_that) {
case _Address() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullAddress,  String city,  String postalCode,  MapPoint? coordinate,  String? id,  SavedAddressType? type,  String? customLabel,  String? apartment,  String? floor,  String? digicode,  String? deliveryNotes, @JsonKey(includeFromJson: false, includeToJson: false)  bool inRange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that.fullAddress,_that.city,_that.postalCode,_that.coordinate,_that.id,_that.type,_that.customLabel,_that.apartment,_that.floor,_that.digicode,_that.deliveryNotes,_that.inRange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullAddress,  String city,  String postalCode,  MapPoint? coordinate,  String? id,  SavedAddressType? type,  String? customLabel,  String? apartment,  String? floor,  String? digicode,  String? deliveryNotes, @JsonKey(includeFromJson: false, includeToJson: false)  bool inRange)  $default,) {final _that = this;
switch (_that) {
case _Address():
return $default(_that.fullAddress,_that.city,_that.postalCode,_that.coordinate,_that.id,_that.type,_that.customLabel,_that.apartment,_that.floor,_that.digicode,_that.deliveryNotes,_that.inRange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullAddress,  String city,  String postalCode,  MapPoint? coordinate,  String? id,  SavedAddressType? type,  String? customLabel,  String? apartment,  String? floor,  String? digicode,  String? deliveryNotes, @JsonKey(includeFromJson: false, includeToJson: false)  bool inRange)?  $default,) {final _that = this;
switch (_that) {
case _Address() when $default != null:
return $default(_that.fullAddress,_that.city,_that.postalCode,_that.coordinate,_that.id,_that.type,_that.customLabel,_that.apartment,_that.floor,_that.digicode,_that.deliveryNotes,_that.inRange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Address extends Address {
  const _Address({required this.fullAddress, required this.city, required this.postalCode, this.coordinate, this.id, this.type, this.customLabel, this.apartment, this.floor, this.digicode, this.deliveryNotes, @JsonKey(includeFromJson: false, includeToJson: false) this.inRange = true}): super._();
  factory _Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

@override final  String fullAddress;
@override final  String city;
@override final  String postalCode;
@override final  MapPoint? coordinate;
@override final  String? id;
@override final  SavedAddressType? type;
@override final  String? customLabel;
@override final  String? apartment;
@override final  String? floor;
@override final  String? digicode;
@override final  String? deliveryNotes;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  bool inRange;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressCopyWith<_Address> get copyWith => __$AddressCopyWithImpl<_Address>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Address&&(identical(other.fullAddress, fullAddress) || other.fullAddress == fullAddress)&&(identical(other.city, city) || other.city == city)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.coordinate, coordinate) || other.coordinate == coordinate)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.customLabel, customLabel) || other.customLabel == customLabel)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.digicode, digicode) || other.digicode == digicode)&&(identical(other.deliveryNotes, deliveryNotes) || other.deliveryNotes == deliveryNotes)&&(identical(other.inRange, inRange) || other.inRange == inRange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullAddress,city,postalCode,coordinate,id,type,customLabel,apartment,floor,digicode,deliveryNotes,inRange);

@override
String toString() {
  return 'Address(fullAddress: $fullAddress, city: $city, postalCode: $postalCode, coordinate: $coordinate, id: $id, type: $type, customLabel: $customLabel, apartment: $apartment, floor: $floor, digicode: $digicode, deliveryNotes: $deliveryNotes, inRange: $inRange)';
}


}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) = __$AddressCopyWithImpl;
@override @useResult
$Res call({
 String fullAddress, String city, String postalCode, MapPoint? coordinate, String? id, SavedAddressType? type, String? customLabel, String? apartment, String? floor, String? digicode, String? deliveryNotes,@JsonKey(includeFromJson: false, includeToJson: false) bool inRange
});


@override $MapPointCopyWith<$Res>? get coordinate;

}
/// @nodoc
class __$AddressCopyWithImpl<$Res>
    implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullAddress = null,Object? city = null,Object? postalCode = null,Object? coordinate = freezed,Object? id = freezed,Object? type = freezed,Object? customLabel = freezed,Object? apartment = freezed,Object? floor = freezed,Object? digicode = freezed,Object? deliveryNotes = freezed,Object? inRange = null,}) {
  return _then(_Address(
fullAddress: null == fullAddress ? _self.fullAddress : fullAddress // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,coordinate: freezed == coordinate ? _self.coordinate : coordinate // ignore: cast_nullable_to_non_nullable
as MapPoint?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SavedAddressType?,customLabel: freezed == customLabel ? _self.customLabel : customLabel // ignore: cast_nullable_to_non_nullable
as String?,apartment: freezed == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String?,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as String?,digicode: freezed == digicode ? _self.digicode : digicode // ignore: cast_nullable_to_non_nullable
as String?,deliveryNotes: freezed == deliveryNotes ? _self.deliveryNotes : deliveryNotes // ignore: cast_nullable_to_non_nullable
as String?,inRange: null == inRange ? _self.inRange : inRange // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Address
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapPointCopyWith<$Res>? get coordinate {
    if (_self.coordinate == null) {
    return null;
  }

  return $MapPointCopyWith<$Res>(_self.coordinate!, (value) {
    return _then(_self.copyWith(coordinate: value));
  });
}
}

// dart format on
