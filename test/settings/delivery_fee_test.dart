import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/network/api_client.dart';
import 'package:incacook/core/network/api_response.dart';
import 'package:incacook/core/network/token_storage.dart';
import 'package:incacook/features/settings/data/settings_repository.dart';
import 'package:incacook/features/settings/services/delivery_fee_service.dart';

/// Fake [ApiClient] whose `get` returns a canned already-unwrapped `data`
/// payload (the envelope is stripped by the real client, so the repository's
/// decoder receives just the inner object). Never touches the network or the
/// secure-storage plugin.
class _FakeApiClient extends ApiClient {
  _FakeApiClient(this._data) : super(dio: Dio(), tokenStorage: TokenStorage());

  final Object? _data;

  @override
  Future<ApiSuccess<T>> get<T>(
    String path, {
    required T Function(Object? json) decoder,
    Map<String, dynamic>? queryParameters,
  }) async {
    return ApiSuccess<T>(decoder(_data));
  }
}

/// Fake repository so the service test never hits the network: returns
/// [_result], or throws when it is null (to exercise the fallback path).
class _FakeSettingsRepository extends SettingsRepository {
  _FakeSettingsRepository(this._result) : super(api: _FakeApiClient(null));

  final double? _result;

  @override
  Future<double> getDeliveryFeeEuros() async {
    final r = _result;
    if (r == null) throw Exception('boom');
    return r;
  }
}

void main() {
  group('SettingsRepository.getDeliveryFeeEuros', () {
    test('parses deliveryFeeEuros from the payload', () async {
      final repo = SettingsRepository(
        api: _FakeApiClient({'deliveryFeeCents': 350, 'deliveryFeeEuros': 3.5}),
      );
      expect(await repo.getDeliveryFeeEuros(), 3.5);
    });

    test('coerces an integer euros value to a double', () async {
      final repo = SettingsRepository(
        api: _FakeApiClient({'deliveryFeeCents': 400, 'deliveryFeeEuros': 4}),
      );
      expect(await repo.getDeliveryFeeEuros(), 4.0);
    });
  });

  group('DeliveryFeeService', () {
    test('exposes the fallback constant before any fetch', () {
      final service = DeliveryFeeService(
        repository: _FakeSettingsRepository(5.5),
      );
      expect(service.deliveryFeeEuros, AppTexts.cartShippingFee);
    });

    test('caches the live fee after a successful refresh', () async {
      final service = DeliveryFeeService(
        repository: _FakeSettingsRepository(5.5),
      );
      await service.refresh();
      expect(service.deliveryFeeEuros, 5.5);
    });

    test('keeps the fallback constant when the fetch fails', () async {
      final service = DeliveryFeeService(
        repository: _FakeSettingsRepository(null),
      );
      await service.refresh();
      expect(service.deliveryFeeEuros, AppTexts.cartShippingFee);
    });
  });
}
