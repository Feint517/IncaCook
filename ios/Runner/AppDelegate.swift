import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Authorize the Google Maps SDK synchronously, before any GMSMapView can be
    // created. Reading the key from Info.plist keeps this working no matter how
    // the archive is produced (Xcode Archive, plain `flutter build`, or the melos
    // ipa task) — unlike the async Dart method-channel bridge below, which can
    // race the plugin registrar or fail silently and leave the map a blank grey
    // rectangle. Calling provideAPIKey twice (here + the bridge) is a harmless
    // no-op, so the bridge stays as a fallback.
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String,
      !apiKey.isEmpty
    {
      GMSServices.provideAPIKey(apiKey)
    } else {
      NSLog("[GoogleMaps] GMSApiKey missing from Info.plist — map tiles will render grey.")
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    guard
      let registrar = engineBridge.pluginRegistry.registrar(
        forPlugin: "GoogleMapsKeyBridge"
      )
    else {
      return
    }
    let channel = FlutterMethodChannel(
      name: "com.incacook.app/google_maps",
      binaryMessenger: registrar.messenger()
    )
    channel.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) in
      guard call.method == "provideApiKey" else {
        result(FlutterMethodNotImplemented)
        return
      }
      guard
        let args = call.arguments as? [String: Any],
        let apiKey = args["apiKey"] as? String,
        !apiKey.isEmpty
      else {
        result(FlutterError(code: "missing_api_key", message: "Google Maps API key is missing.", details: nil))
        return
      }
      GMSServices.provideAPIKey(apiKey)
      result(nil)
    }
  }
}
