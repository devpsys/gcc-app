import 'package:flutter/services.dart';
import 'package:gcc_app/core/error/exceptions.dart';

/// Maps a secure-storage biometric failure onto an [AppException].
///
/// Android reports `Biometric authentication error [<code>]`. Codes 5, 10, and
/// 13 are cancellation. Codes 7 and 9 are lockout. A key invalidated by a new
/// fingerprint or face is enrollment loss. iOS user-cancel is -128 or -2, and
/// a `biometryCurrentSet` item that no longer matches is -25293 or -25300.
AppException mapBiometricStorageError(PlatformException error) {
  final blob = '${error.code} ${error.message ?? ''}'.toLowerCase();
  if (_enrollmentLost(blob)) {
    return const BiometricEnrollmentLostException();
  }
  if (_lockout(blob)) {
    return const BiometricLockoutException();
  }
  if (_cancelled(blob)) {
    return const CancelledException();
  }
  return CacheException(error);
}

bool _cancelled(String blob) {
  return blob.contains('cancel') ||
      blob.contains('[10]') ||
      blob.contains('[5]') ||
      blob.contains('[13]') ||
      RegExp(r'(?<!\d)-128(?!\d)').hasMatch(blob) ||
      RegExp(r'(?<!\d)-2(?!\d)').hasMatch(blob);
}

bool _lockout(String blob) {
  return blob.contains('lockout') ||
      blob.contains('[7]') ||
      blob.contains('[9]') ||
      blob.contains('-8');
}

bool _enrollmentLost(String blob) {
  return blob.contains('invalidated') ||
      blob.contains('biometrychanged') ||
      blob.contains('-25293') ||
      blob.contains('-25300');
}
