import 'package:get/get.dart';

import 'package:incacook/core/constants/api_constants.dart';
import 'package:incacook/core/network/api_client.dart';

/// Repository for public, client-relevant platform settings under
/// `/v1/settings/*`. These are the admin-configured values the buyer app
/// reads so it never has to hardcode them.
class SettingsRepository extends GetxService {
  SettingsRepository({ApiClient? api}) : _api = api ?? Get.find<ApiClient>();

  static SettingsRepository get instance => Get.find();

  final ApiClient _api;

  /// `GET /v1/settings/delivery-fee` — public (no auth). Returns the live
  /// flat delivery fee in euros so the pre-checkout display matches the
  /// admin panel's single source of truth. Throws [ApiFailure] on any
  /// transport/backend error; callers fall back to a constant.
  Future<double> getDeliveryFeeEuros() async {
    final result = await _api.get<double>(
      '${ApiConstants.apiPrefix}/settings/delivery-fee',
      decoder: (json) {
        final map = json! as Map<String, dynamic>;
        return (map['deliveryFeeEuros'] as num).toDouble();
      },
    );
    return result.data;
  }
}
