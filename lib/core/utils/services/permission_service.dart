// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart' as ph;

// /// Service to handle location permissions
// /// Provides methods to check, request, and manage location permissions
// class PermissionService extends GetxController {
//   static PermissionService get instance => Get.find();

//   /// Check if location permission is granted
//   Future<bool> isLocationPermissionGranted() async {
//     final status = await ph.Permission.location.status;
//     return status.isGranted;
//   }

//   /// Check current location permission status
//   Future<ph.PermissionStatus> checkLocationPermission() async {
//     return await ph.Permission.location.status;
//   }

//   /// Request location permission
//   /// Returns true if granted, false otherwise
//   Future<bool> requestLocationPermission() async {
//     final status = await ph.Permission.location.request();
//     return status.isGranted;
//   }

//   /// Check if permission rationale should be shown
//   /// Returns true if permission was denied and rationale should be shown
//   Future<bool> shouldShowPermissionRationale() async {
//     final status = await ph.Permission.location.status;
//     return status.isDenied;
//   }

//   /// Check if permission is permanently denied
//   /// Returns true if permission is permanently denied (user selected "Don't ask again")
//   Future<bool> isPermissionPermanentlyDenied() async {
//     final status = await ph.Permission.location.status;
//     return status.isPermanentlyDenied;
//   }

//   /// Open app settings so user can manually grant permission
//   Future<bool> openAppSettings() async {
//     return await ph.openAppSettings();
//   }

//   /// Request permission with rationale dialog
//   /// Shows dialog explaining why permission is needed, then requests permission
//   Future<bool> requestPermissionWithRationale({
//     required String title,
//     required String message,
//     String? settingsButtonText,
//     String? cancelButtonText,
//   }) async {
//     // Check if already granted
//     if (await isLocationPermissionGranted()) {
//       return true;
//     }

//     // Check if permanently denied - show dialog with settings option
//     if (await isPermissionPermanentlyDenied()) {
//       return await _showPermissionDialog(
//         title: title,
//         message: message,
//         showSettings: true,
//         settingsButtonText: settingsButtonText ?? 'Open Settings',
//         cancelButtonText: cancelButtonText ?? 'Cancel',
//       );
//     }

//     // Check if should show rationale
//     if (await shouldShowPermissionRationale()) {
//       final shouldRequest = await _showPermissionDialog(
//         title: title,
//         message: message,
//         showSettings: false,
//         settingsButtonText: null,
//         cancelButtonText: cancelButtonText ?? 'Cancel',
//       );

//       if (!shouldRequest) {
//         return false;
//       }
//     }

//     // Request permission
//     return await requestLocationPermission();
//   }

//   /// Show permission dialog with rationale
//   Future<bool> _showPermissionDialog({
//     required String title,
//     required String message,
//     required bool showSettings,
//     String? settingsButtonText,
//     String? cancelButtonText,
//   }) async {
//     bool? result = false;

//     await Get.dialog(
//       AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           if (showSettings)
//             TextButton(
//               onPressed: () async {
//                 result = await openAppSettings();
//                 Get.back();
//               },
//               child: Text(settingsButtonText ?? 'Open Settings'),
//             ),
//           TextButton(
//             onPressed: () {
//               result = false;
//               Get.back();
//             },
//             child: Text(cancelButtonText ?? 'Cancel'),
//           ),
//           if (!showSettings)
//             TextButton(
//               onPressed: () {
//                 result = true;
//                 Get.back();
//               },
//               child: const Text('Allow'),
//             ),
//         ],
//       ),
//       barrierDismissible: false,
//     );

//     return result ?? false;
//   }
// }
