// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderDetail {

 String get id; String get orderNumber; DateTime get placedAt; OrderStage get stage; SellerProfile get seller; List<CartItem> get items; double get subtotal; double get deliveryFee; double get serviceFee; double get total; FulfillmentSelection get fulfillment; FulfillmentOptions get fulfillmentOptions; PaymentMethod get paymentMethod; DeliveryDetails? get deliveryDetails; DelivererInfo? get deliverer; DateTime? get expectedAt; String? get note;
/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailCopyWith<OrderDetail> get copyWith => _$OrderDetailCopyWithImpl<OrderDetail>(this as OrderDetail, _$identity);

  /// Serializes this OrderDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.placedAt, placedAt) || other.placedAt == placedAt)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.seller, seller) || other.seller == seller)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.serviceFee, serviceFee) || other.serviceFee == serviceFee)&&(identical(other.total, total) || other.total == total)&&(identical(other.fulfillment, fulfillment) || other.fulfillment == fulfillment)&&(identical(other.fulfillmentOptions, fulfillmentOptions) || other.fulfillmentOptions == fulfillmentOptions)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.deliveryDetails, deliveryDetails) || other.deliveryDetails == deliveryDetails)&&(identical(other.deliverer, deliverer) || other.deliverer == deliverer)&&(identical(other.expectedAt, expectedAt) || other.expectedAt == expectedAt)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,placedAt,stage,seller,const DeepCollectionEquality().hash(items),subtotal,deliveryFee,serviceFee,total,fulfillment,fulfillmentOptions,paymentMethod,deliveryDetails,deliverer,expectedAt,note);

@override
String toString() {
  return 'OrderDetail(id: $id, orderNumber: $orderNumber, placedAt: $placedAt, stage: $stage, seller: $seller, items: $items, subtotal: $subtotal, deliveryFee: $deliveryFee, serviceFee: $serviceFee, total: $total, fulfillment: $fulfillment, fulfillmentOptions: $fulfillmentOptions, paymentMethod: $paymentMethod, deliveryDetails: $deliveryDetails, deliverer: $deliverer, expectedAt: $expectedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class $OrderDetailCopyWith<$Res>  {
  factory $OrderDetailCopyWith(OrderDetail value, $Res Function(OrderDetail) _then) = _$OrderDetailCopyWithImpl;
@useResult
$Res call({
 String id, String orderNumber, DateTime placedAt, OrderStage stage, SellerProfile seller, List<CartItem> items, double subtotal, double deliveryFee, double serviceFee, double total, FulfillmentSelection fulfillment, FulfillmentOptions fulfillmentOptions, PaymentMethod paymentMethod, DeliveryDetails? deliveryDetails, DelivererInfo? deliverer, DateTime? expectedAt, String? note
});


$SellerProfileCopyWith<$Res> get seller;$FulfillmentSelectionCopyWith<$Res> get fulfillment;$FulfillmentOptionsCopyWith<$Res> get fulfillmentOptions;$PaymentMethodCopyWith<$Res> get paymentMethod;$DeliveryDetailsCopyWith<$Res>? get deliveryDetails;$DelivererInfoCopyWith<$Res>? get deliverer;

}
/// @nodoc
class _$OrderDetailCopyWithImpl<$Res>
    implements $OrderDetailCopyWith<$Res> {
  _$OrderDetailCopyWithImpl(this._self, this._then);

  final OrderDetail _self;
  final $Res Function(OrderDetail) _then;

/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNumber = null,Object? placedAt = null,Object? stage = null,Object? seller = null,Object? items = null,Object? subtotal = null,Object? deliveryFee = null,Object? serviceFee = null,Object? total = null,Object? fulfillment = null,Object? fulfillmentOptions = null,Object? paymentMethod = null,Object? deliveryDetails = freezed,Object? deliverer = freezed,Object? expectedAt = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,placedAt: null == placedAt ? _self.placedAt : placedAt // ignore: cast_nullable_to_non_nullable
as DateTime,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as OrderStage,seller: null == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as SellerProfile,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,serviceFee: null == serviceFee ? _self.serviceFee : serviceFee // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,fulfillment: null == fulfillment ? _self.fulfillment : fulfillment // ignore: cast_nullable_to_non_nullable
as FulfillmentSelection,fulfillmentOptions: null == fulfillmentOptions ? _self.fulfillmentOptions : fulfillmentOptions // ignore: cast_nullable_to_non_nullable
as FulfillmentOptions,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,deliveryDetails: freezed == deliveryDetails ? _self.deliveryDetails : deliveryDetails // ignore: cast_nullable_to_non_nullable
as DeliveryDetails?,deliverer: freezed == deliverer ? _self.deliverer : deliverer // ignore: cast_nullable_to_non_nullable
as DelivererInfo?,expectedAt: freezed == expectedAt ? _self.expectedAt : expectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SellerProfileCopyWith<$Res> get seller {
  
  return $SellerProfileCopyWith<$Res>(_self.seller, (value) {
    return _then(_self.copyWith(seller: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FulfillmentSelectionCopyWith<$Res> get fulfillment {
  
  return $FulfillmentSelectionCopyWith<$Res>(_self.fulfillment, (value) {
    return _then(_self.copyWith(fulfillment: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FulfillmentOptionsCopyWith<$Res> get fulfillmentOptions {
  
  return $FulfillmentOptionsCopyWith<$Res>(_self.fulfillmentOptions, (value) {
    return _then(_self.copyWith(fulfillmentOptions: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<$Res> get paymentMethod {
  
  return $PaymentMethodCopyWith<$Res>(_self.paymentMethod, (value) {
    return _then(_self.copyWith(paymentMethod: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeliveryDetailsCopyWith<$Res>? get deliveryDetails {
    if (_self.deliveryDetails == null) {
    return null;
  }

  return $DeliveryDetailsCopyWith<$Res>(_self.deliveryDetails!, (value) {
    return _then(_self.copyWith(deliveryDetails: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DelivererInfoCopyWith<$Res>? get deliverer {
    if (_self.deliverer == null) {
    return null;
  }

  return $DelivererInfoCopyWith<$Res>(_self.deliverer!, (value) {
    return _then(_self.copyWith(deliverer: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderDetail].
extension OrderDetailPatterns on OrderDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderDetail value)  $default,){
final _that = this;
switch (_that) {
case _OrderDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderDetail value)?  $default,){
final _that = this;
switch (_that) {
case _OrderDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderNumber,  DateTime placedAt,  OrderStage stage,  SellerProfile seller,  List<CartItem> items,  double subtotal,  double deliveryFee,  double serviceFee,  double total,  FulfillmentSelection fulfillment,  FulfillmentOptions fulfillmentOptions,  PaymentMethod paymentMethod,  DeliveryDetails? deliveryDetails,  DelivererInfo? deliverer,  DateTime? expectedAt,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderDetail() when $default != null:
return $default(_that.id,_that.orderNumber,_that.placedAt,_that.stage,_that.seller,_that.items,_that.subtotal,_that.deliveryFee,_that.serviceFee,_that.total,_that.fulfillment,_that.fulfillmentOptions,_that.paymentMethod,_that.deliveryDetails,_that.deliverer,_that.expectedAt,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderNumber,  DateTime placedAt,  OrderStage stage,  SellerProfile seller,  List<CartItem> items,  double subtotal,  double deliveryFee,  double serviceFee,  double total,  FulfillmentSelection fulfillment,  FulfillmentOptions fulfillmentOptions,  PaymentMethod paymentMethod,  DeliveryDetails? deliveryDetails,  DelivererInfo? deliverer,  DateTime? expectedAt,  String? note)  $default,) {final _that = this;
switch (_that) {
case _OrderDetail():
return $default(_that.id,_that.orderNumber,_that.placedAt,_that.stage,_that.seller,_that.items,_that.subtotal,_that.deliveryFee,_that.serviceFee,_that.total,_that.fulfillment,_that.fulfillmentOptions,_that.paymentMethod,_that.deliveryDetails,_that.deliverer,_that.expectedAt,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderNumber,  DateTime placedAt,  OrderStage stage,  SellerProfile seller,  List<CartItem> items,  double subtotal,  double deliveryFee,  double serviceFee,  double total,  FulfillmentSelection fulfillment,  FulfillmentOptions fulfillmentOptions,  PaymentMethod paymentMethod,  DeliveryDetails? deliveryDetails,  DelivererInfo? deliverer,  DateTime? expectedAt,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _OrderDetail() when $default != null:
return $default(_that.id,_that.orderNumber,_that.placedAt,_that.stage,_that.seller,_that.items,_that.subtotal,_that.deliveryFee,_that.serviceFee,_that.total,_that.fulfillment,_that.fulfillmentOptions,_that.paymentMethod,_that.deliveryDetails,_that.deliverer,_that.expectedAt,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderDetail extends OrderDetail {
  const _OrderDetail({required this.id, required this.orderNumber, required this.placedAt, required this.stage, required this.seller, required final  List<CartItem> items, required this.subtotal, required this.deliveryFee, required this.serviceFee, required this.total, required this.fulfillment, required this.fulfillmentOptions, required this.paymentMethod, this.deliveryDetails, this.deliverer, this.expectedAt, this.note}): _items = items,super._();
  factory _OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);

@override final  String id;
@override final  String orderNumber;
@override final  DateTime placedAt;
@override final  OrderStage stage;
@override final  SellerProfile seller;
 final  List<CartItem> _items;
@override List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  double subtotal;
@override final  double deliveryFee;
@override final  double serviceFee;
@override final  double total;
@override final  FulfillmentSelection fulfillment;
@override final  FulfillmentOptions fulfillmentOptions;
@override final  PaymentMethod paymentMethod;
@override final  DeliveryDetails? deliveryDetails;
@override final  DelivererInfo? deliverer;
@override final  DateTime? expectedAt;
@override final  String? note;

/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDetailCopyWith<_OrderDetail> get copyWith => __$OrderDetailCopyWithImpl<_OrderDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNumber, orderNumber) || other.orderNumber == orderNumber)&&(identical(other.placedAt, placedAt) || other.placedAt == placedAt)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.seller, seller) || other.seller == seller)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.deliveryFee, deliveryFee) || other.deliveryFee == deliveryFee)&&(identical(other.serviceFee, serviceFee) || other.serviceFee == serviceFee)&&(identical(other.total, total) || other.total == total)&&(identical(other.fulfillment, fulfillment) || other.fulfillment == fulfillment)&&(identical(other.fulfillmentOptions, fulfillmentOptions) || other.fulfillmentOptions == fulfillmentOptions)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.deliveryDetails, deliveryDetails) || other.deliveryDetails == deliveryDetails)&&(identical(other.deliverer, deliverer) || other.deliverer == deliverer)&&(identical(other.expectedAt, expectedAt) || other.expectedAt == expectedAt)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNumber,placedAt,stage,seller,const DeepCollectionEquality().hash(_items),subtotal,deliveryFee,serviceFee,total,fulfillment,fulfillmentOptions,paymentMethod,deliveryDetails,deliverer,expectedAt,note);

@override
String toString() {
  return 'OrderDetail(id: $id, orderNumber: $orderNumber, placedAt: $placedAt, stage: $stage, seller: $seller, items: $items, subtotal: $subtotal, deliveryFee: $deliveryFee, serviceFee: $serviceFee, total: $total, fulfillment: $fulfillment, fulfillmentOptions: $fulfillmentOptions, paymentMethod: $paymentMethod, deliveryDetails: $deliveryDetails, deliverer: $deliverer, expectedAt: $expectedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class _$OrderDetailCopyWith<$Res> implements $OrderDetailCopyWith<$Res> {
  factory _$OrderDetailCopyWith(_OrderDetail value, $Res Function(_OrderDetail) _then) = __$OrderDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderNumber, DateTime placedAt, OrderStage stage, SellerProfile seller, List<CartItem> items, double subtotal, double deliveryFee, double serviceFee, double total, FulfillmentSelection fulfillment, FulfillmentOptions fulfillmentOptions, PaymentMethod paymentMethod, DeliveryDetails? deliveryDetails, DelivererInfo? deliverer, DateTime? expectedAt, String? note
});


@override $SellerProfileCopyWith<$Res> get seller;@override $FulfillmentSelectionCopyWith<$Res> get fulfillment;@override $FulfillmentOptionsCopyWith<$Res> get fulfillmentOptions;@override $PaymentMethodCopyWith<$Res> get paymentMethod;@override $DeliveryDetailsCopyWith<$Res>? get deliveryDetails;@override $DelivererInfoCopyWith<$Res>? get deliverer;

}
/// @nodoc
class __$OrderDetailCopyWithImpl<$Res>
    implements _$OrderDetailCopyWith<$Res> {
  __$OrderDetailCopyWithImpl(this._self, this._then);

  final _OrderDetail _self;
  final $Res Function(_OrderDetail) _then;

/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNumber = null,Object? placedAt = null,Object? stage = null,Object? seller = null,Object? items = null,Object? subtotal = null,Object? deliveryFee = null,Object? serviceFee = null,Object? total = null,Object? fulfillment = null,Object? fulfillmentOptions = null,Object? paymentMethod = null,Object? deliveryDetails = freezed,Object? deliverer = freezed,Object? expectedAt = freezed,Object? note = freezed,}) {
  return _then(_OrderDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNumber: null == orderNumber ? _self.orderNumber : orderNumber // ignore: cast_nullable_to_non_nullable
as String,placedAt: null == placedAt ? _self.placedAt : placedAt // ignore: cast_nullable_to_non_nullable
as DateTime,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as OrderStage,seller: null == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as SellerProfile,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,deliveryFee: null == deliveryFee ? _self.deliveryFee : deliveryFee // ignore: cast_nullable_to_non_nullable
as double,serviceFee: null == serviceFee ? _self.serviceFee : serviceFee // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,fulfillment: null == fulfillment ? _self.fulfillment : fulfillment // ignore: cast_nullable_to_non_nullable
as FulfillmentSelection,fulfillmentOptions: null == fulfillmentOptions ? _self.fulfillmentOptions : fulfillmentOptions // ignore: cast_nullable_to_non_nullable
as FulfillmentOptions,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,deliveryDetails: freezed == deliveryDetails ? _self.deliveryDetails : deliveryDetails // ignore: cast_nullable_to_non_nullable
as DeliveryDetails?,deliverer: freezed == deliverer ? _self.deliverer : deliverer // ignore: cast_nullable_to_non_nullable
as DelivererInfo?,expectedAt: freezed == expectedAt ? _self.expectedAt : expectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SellerProfileCopyWith<$Res> get seller {
  
  return $SellerProfileCopyWith<$Res>(_self.seller, (value) {
    return _then(_self.copyWith(seller: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FulfillmentSelectionCopyWith<$Res> get fulfillment {
  
  return $FulfillmentSelectionCopyWith<$Res>(_self.fulfillment, (value) {
    return _then(_self.copyWith(fulfillment: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FulfillmentOptionsCopyWith<$Res> get fulfillmentOptions {
  
  return $FulfillmentOptionsCopyWith<$Res>(_self.fulfillmentOptions, (value) {
    return _then(_self.copyWith(fulfillmentOptions: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<$Res> get paymentMethod {
  
  return $PaymentMethodCopyWith<$Res>(_self.paymentMethod, (value) {
    return _then(_self.copyWith(paymentMethod: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeliveryDetailsCopyWith<$Res>? get deliveryDetails {
    if (_self.deliveryDetails == null) {
    return null;
  }

  return $DeliveryDetailsCopyWith<$Res>(_self.deliveryDetails!, (value) {
    return _then(_self.copyWith(deliveryDetails: value));
  });
}/// Create a copy of OrderDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DelivererInfoCopyWith<$Res>? get deliverer {
    if (_self.deliverer == null) {
    return null;
  }

  return $DelivererInfoCopyWith<$Res>(_self.deliverer!, (value) {
    return _then(_self.copyWith(deliverer: value));
  });
}
}


/// @nodoc
mixin _$DelivererInfo {

 String get id; String get name; String get avatarUrl; double get rating; int get completedDeliveries; String get vehicleType; String? get licensePlate; String? get phoneNumber;
/// Create a copy of DelivererInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DelivererInfoCopyWith<DelivererInfo> get copyWith => _$DelivererInfoCopyWithImpl<DelivererInfo>(this as DelivererInfo, _$identity);

  /// Serializes this DelivererInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DelivererInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.completedDeliveries, completedDeliveries) || other.completedDeliveries == completedDeliveries)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl,rating,completedDeliveries,vehicleType,licensePlate,phoneNumber);

@override
String toString() {
  return 'DelivererInfo(id: $id, name: $name, avatarUrl: $avatarUrl, rating: $rating, completedDeliveries: $completedDeliveries, vehicleType: $vehicleType, licensePlate: $licensePlate, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $DelivererInfoCopyWith<$Res>  {
  factory $DelivererInfoCopyWith(DelivererInfo value, $Res Function(DelivererInfo) _then) = _$DelivererInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String avatarUrl, double rating, int completedDeliveries, String vehicleType, String? licensePlate, String? phoneNumber
});




}
/// @nodoc
class _$DelivererInfoCopyWithImpl<$Res>
    implements $DelivererInfoCopyWith<$Res> {
  _$DelivererInfoCopyWithImpl(this._self, this._then);

  final DelivererInfo _self;
  final $Res Function(DelivererInfo) _then;

/// Create a copy of DelivererInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatarUrl = null,Object? rating = null,Object? completedDeliveries = null,Object? vehicleType = null,Object? licensePlate = freezed,Object? phoneNumber = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,completedDeliveries: null == completedDeliveries ? _self.completedDeliveries : completedDeliveries // ignore: cast_nullable_to_non_nullable
as int,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String,licensePlate: freezed == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DelivererInfo].
extension DelivererInfoPatterns on DelivererInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DelivererInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DelivererInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DelivererInfo value)  $default,){
final _that = this;
switch (_that) {
case _DelivererInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DelivererInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DelivererInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String avatarUrl,  double rating,  int completedDeliveries,  String vehicleType,  String? licensePlate,  String? phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DelivererInfo() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.rating,_that.completedDeliveries,_that.vehicleType,_that.licensePlate,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String avatarUrl,  double rating,  int completedDeliveries,  String vehicleType,  String? licensePlate,  String? phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _DelivererInfo():
return $default(_that.id,_that.name,_that.avatarUrl,_that.rating,_that.completedDeliveries,_that.vehicleType,_that.licensePlate,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String avatarUrl,  double rating,  int completedDeliveries,  String vehicleType,  String? licensePlate,  String? phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _DelivererInfo() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.rating,_that.completedDeliveries,_that.vehicleType,_that.licensePlate,_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DelivererInfo implements DelivererInfo {
  const _DelivererInfo({required this.id, required this.name, required this.avatarUrl, required this.rating, required this.completedDeliveries, required this.vehicleType, this.licensePlate, this.phoneNumber});
  factory _DelivererInfo.fromJson(Map<String, dynamic> json) => _$DelivererInfoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String avatarUrl;
@override final  double rating;
@override final  int completedDeliveries;
@override final  String vehicleType;
@override final  String? licensePlate;
@override final  String? phoneNumber;

/// Create a copy of DelivererInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DelivererInfoCopyWith<_DelivererInfo> get copyWith => __$DelivererInfoCopyWithImpl<_DelivererInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DelivererInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DelivererInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.completedDeliveries, completedDeliveries) || other.completedDeliveries == completedDeliveries)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.licensePlate, licensePlate) || other.licensePlate == licensePlate)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl,rating,completedDeliveries,vehicleType,licensePlate,phoneNumber);

@override
String toString() {
  return 'DelivererInfo(id: $id, name: $name, avatarUrl: $avatarUrl, rating: $rating, completedDeliveries: $completedDeliveries, vehicleType: $vehicleType, licensePlate: $licensePlate, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$DelivererInfoCopyWith<$Res> implements $DelivererInfoCopyWith<$Res> {
  factory _$DelivererInfoCopyWith(_DelivererInfo value, $Res Function(_DelivererInfo) _then) = __$DelivererInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String avatarUrl, double rating, int completedDeliveries, String vehicleType, String? licensePlate, String? phoneNumber
});




}
/// @nodoc
class __$DelivererInfoCopyWithImpl<$Res>
    implements _$DelivererInfoCopyWith<$Res> {
  __$DelivererInfoCopyWithImpl(this._self, this._then);

  final _DelivererInfo _self;
  final $Res Function(_DelivererInfo) _then;

/// Create a copy of DelivererInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = null,Object? rating = null,Object? completedDeliveries = null,Object? vehicleType = null,Object? licensePlate = freezed,Object? phoneNumber = freezed,}) {
  return _then(_DelivererInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,completedDeliveries: null == completedDeliveries ? _self.completedDeliveries : completedDeliveries // ignore: cast_nullable_to_non_nullable
as int,vehicleType: null == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String,licensePlate: freezed == licensePlate ? _self.licensePlate : licensePlate // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
