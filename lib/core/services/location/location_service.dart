import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxService {
  static LocationService get instance => Get.find();

  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final Rx<LocationPermission> permission =
      LocationPermission.unableToDetermine.obs;

  /// Human-readable "City, Country" for the current location, reverse-geocoded
  /// by whoever resolves the position (e.g. the client home). Null until known
  /// — UI shows a fallback meanwhile.
  final Rxn<String> placeLabel = Rxn<String>();

  StreamSubscription<Position>? _positionSub;

  /// Whether the current stream is running in background-persistent mode
  /// (Android foreground service / iOS background location updates). Tracked so
  /// [start] can restart the stream when the mode changes — e.g. idle-online
  /// (foreground) → active delivery (background).
  bool _backgroundMode = false;

  Future<bool> ensurePermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;

    var current = await Geolocator.checkPermission();
    if (current == LocationPermission.denied) {
      current = await Geolocator.requestPermission();
    }
    permission.value = current;
    return current == LocationPermission.whileInUse ||
        current == LocationPermission.always;
  }

  //* One-shot read. Use for things like "where am I right now to compute a
  //* route from" — for live tracking, use [start] and read [currentPosition].
  Future<Position?> getCurrent() async {
    if (!await ensurePermission()) return null;
    final pos = await Geolocator.getCurrentPosition();
    currentPosition.value = pos;
    return pos;
  }

  //* Start streaming the user's position. Safe to call repeatedly — no-ops if
  //* already streaming in the requested mode. Pass [background] = true during an
  //* Active delivery to keep updates flowing while the app is backgrounded
  //* (Android foreground service + persistent notification; iOS background
  //* location) so Live tracking doesn't go dark and the driver can't
  //* "disappear" mid-delivery. Idle-online stays foreground-only to save
  //* battery (per ADR-0002). Returns false when permission/services aren't
  //* granted.
  Future<bool> start({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilterMeters = 5,
    bool background = false,
  }) async {
    // Already streaming in the requested mode → nothing to do.
    if (_positionSub != null && _backgroundMode == background) return true;
    if (!await ensurePermission()) return false;

    // Mode changed (e.g. idle-online → active delivery): restart the stream so
    // the platform settings — foreground service / background updates — match.
    await _positionSub?.cancel();
    _positionSub = null;
    _backgroundMode = background;

    _positionSub =
        Geolocator.getPositionStream(
          locationSettings:
              _locationSettings(accuracy, distanceFilterMeters, background),
        ).listen(
          (pos) => currentPosition.value = pos,
          onError: (_) => currentPosition.value = null,
        );
    return true;
  }

  /// Platform-specific stream settings. In [background] mode the Android
  /// foreground-service notification + wake lock keep the process alive, and
  /// iOS background location updates are enabled with the blue status indicator.
  LocationSettings _locationSettings(
    LocationAccuracy accuracy,
    int distanceFilterMeters,
    bool background,
  ) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilterMeters,
        foregroundNotificationConfig: background
            ? const ForegroundNotificationConfig(
                notificationTitle: 'Livraison en cours',
                notificationText:
                    'Suivi de votre position pour la livraison en cours.',
                enableWakeLock: true,
                setOngoing: true,
              )
            : null,
      );
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return AppleSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilterMeters,
        allowBackgroundLocationUpdates: background,
        pauseLocationUpdatesAutomatically: false,
        showBackgroundLocationIndicator: background,
      );
    }
    return LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilterMeters,
    );
  }

  Future<void> stop() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _backgroundMode = false;
  }

  @override
  void onClose() {
    _positionSub?.cancel();
    super.onClose();
  }
}
