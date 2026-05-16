// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletPaymentMethod _$WalletPaymentMethodFromJson(Map<String, dynamic> json) =>
    WalletPaymentMethod(
      id: json['id'] as String,
      balance: (json['balance'] as num).toDouble(),
      $type: json['kind'] as String?,
    );

Map<String, dynamic> _$WalletPaymentMethodToJson(
  WalletPaymentMethod instance,
) => <String, dynamic>{
  'id': instance.id,
  'balance': instance.balance,
  'kind': instance.$type,
};

SavedCardPaymentMethod _$SavedCardPaymentMethodFromJson(
  Map<String, dynamic> json,
) => SavedCardPaymentMethod(
  id: json['id'] as String,
  last4: json['last4'] as String,
  expiry: json['expiry'] as String,
  brand: json['brand'] as String? ?? 'Visa',
  $type: json['kind'] as String?,
);

Map<String, dynamic> _$SavedCardPaymentMethodToJson(
  SavedCardPaymentMethod instance,
) => <String, dynamic>{
  'id': instance.id,
  'last4': instance.last4,
  'expiry': instance.expiry,
  'brand': instance.brand,
  'kind': instance.$type,
};

PayPalPaymentMethod _$PayPalPaymentMethodFromJson(Map<String, dynamic> json) =>
    PayPalPaymentMethod(
      id: json['id'] as String,
      maskedEmail: json['maskedEmail'] as String,
      $type: json['kind'] as String?,
    );

Map<String, dynamic> _$PayPalPaymentMethodToJson(
  PayPalPaymentMethod instance,
) => <String, dynamic>{
  'id': instance.id,
  'maskedEmail': instance.maskedEmail,
  'kind': instance.$type,
};

ApplePayPaymentMethod _$ApplePayPaymentMethodFromJson(
  Map<String, dynamic> json,
) => ApplePayPaymentMethod(
  id: json['id'] as String,
  $type: json['kind'] as String?,
);

Map<String, dynamic> _$ApplePayPaymentMethodToJson(
  ApplePayPaymentMethod instance,
) => <String, dynamic>{'id': instance.id, 'kind': instance.$type};

GooglePayPaymentMethod _$GooglePayPaymentMethodFromJson(
  Map<String, dynamic> json,
) => GooglePayPaymentMethod(
  id: json['id'] as String,
  $type: json['kind'] as String?,
);

Map<String, dynamic> _$GooglePayPaymentMethodToJson(
  GooglePayPaymentMethod instance,
) => <String, dynamic>{'id': instance.id, 'kind': instance.$type};
