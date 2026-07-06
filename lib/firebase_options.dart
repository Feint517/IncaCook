import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebase project options for IncaCook mobile.
///
/// Kept in source so iOS does not depend on the native plist being bundled
/// before Dart can initialize Firebase. Values mirror:
/// - android/app/google-services.json
/// - ios/Runner/GoogleService-Info.plist
class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Firebase web options are not configured.');
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'Firebase is only configured for Android and iOS.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3TJ1ly6Dc5QLuxIxLMw04hpYBygBzFHk',
    appId: '1:623882469274:android:fcea782fca1bda5ea1c423',
    messagingSenderId: '623882469274',
    projectId: 'incacook-7b97c',
    storageBucket: 'incacook-7b97c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQiTn7eq3B8jwb4rM8DGJ6WY8uhitNVhI',
    appId: '1:623882469274:ios:67e81c92db264f26a1c423',
    messagingSenderId: '623882469274',
    projectId: 'incacook-7b97c',
    storageBucket: 'incacook-7b97c.firebasestorage.app',
    iosBundleId: 'com.incacook.app',
  );
}
