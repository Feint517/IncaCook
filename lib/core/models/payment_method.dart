import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';
part 'payment_method.g.dart';

/// Payment method attached to an order. Concrete sub-types preserve their
/// original class names (`WalletPaymentMethod`, `SavedCardPaymentMethod`,
/// etc.) so existing call sites keep compiling — the JSON layer
/// discriminates between them via a `kind` field.
@Freezed(unionKey: 'kind')
sealed class PaymentMethod with _$PaymentMethod {
  const PaymentMethod._();

  @FreezedUnionValue('wallet')
  const factory PaymentMethod.wallet({
    required String id,
    required double balance,
  }) = WalletPaymentMethod;

  @FreezedUnionValue('saved_card')
  const factory PaymentMethod.savedCard({
    required String id,
    required String last4,
    required String expiry,
    @Default('Visa') String brand,
  }) = SavedCardPaymentMethod;

  @FreezedUnionValue('paypal')
  const factory PaymentMethod.paypal({
    required String id,
    required String maskedEmail,
  }) = PayPalPaymentMethod;

  @FreezedUnionValue('apple_pay')
  const factory PaymentMethod.applePay({required String id}) =
      ApplePayPaymentMethod;

  @FreezedUnionValue('google_pay')
  const factory PaymentMethod.googlePay({required String id}) =
      GooglePayPaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}

/// Wallet-specific helpers. Pattern-match in callers if you have a base
/// [PaymentMethod] and want to access these.
extension WalletOps on WalletPaymentMethod {
  bool coversAmount(double amount) => balance >= amount;
  double shortfallFor(double amount) => amount - balance;
  double remainderAfter(double amount) => balance - amount;
}
