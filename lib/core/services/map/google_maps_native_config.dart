import 'dart:io';

import 'package:flutter/services.dart';
import 'package:incacook/core/config/google_maps_config.dart';
import 'package:incacook/core/utils/log.dart';

class GoogleMapsNativeConfig {
  GoogleMapsNativeConfig._();

  static const MethodChannel _channel = MethodChannel(
    'com.incacook.app/google_maps',
  );

  static Future<void> configure() async {
    if (!Platform.isIOS || !GoogleMapsConfig.isConfigured) return;

    try {
      await _channel.invokeMethod<void>('provideApiKey', {
        'apiKey': GoogleMapsConfig.apiKey,
      });
    } on MissingPluginException catch (e) {
      logWarning('[GoogleMaps] Native key bridge is not registered: $e');
    } on PlatformException catch (e) {
      logError('[GoogleMaps] Failed to configure native key: ${e.message}');
    }
  }
}
