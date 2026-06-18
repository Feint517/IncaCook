import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:incacook/core/constants/text_strings.dart';
import 'package:incacook/core/models/auth/upload_info.dart';
import 'package:incacook/features/authentication/data/models/requests/create_upload_request.dart';
import 'package:incacook/features/authentication/data/repositories/uploads_repository.dart';

/// One pick + two-step upload, packaged for any UI that needs more
/// custom presentation than [SignupImagePicker] provides (e.g. the KYC
/// selfie page with its oval frame).
///
/// Returns the picked [File] and the storage `path` returned by
/// `POST /v1/uploads`. Returns null if the user cancelled the picker.
/// Throws [ApiFailure] / [Exception] on upload failure — callers
/// surface those in their own UI state.
class UploadPickResult {
  const UploadPickResult({required this.file, required this.path});

  final File file;
  final String path;
}

/// Thrown by [pickAndUploadImage] when the picked image is still over the
/// size ceiling *after* `image_picker`'s resize/compression — so we surface a
/// clear message instead of attempting an upload that would fail or hang.
class ImageTooLargeException implements Exception {
  const ImageTooLargeException([this.message = AppTexts.imagePickerTooLarge]);

  final String message;

  @override
  String toString() => message;
}

/// Hard ceiling for the uploaded bytes (5 MB). `image_picker` already
/// downscales to [maxWidth] × [maxHeight] at [imageQuality], so a normal
/// gallery photo lands well under this; the check only catches pathological
/// inputs (huge PNGs, panoramas) that survive compression.
const int _maxUploadBytes = 5 * 1024 * 1024;

Future<UploadPickResult?> pickAndUploadImage({
  required ImageSource source,
  required UploadPurpose purpose,
  // Resize + recompress on pick so large gallery photos don't fail/hang on
  // upload. ≤1600px on the long edge at JPEG q85 keeps photos sharp but light.
  int imageQuality = 85,
  double maxWidth = 1600,
  double maxHeight = 1600,
  CameraDevice preferredCameraDevice = CameraDevice.rear,
  UploadsRepository? uploads,
}) async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(
    source: source,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
    preferredCameraDevice: preferredCameraDevice,
  );
  if (picked == null) return null;

  final file = File(picked.path);
  final bytes = await file.readAsBytes();
  debugPrint(
    '[Upload] picked bytes=${bytes.length} '
    '(${(bytes.length / (1024 * 1024)).toStringAsFixed(2)} MB) purpose=$purpose',
  );

  // Don't fail silently / spin forever: reject before the upload if still too
  // large so the caller can show a clear error.
  if (bytes.length > _maxUploadBytes) {
    debugPrint('[Upload] rejected: image exceeds ${_maxUploadBytes ~/ (1024 * 1024)} MB');
    throw const ImageTooLargeException();
  }

  final repo = uploads ?? UploadsRepository.instance;
  final path = await repo.upload(
    req: CreateUploadRequest(
      purpose: purpose,
      contentType: _guessContentType(file.path),
    ),
    bytes: bytes,
  );
  return UploadPickResult(file: file, path: path);
}

String _guessContentType(String filePath) {
  final lower = filePath.toLowerCase();
  if (lower.endsWith('.png')) return 'image/png';
  if (lower.endsWith('.heic') || lower.endsWith('.heif')) return 'image/heic';
  if (lower.endsWith('.webp')) return 'image/webp';
  return 'image/jpeg';
}
