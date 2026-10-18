import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gcc_app/core/constants/storage_keys.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/features/auth/data/biometric_secret_store.dart';
import 'package:gcc_app/features/auth/data/biometric_storage_error.dart';

/// Token bundle gated by the platform biometric prompt.
///
/// The prompt strings are owned by the OS dialog, which cannot read ARB.
/// They match the English unlock copy.
final class FlutterSecureBiometricSecretStore implements BiometricSecretStore {
  FlutterSecureBiometricSecretStore({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions.biometric(
              enforceBiometrics: true,
              requireBiometricsPerOperation: true,
              resetOnError: false,
              biometricType: AndroidBiometricType.strongBiometricOnly,
              storageNamespace: 'gcc_device_lock',
              biometricPromptTitle: 'Unlock GCC',
              biometricPromptSubtitle:
                  'Confirm it is you to open your saved sign-in.',
              biometricPromptNegativeButton: 'Cancel',
            ),
            iOptions: IOSOptions(
              accountName: 'gcc_device_lock',
              accessibility: KeychainAccessibility.first_unlock_this_device,
              accessControlFlags: [AccessControlFlag.biometryCurrentSet],
            ),
          );

  final FlutterSecureStorage _storage;

  @override
  Future<void> write(BiometricBundle bundle) {
    return _guard(() async {
      await _storage.write(
        key: StorageKeys.accessToken,
        value: bundle.accessToken,
      );
      final refresh = bundle.refreshToken;
      if (refresh == null || refresh.isEmpty) {
        await _storage.delete(key: StorageKeys.refreshToken);
        return;
      }
      await _storage.write(key: StorageKeys.refreshToken, value: refresh);
    });
  }

  @override
  Future<BiometricBundle> read() {
    return _guard(() async {
      final access = await _storage.read(key: StorageKeys.accessToken);
      if (access == null || access.isEmpty) {
        throw const BiometricEnrollmentLostException();
      }
      final refresh = await _storage.read(key: StorageKeys.refreshToken);
      return BiometricBundle(
        accessToken: access,
        refreshToken: refresh == null || refresh.isEmpty ? null : refresh,
      );
    });
  }

  @override
  Future<void> delete() {
    return _guard(() async {
      await _storage.delete(key: StorageKeys.accessToken);
      await _storage.delete(key: StorageKeys.refreshToken);
    });
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } on PlatformException catch (error) {
      throw mapBiometricStorageError(error);
    }
  }
}
