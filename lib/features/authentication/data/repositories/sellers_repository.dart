import 'package:get/get.dart';

import 'package:incacook/core/constants/api_constants.dart';
import 'package:incacook/core/enums/food_enums.dart';
import 'package:incacook/core/models/auth/seller_account.dart';
import 'package:incacook/core/network/api_client.dart';
import 'package:incacook/features/authentication/data/models/requests/seller_business_request.dart';
import 'package:incacook/features/authentication/data/models/requests/seller_cuisines_request.dart';
import 'package:incacook/features/authentication/data/models/requests/seller_profile_request.dart';

/// Result of `POST /v1/sellers/me/subscription/sync`. `active` is the single
/// gate the subscription screen reads to unlock "Terminer".
class SellerSubscriptionSyncResult {
  const SellerSubscriptionSyncResult({
    required this.active,
    required this.status,
    required this.isPremium,
  });

  final bool active;
  final String status;
  final bool isPremium;

  factory SellerSubscriptionSyncResult.fromJson(Map<String, dynamic> json) {
    return SellerSubscriptionSyncResult(
      active: json['active'] as bool? ?? false,
      status: json['status'] as String? ?? 'NONE',
      isPremium: json['isPremium'] as bool? ?? false,
    );
  }
}

/// Repository for seller-only endpoints under `/v1/sellers/me/*`.
class SellersRepository extends GetxService {
  SellersRepository({ApiClient? api}) : _api = api ?? Get.find<ApiClient>();

  static SellersRepository get instance => Get.find();

  final ApiClient _api;

  /// `PUT /v1/sellers/me/profile` (§3.14). Setting `category` to
  /// FAIT_MAISON on the first PUT auto-flips `kycStatus` to APPROVED
  /// server-side — the wizard then skips the KYC steps for that user.
  Future<SellerAccount> setProfile(SellerProfileRequest req) async {
    final result = await _api.put<SellerAccount>(
      '${ApiConstants.apiPrefix}/sellers/me/profile',
      body: req.toJson(),
      decoder: (json) => SellerAccount.fromJson(json! as Map<String, dynamic>),
    );
    return result.data;
  }

  /// `PUT /v1/sellers/me/business` (§3.15). Upserts the business row
  /// and replaces opening hours in one transaction. Fait-maison sellers
  /// get 400 here — guard at the call site.
  Future<SellerBusinessRecord> setBusiness(SellerBusinessRequest req) async {
    final result = await _api.put<SellerBusinessRecord>(
      '${ApiConstants.apiPrefix}/sellers/me/business',
      body: req.toJson(),
      decoder: (json) =>
          SellerBusinessRecord.fromJson(json! as Map<String, dynamic>),
    );
    return result.data;
  }

  /// `PUT /v1/sellers/me/cuisines` (§3.16). Replaces both sets in a
  /// single transaction.
  Future<void> setCuisines(SellerCuisinesRequest req) async {
    await _api.put<void>(
      '${ApiConstants.apiPrefix}/sellers/me/cuisines',
      body: req.toJson(),
      decoder: (_) {},
    );
  }

  /// `POST /v1/sellers/me/subscription/sync` — reconciles the seller's
  /// RevenueCat (App Store / Google Play) subscription after a purchase or
  /// restore. The fields are hints; the backend verifies against RevenueCat
  /// when configured and the webhook reconciles authoritatively. Never sends
  /// tokens/receipts. Returns the resulting state (`active` unlocks "Terminer").
  Future<SellerSubscriptionSyncResult> syncSubscription({
    String? entitlementId,
    String? productId,
    int? expiresAtMs,
    bool? isTrial,
    String? revenueCatCustomerId,
    SellerCategory? category,
  }) async {
    final categoryWire = category == null ? null : _categoryWire(category);
    final body = <String, dynamic>{
      'entitlementId': ?entitlementId,
      'productId': ?productId,
      'expiresAtMs': ?expiresAtMs,
      'isTrial': ?isTrial,
      'revenueCatCustomerId': ?revenueCatCustomerId,
      'category': ?categoryWire,
    };
    final result = await _api.post<SellerSubscriptionSyncResult>(
      '${ApiConstants.apiPrefix}/sellers/me/subscription/sync',
      body: body,
      decoder: (json) =>
          SellerSubscriptionSyncResult.fromJson(json! as Map<String, dynamic>),
    );
    return result.data;
  }

  /// Backend wire value for the seller category enum.
  static String _categoryWire(SellerCategory category) {
    switch (category) {
      case SellerCategory.faitMaison:
        return 'FAIT_MAISON';
      case SellerCategory.traiteur:
        return 'TRAITEUR';
      case SellerCategory.restaurant:
        return 'RESTAURANT';
    }
  }
}
