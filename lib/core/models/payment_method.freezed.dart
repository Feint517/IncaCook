// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
PaymentMethod _$PaymentMethodFromJson(
  Map<String, dynamic> json
) {
        switch (json['kind']) {
                  case 'wallet':
          return WalletPaymentMethod.fromJson(
            json
          );
                case 'saved_card':
          return SavedCardPaymentMethod.fromJson(
            json
          );
                case 'paypal':
          return PayPalPaymentMethod.fromJson(
            json
          );
                case 'apple_pay':
          return ApplePayPaymentMethod.fromJson(
            json
          );
                case 'google_pay':
          return GooglePayPaymentMethod.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'kind',
  'PaymentMethod',
  'Invalid union type "${json['kind']}"!'
);
        }
      
}

/// @nodoc
mixin _$PaymentMethod {

 String get id;
/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<PaymentMethod> get copyWith => _$PaymentMethodCopyWithImpl<PaymentMethod>(this as PaymentMethod, _$identity);

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethod&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'PaymentMethod(id: $id)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodCopyWith<$Res>  {
  factory $PaymentMethodCopyWith(PaymentMethod value, $Res Function(PaymentMethod) _then) = _$PaymentMethodCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._self, this._then);

  final PaymentMethod _self;
  final $Res Function(PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethod].
extension PaymentMethodPatterns on PaymentMethod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WalletPaymentMethod value)?  wallet,TResult Function( SavedCardPaymentMethod value)?  savedCard,TResult Function( PayPalPaymentMethod value)?  paypal,TResult Function( ApplePayPaymentMethod value)?  applePay,TResult Function( GooglePayPaymentMethod value)?  googlePay,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WalletPaymentMethod() when wallet != null:
return wallet(_that);case SavedCardPaymentMethod() when savedCard != null:
return savedCard(_that);case PayPalPaymentMethod() when paypal != null:
return paypal(_that);case ApplePayPaymentMethod() when applePay != null:
return applePay(_that);case GooglePayPaymentMethod() when googlePay != null:
return googlePay(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WalletPaymentMethod value)  wallet,required TResult Function( SavedCardPaymentMethod value)  savedCard,required TResult Function( PayPalPaymentMethod value)  paypal,required TResult Function( ApplePayPaymentMethod value)  applePay,required TResult Function( GooglePayPaymentMethod value)  googlePay,}){
final _that = this;
switch (_that) {
case WalletPaymentMethod():
return wallet(_that);case SavedCardPaymentMethod():
return savedCard(_that);case PayPalPaymentMethod():
return paypal(_that);case ApplePayPaymentMethod():
return applePay(_that);case GooglePayPaymentMethod():
return googlePay(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WalletPaymentMethod value)?  wallet,TResult? Function( SavedCardPaymentMethod value)?  savedCard,TResult? Function( PayPalPaymentMethod value)?  paypal,TResult? Function( ApplePayPaymentMethod value)?  applePay,TResult? Function( GooglePayPaymentMethod value)?  googlePay,}){
final _that = this;
switch (_that) {
case WalletPaymentMethod() when wallet != null:
return wallet(_that);case SavedCardPaymentMethod() when savedCard != null:
return savedCard(_that);case PayPalPaymentMethod() when paypal != null:
return paypal(_that);case ApplePayPaymentMethod() when applePay != null:
return applePay(_that);case GooglePayPaymentMethod() when googlePay != null:
return googlePay(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  double balance)?  wallet,TResult Function( String id,  String last4,  String expiry,  String brand)?  savedCard,TResult Function( String id,  String maskedEmail)?  paypal,TResult Function( String id)?  applePay,TResult Function( String id)?  googlePay,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WalletPaymentMethod() when wallet != null:
return wallet(_that.id,_that.balance);case SavedCardPaymentMethod() when savedCard != null:
return savedCard(_that.id,_that.last4,_that.expiry,_that.brand);case PayPalPaymentMethod() when paypal != null:
return paypal(_that.id,_that.maskedEmail);case ApplePayPaymentMethod() when applePay != null:
return applePay(_that.id);case GooglePayPaymentMethod() when googlePay != null:
return googlePay(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  double balance)  wallet,required TResult Function( String id,  String last4,  String expiry,  String brand)  savedCard,required TResult Function( String id,  String maskedEmail)  paypal,required TResult Function( String id)  applePay,required TResult Function( String id)  googlePay,}) {final _that = this;
switch (_that) {
case WalletPaymentMethod():
return wallet(_that.id,_that.balance);case SavedCardPaymentMethod():
return savedCard(_that.id,_that.last4,_that.expiry,_that.brand);case PayPalPaymentMethod():
return paypal(_that.id,_that.maskedEmail);case ApplePayPaymentMethod():
return applePay(_that.id);case GooglePayPaymentMethod():
return googlePay(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  double balance)?  wallet,TResult? Function( String id,  String last4,  String expiry,  String brand)?  savedCard,TResult? Function( String id,  String maskedEmail)?  paypal,TResult? Function( String id)?  applePay,TResult? Function( String id)?  googlePay,}) {final _that = this;
switch (_that) {
case WalletPaymentMethod() when wallet != null:
return wallet(_that.id,_that.balance);case SavedCardPaymentMethod() when savedCard != null:
return savedCard(_that.id,_that.last4,_that.expiry,_that.brand);case PayPalPaymentMethod() when paypal != null:
return paypal(_that.id,_that.maskedEmail);case ApplePayPaymentMethod() when applePay != null:
return applePay(_that.id);case GooglePayPaymentMethod() when googlePay != null:
return googlePay(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class WalletPaymentMethod extends PaymentMethod {
  const WalletPaymentMethod({required this.id, required this.balance, final  String? $type}): $type = $type ?? 'wallet',super._();
  factory WalletPaymentMethod.fromJson(Map<String, dynamic> json) => _$WalletPaymentMethodFromJson(json);

@override final  String id;
 final  double balance;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletPaymentMethodCopyWith<WalletPaymentMethod> get copyWith => _$WalletPaymentMethodCopyWithImpl<WalletPaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletPaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletPaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,balance);

@override
String toString() {
  return 'PaymentMethod.wallet(id: $id, balance: $balance)';
}


}

/// @nodoc
abstract mixin class $WalletPaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory $WalletPaymentMethodCopyWith(WalletPaymentMethod value, $Res Function(WalletPaymentMethod) _then) = _$WalletPaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 String id, double balance
});




}
/// @nodoc
class _$WalletPaymentMethodCopyWithImpl<$Res>
    implements $WalletPaymentMethodCopyWith<$Res> {
  _$WalletPaymentMethodCopyWithImpl(this._self, this._then);

  final WalletPaymentMethod _self;
  final $Res Function(WalletPaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? balance = null,}) {
  return _then(WalletPaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SavedCardPaymentMethod extends PaymentMethod {
  const SavedCardPaymentMethod({required this.id, required this.last4, required this.expiry, this.brand = 'Visa', final  String? $type}): $type = $type ?? 'saved_card',super._();
  factory SavedCardPaymentMethod.fromJson(Map<String, dynamic> json) => _$SavedCardPaymentMethodFromJson(json);

@override final  String id;
 final  String last4;
 final  String expiry;
@JsonKey() final  String brand;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedCardPaymentMethodCopyWith<SavedCardPaymentMethod> get copyWith => _$SavedCardPaymentMethodCopyWithImpl<SavedCardPaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedCardPaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedCardPaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.last4, last4) || other.last4 == last4)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.brand, brand) || other.brand == brand));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,last4,expiry,brand);

@override
String toString() {
  return 'PaymentMethod.savedCard(id: $id, last4: $last4, expiry: $expiry, brand: $brand)';
}


}

/// @nodoc
abstract mixin class $SavedCardPaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory $SavedCardPaymentMethodCopyWith(SavedCardPaymentMethod value, $Res Function(SavedCardPaymentMethod) _then) = _$SavedCardPaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 String id, String last4, String expiry, String brand
});




}
/// @nodoc
class _$SavedCardPaymentMethodCopyWithImpl<$Res>
    implements $SavedCardPaymentMethodCopyWith<$Res> {
  _$SavedCardPaymentMethodCopyWithImpl(this._self, this._then);

  final SavedCardPaymentMethod _self;
  final $Res Function(SavedCardPaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? last4 = null,Object? expiry = null,Object? brand = null,}) {
  return _then(SavedCardPaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,last4: null == last4 ? _self.last4 : last4 // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PayPalPaymentMethod extends PaymentMethod {
  const PayPalPaymentMethod({required this.id, required this.maskedEmail, final  String? $type}): $type = $type ?? 'paypal',super._();
  factory PayPalPaymentMethod.fromJson(Map<String, dynamic> json) => _$PayPalPaymentMethodFromJson(json);

@override final  String id;
 final  String maskedEmail;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayPalPaymentMethodCopyWith<PayPalPaymentMethod> get copyWith => _$PayPalPaymentMethodCopyWithImpl<PayPalPaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayPalPaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayPalPaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.maskedEmail, maskedEmail) || other.maskedEmail == maskedEmail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,maskedEmail);

@override
String toString() {
  return 'PaymentMethod.paypal(id: $id, maskedEmail: $maskedEmail)';
}


}

/// @nodoc
abstract mixin class $PayPalPaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory $PayPalPaymentMethodCopyWith(PayPalPaymentMethod value, $Res Function(PayPalPaymentMethod) _then) = _$PayPalPaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 String id, String maskedEmail
});




}
/// @nodoc
class _$PayPalPaymentMethodCopyWithImpl<$Res>
    implements $PayPalPaymentMethodCopyWith<$Res> {
  _$PayPalPaymentMethodCopyWithImpl(this._self, this._then);

  final PayPalPaymentMethod _self;
  final $Res Function(PayPalPaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? maskedEmail = null,}) {
  return _then(PayPalPaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,maskedEmail: null == maskedEmail ? _self.maskedEmail : maskedEmail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ApplePayPaymentMethod extends PaymentMethod {
  const ApplePayPaymentMethod({required this.id, final  String? $type}): $type = $type ?? 'apple_pay',super._();
  factory ApplePayPaymentMethod.fromJson(Map<String, dynamic> json) => _$ApplePayPaymentMethodFromJson(json);

@override final  String id;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplePayPaymentMethodCopyWith<ApplePayPaymentMethod> get copyWith => _$ApplePayPaymentMethodCopyWithImpl<ApplePayPaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplePayPaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplePayPaymentMethod&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'PaymentMethod.applePay(id: $id)';
}


}

/// @nodoc
abstract mixin class $ApplePayPaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory $ApplePayPaymentMethodCopyWith(ApplePayPaymentMethod value, $Res Function(ApplePayPaymentMethod) _then) = _$ApplePayPaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class _$ApplePayPaymentMethodCopyWithImpl<$Res>
    implements $ApplePayPaymentMethodCopyWith<$Res> {
  _$ApplePayPaymentMethodCopyWithImpl(this._self, this._then);

  final ApplePayPaymentMethod _self;
  final $Res Function(ApplePayPaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ApplePayPaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class GooglePayPaymentMethod extends PaymentMethod {
  const GooglePayPaymentMethod({required this.id, final  String? $type}): $type = $type ?? 'google_pay',super._();
  factory GooglePayPaymentMethod.fromJson(Map<String, dynamic> json) => _$GooglePayPaymentMethodFromJson(json);

@override final  String id;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooglePayPaymentMethodCopyWith<GooglePayPaymentMethod> get copyWith => _$GooglePayPaymentMethodCopyWithImpl<GooglePayPaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GooglePayPaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooglePayPaymentMethod&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'PaymentMethod.googlePay(id: $id)';
}


}

/// @nodoc
abstract mixin class $GooglePayPaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory $GooglePayPaymentMethodCopyWith(GooglePayPaymentMethod value, $Res Function(GooglePayPaymentMethod) _then) = _$GooglePayPaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class _$GooglePayPaymentMethodCopyWithImpl<$Res>
    implements $GooglePayPaymentMethodCopyWith<$Res> {
  _$GooglePayPaymentMethodCopyWithImpl(this._self, this._then);

  final GooglePayPaymentMethod _self;
  final $Res Function(GooglePayPaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(GooglePayPaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
