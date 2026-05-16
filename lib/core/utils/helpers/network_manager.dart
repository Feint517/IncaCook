import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:incacook/core/common/styles/loaders.dart';

/// Tracks device connectivity and warns the user when it actually drops.
///
/// `connectivity_plus`'s subscription emits the current state immediately
/// on listen — and on cold start that first emission can briefly report
/// `[none]` before the OS finishes resolving Wi-Fi/cell. We sidestep two
/// problems with that:
///
/// 1. We pre-seed [_isOnline] from a one-shot [Connectivity.checkConnectivity]
///    so the stream's first emission compares against a real baseline.
/// 2. The warning snackbar only fires on a *transition* from online to
///    offline. Subsequent confirmations of "still offline" don't re-fire,
///    and reconnecting silently dismisses the warning.
///
/// A list of results is treated as offline only when *every* entry is
/// `ConnectivityResult.none` — earlier code looked at `result.first`,
/// which mislabels a device that has e.g. cellular AND none as offline.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  /// Last known connectivity verdict. `null` means we haven't probed yet
  /// (so the first stream emission won't be treated as a transition).
  bool? _isOnline;

  @override
  void onInit() {
    super.onInit();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // Seed from a one-shot probe before subscribing. The probe itself
    // doesn't show a popup — it just establishes the baseline so the
    // first stream emission is compared against the real state.
    try {
      final initial = await _connectivity.checkConnectivity();
      _isOnline = !_isAllOffline(initial);
    } on PlatformException {
      _isOnline = null;
    }

    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(List<ConnectivityResult> result) {
    final offline = _isAllOffline(result);
    final wasOnline = _isOnline;
    _isOnline = !offline;

    if (offline && wasOnline == true) {
      // Real transition online → offline. Warn once.
      CustomLoaders.warningSnackBar(title: 'No Internet Connection');
    } else if (!offline && wasOnline == false) {
      // Reconnected — dismiss whatever offline snackbar is still showing.
      // (No "back online" toast — silent recovery feels less noisy.)
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
    }
  }

  /// `result` is offline only when every interface reports `none`.
  bool _isAllOffline(List<ConnectivityResult> result) {
    if (result.isEmpty) return true;
    return result.every((r) => r == ConnectivityResult.none);
  }

  /// One-shot check. Returns true if at least one interface is connected.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return !_isAllOffline(result);
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }
}
