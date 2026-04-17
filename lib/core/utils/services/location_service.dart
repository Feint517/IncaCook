// import 'dart:async';
// import 'package:get/get.dart';

// /// Service to handle location tracking and updates
// /// Provides methods to get current location and track location changes
// class LocationService extends GetxController {
//   static LocationService get instance => Get.find();

//   final Location _location = Location();
//   StreamSubscription<LocationData>? _locationSubscription;

//   // Observable properties
//   final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
//   final Rx<bool> isLocationEnabled = false.obs;
//   final Rx<bool> isTracking = false.obs;
//   final Rx<bool> hasPermission = false.obs;

//   final PermissionService _permissionService = PermissionService.instance;

//   @override
//   void onInit() {
//     super.onInit();
//     _checkLocationService();
//   }

//   @override
//   void onClose() {
//     stopLocationUpdates();
//     _locationSubscription?.cancel();
//     super.onClose();
//   }

//   /// Check if location service is enabled
//   Future<void> _checkLocationService() async {
//     final serviceEnabled = await _location.serviceEnabled();
//     isLocationEnabled.value = serviceEnabled;
//   }

//   /// Initialize location service
//   /// Requests permissions and enables location service if needed
//   Future<bool> initialize() async {
//     try {
//       // Check and request permission
//       hasPermission.value = await _permissionService
//           .isLocationPermissionGranted();

//       if (!hasPermission.value) {
//         final granted = await _permissionService.requestPermissionWithRationale(
//           title: 'Location Permission Required',
//           message:
//               'We need your location to show nearby charging stations and help you navigate to them. Please grant location permission to continue.',
//           settingsButtonText: 'Open Settings',
//           cancelButtonText: 'Cancel',
//         );
//         hasPermission.value = granted;

//         if (!granted) {
//           return false;
//         }
//       }

//       // Check if location service is enabled
//       bool serviceEnabled = await _location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await _location.requestService();
//         if (!serviceEnabled) {
//           CustomLoaders.errorSnackBar(
//             title: 'Location Service Disabled',
//             message: 'Please enable location services in your device settings',
//           );
//           isLocationEnabled.value = false;
//           return false;
//         }
//       }

//       isLocationEnabled.value = true;
//       return true;
//     } catch (e) {
//       CustomLoaders.errorSnackBar(
//         title: 'Location Error',
//         message: 'Failed to initialize location service: ${e.toString()}',
//       );
//       return false;
//     }
//   }

//   /// Get current location (one-time)
//   /// Returns null if location cannot be determined
//   Future<LatLng?> getCurrentLocation() async {
//     try {
//       if (!hasPermission.value) {
//         final initialized = await initialize();
//         if (!initialized) {
//           return null;
//         }
//       }

//       if (!isLocationEnabled.value) {
//         final serviceEnabled = await _location.requestService();
//         if (!serviceEnabled) {
//           return null;
//         }
//         isLocationEnabled.value = true;
//       }

//       final locationData = await _location.getLocation();

//       if (locationData.latitude != null && locationData.longitude != null) {
//         final latLng = LatLng(locationData.latitude!, locationData.longitude!);
//         currentLocation.value = latLng;
//         return latLng;
//       }

//       return null;
//     } catch (e) {
//       CustomLoaders.errorSnackBar(
//         title: 'Location Error',
//         message: 'Failed to get current location: ${e.toString()}',
//       );
//       return null;
//     }
//   }

//   /// Start continuous location updates
//   /// Updates currentLocation observable as user moves
//   Future<bool> startLocationUpdates({
//     double distanceFilter = 10.0, // Update every 10 meters
//     int interval = 1000, // Update every 1 second
//   }) async {
//     try {
//       if (isTracking.value) {
//         return true; // Already tracking
//       }

//       if (!hasPermission.value) {
//         final initialized = await initialize();
//         if (!initialized) {
//           return false;
//         }
//       }

//       if (!isLocationEnabled.value) {
//         final serviceEnabled = await _location.requestService();
//         if (!serviceEnabled) {
//           CustomLoaders.errorSnackBar(
//             title: 'Location Service Disabled',
//             message: 'Please enable location services in your device settings',
//           );
//           return false;
//         }
//         isLocationEnabled.value = true;
//       }

//       // Configure location settings for high accuracy
//       await _location.changeSettings(
//         accuracy: LocationAccuracy.high,
//         interval: interval,
//         distanceFilter: distanceFilter,
//       );

//       // Start listening to location updates
//       _locationSubscription = _location.onLocationChanged.listen(
//         (LocationData locationData) {
//           if (locationData.latitude != null && locationData.longitude != null) {
//             currentLocation.value = LatLng(
//               locationData.latitude!,
//               locationData.longitude!,
//             );
//           }
//         },
//         onError: (error) {
//           CustomLoaders.errorSnackBar(
//             title: 'Location Update Error',
//             message: error.toString(),
//           );
//         },
//       );

//       isTracking.value = true;
//       return true;
//     } catch (e) {
//       CustomLoaders.errorSnackBar(
//         title: 'Location Error',
//         message: 'Failed to start location updates: ${e.toString()}',
//       );
//       return false;
//     }
//   }

//   /// Stop location updates
//   void stopLocationUpdates() {
//     _locationSubscription?.cancel();
//     _locationSubscription = null;
//     isTracking.value = false;
//   }

//   /// Get stream of location updates
//   /// Returns a stream of LatLng coordinates
//   Stream<LatLng> getLocationStream() {
//     return currentLocation.stream
//         .where((location) => location != null)
//         .map((location) => location!);
//   }
// }
