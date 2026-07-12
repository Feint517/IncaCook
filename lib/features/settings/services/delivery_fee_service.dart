import 'package:get/get.dart';

import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/utils/log.dart';
import 'package:incacook/features/settings/data/settings_repository.dart';

/// Caches the live, admin-configured flat delivery fee so the pre-checkout
/// display (cart → fulfillment sheet) reflects the backend value instead of a
/// hardcoded constant.
///
/// Fetched once at app start (via [onInit]) and held in memory. While loading
/// or on any error the getter returns [AppTexts.cartShippingFee] as a safe
/// fallback, so the UI never blocks on the network and always shows a value.
/// The authoritative order total is still computed server-side; this only
/// aligns the buyer's pre-checkout preview.
class DeliveryFeeService extends GetxService {
  DeliveryFeeService({SettingsRepository? repository})
    : _repository = repository ?? Get.find<SettingsRepository>();

  static DeliveryFeeService get instance => Get.find();

  final SettingsRepository _repository;

  /// Last known live fee in euros; seeded with the fallback constant so it is
  /// always safe to read.
  double _deliveryFeeEuros = AppTexts.cartShippingFee;

  /// The current delivery fee in euros — the live backend value once fetched,
  /// otherwise [AppTexts.cartShippingFee].
  double get deliveryFeeEuros => _deliveryFeeEuros;

  @override
  void onInit() {
    super.onInit();
    // Fire-and-forget: never block startup on this optional preview value.
    refresh();
  }

  /// Fetches the live fee and caches it. On any error the last known value
  /// (or the fallback constant) is kept.
  Future<void> refresh() async {
    try {
      _deliveryFeeEuros = await _repository.getDeliveryFeeEuros();
    } catch (e) {
      logWarning('DeliveryFeeService: keeping fallback fee ($e)');
    }
  }
}
