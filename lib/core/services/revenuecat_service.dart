import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:incacook/core/config/revenuecat_config.dart';
import 'package:incacook/core/enums/food_enums.dart';

/// Outcome of a purchase / restore, distilled to what the backend sync needs.
/// Never carries tokens or receipts.
class SubscriptionOutcome {
  const SubscriptionOutcome({
    this.cancelled = false,
    this.entitlementId,
    this.productId,
    this.expiresAtMs,
    this.isTrial = false,
  });

  /// User dismissed the store sheet — silent at the UI layer.
  final bool cancelled;

  /// `seller_premium` | `seller_standard` | null (no active seller entitlement).
  final String? entitlementId;
  final String? productId;
  final int? expiresAtMs;
  final bool isTrial;

  bool get hasActiveEntitlement => entitlementId != null;
}

/// Thrown for a real purchase/restore failure (not a user cancellation).
class RevenueCatException implements Exception {
  const RevenueCatException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Thin wrapper around RevenueCat (`purchases_flutter`) for the **seller
/// monthly subscription only**. Configured at startup with the public SDK key;
/// the seller logs in with their backend `User.id` as the RevenueCat
/// appUserID so the webhook can map events back to the seller.
class RevenueCatService extends GetxService {
  bool _configured = false;
  bool get isConfigured => _configured;

  /// Idempotent. Safe to call when no key is set (just stays inactive).
  Future<void> init() async {
    if (!RevenueCatConfig.isConfigured) {
      debugPrint('[RevenueCat] not configured (no public SDK key) — skipping');
      return;
    }
    try {
      await Purchases.configure(PurchasesConfiguration(RevenueCatConfig.apiKey));
      _configured = true;
      debugPrint('[RevenueCat] configured');
    } catch (e) {
      // Never block app startup on the billing SDK.
      debugPrint('[RevenueCat] configure failed: $e');
    }
  }

  /// Identifies the subscriber with the backend user id (= webhook app_user_id).
  Future<void> login(String appUserId) async {
    if (!_configured || appUserId.isEmpty) return;
    try {
      await Purchases.logIn(appUserId);
    } catch (e) {
      debugPrint('[RevenueCat] logIn failed: $e');
    }
  }

  /// The offering for [category], or null if RevenueCat is unconfigured /
  /// the offering isn't available. Throws nothing — callers fall back to
  /// static pricing.
  Future<Offering?> offeringForCategory(SellerCategory category) async {
    if (!_configured) return null;
    try {
      final offerings = await Purchases.getOfferings();
      return offerings.all[RevenueCatConfig.offeringIdForCategory(category)];
    } catch (e) {
      debugPrint('[RevenueCat] getOfferings failed: $e');
      return null;
    }
  }

  /// Purchases [package] and returns the resulting seller entitlement state.
  /// Maps a user cancellation to `cancelled: true` (silent); any other store
  /// error throws [RevenueCatException].
  Future<SubscriptionOutcome> purchase(Package package) async {
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      return _outcomeFrom(result.customerInfo);
    } on PlatformException catch (e) {
      if (PurchasesErrorHelper.getErrorCode(e) ==
          PurchasesErrorCode.purchaseCancelledError) {
        return const SubscriptionOutcome(cancelled: true);
      }
      // Never surface raw store/receipt internals — generic French message.
      throw const RevenueCatException('Abonnement impossible. Veuillez réessayer.');
    }
  }

  /// Restores prior purchases and returns the resulting seller entitlement
  /// state. Throws [RevenueCatException] on a store error.
  Future<SubscriptionOutcome> restore() async {
    try {
      final info = await Purchases.restorePurchases();
      return _outcomeFrom(info);
    } on PlatformException {
      throw const RevenueCatException('Restauration impossible. Veuillez réessayer.');
    }
  }

  /// Reads the active seller entitlement (premium wins) out of a [CustomerInfo].
  SubscriptionOutcome _outcomeFrom(CustomerInfo info) {
    final active = info.entitlements.active;
    final ent = active[RevenueCatConfig.entitlementPremium] ??
        active[RevenueCatConfig.entitlementStandard];
    if (ent == null) return const SubscriptionOutcome();
    return SubscriptionOutcome(
      entitlementId: ent.identifier,
      productId: ent.productIdentifier,
      expiresAtMs: DateTime.tryParse(ent.expirationDate ?? '')
          ?.toUtc()
          .millisecondsSinceEpoch,
      isTrial: ent.periodType == PeriodType.trial,
    );
  }
}
