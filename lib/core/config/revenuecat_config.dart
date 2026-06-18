import 'package:flutter/foundation.dart';

import 'package:incacook/core/enums/food_enums.dart';

/// RevenueCat configuration — used ONLY for the seller monthly subscription
/// (App Store / Google Play). Stripe stays for order payments, wallet, payouts
/// and IBAN setup.
///
/// SECURITY: the two keys below are **public** RevenueCat SDK keys (safe to
/// ship in the client). No App Store / Play / Stripe secret is here. Values are
/// read at build time from `--dart-define` (same pattern as Supabase/Mapbox):
///
///   flutter run --dart-define=REVENUECAT_ANDROID_KEY=goog_xxx \
///               --dart-define=REVENUECAT_IOS_KEY=appl_xxx

class RevenueCatConfig {
  RevenueCatConfig._();

  static const String _defaultAndroidApiKey =
      'test_TcJwhvAUrAZXfzwSbaWFyoZguIK';

  static const String _defaultIosApiKey = 'test_TcJwhvAUrZXfzwSbaWFyoZguIK';

  static const String _androidApiKeyFromEnv = String.fromEnvironment(
    'REVENUECAT_ANDROID_KEY',
  );

  static const String _iosApiKeyFromEnv = String.fromEnvironment(
    'REVENUECAT_IOS_KEY',
  );

  static String get androidApiKey {
    if (_androidApiKeyFromEnv.isNotEmpty) return _androidApiKeyFromEnv;
    return _defaultAndroidApiKey;
  }

  static String get iosApiKey {
    if (_iosApiKeyFromEnv.isNotEmpty) return _iosApiKeyFromEnv;
    return _defaultIosApiKey;
  }

  /// The public SDK key for the running platform (empty when unconfigured).
  static String get apiKey {
    if (kIsWeb) return '';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidApiKey;
      case TargetPlatform.iOS:
        return iosApiKey;
      default:
        return '';
    }
  }

  static bool get isConfigured => apiKey.isNotEmpty;

  // -------- Offerings (one per seller category) --------
  static const String offeringFaitMaison = 'bon_fait_maison';
  static const String offeringTraiteur = 'traiteur';
  static const String offeringSauveTonPanier = 'sauve_ton_panier';

  /// Maps the in-app [SellerCategory] to its RevenueCat offering id.
  /// faitMaison→bon_fait_maison, traiteur→traiteur, restaurant→sauve_ton_panier.
  static String offeringIdForCategory(SellerCategory category) {
    switch (category) {
      case SellerCategory.faitMaison:
        return offeringFaitMaison;
      case SellerCategory.traiteur:
        return offeringTraiteur;
      case SellerCategory.restaurant:
        return offeringSauveTonPanier;
    }
  }

  // -------- Package identifiers (inside every offering) --------
  static const String packageStandard = 'monthly_standard';
  static const String packagePremium = 'monthly_premium';

  // -------- Entitlement identifiers --------
  static const String entitlementStandard = 'seller_standard';
  static const String entitlementPremium = 'seller_premium';

  /// Display-only fallback monthly price (HT) when RevenueCat hasn't returned a
  /// store price yet (e.g. before store products are live, or in dev). The
  /// authoritative price always comes from the store via RevenueCat.
  static String fallbackPrice(
    SellerCategory category, {
    required bool premium,
  }) {
    switch (category) {
      case SellerCategory.traiteur:
        return premium ? '14,99 € HT / mois' : '9,99 € HT / mois';
      case SellerCategory.faitMaison:
      case SellerCategory.restaurant:
        return premium ? '9,99 € HT / mois' : '4,99 € HT / mois';
    }
  }
}
