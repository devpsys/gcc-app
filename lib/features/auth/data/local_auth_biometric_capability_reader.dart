import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/features/auth/data/biometric_capability_reader.dart';
import 'package:gcc_app/features/auth/data/biometric_type_mapping.dart';
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';
import 'package:local_auth/local_auth.dart';

/// Asks the platform whether a biometric can be enrolled.
///
/// This type does not call [LocalAuthentication.authenticate]. The prompt is
/// the keystore or keychain read, so the person is not asked twice.
final class LocalAuthBiometricCapabilityReader
    implements BiometricCapabilityReader {
  const LocalAuthBiometricCapabilityReader(this._auth);

  final LocalAuthentication _auth;

  @override
  Future<BiometricCapability> read() async {
    if (kIsWeb) {
      return const BiometricUnavailable(BiometricUnavailableReason.web);
    }
    try {
      final supported = await _auth.isDeviceSupported();
      if (!supported) {
        return const BiometricUnavailable(
          BiometricUnavailableReason.noHardware,
        );
      }
      final types = await _auth.getAvailableBiometrics();
      return capabilityFromBiometricTypes(types);
    } on LocalAuthException catch (error) {
      return _fromAuthException(error.code);
    } on PlatformException {
      return const BiometricUnavailable(BiometricUnavailableReason.unsupported);
    }
  }

  BiometricCapability _fromAuthException(LocalAuthExceptionCode code) {
    return switch (code) {
      LocalAuthExceptionCode.noBiometricHardware => const BiometricUnavailable(
        BiometricUnavailableReason.noHardware,
      ),
      LocalAuthExceptionCode.noBiometricsEnrolled ||
      LocalAuthExceptionCode.noCredentialsSet => const BiometricUnavailable(
        BiometricUnavailableReason.noneEnrolled,
      ),
      LocalAuthExceptionCode.temporaryLockout ||
      LocalAuthExceptionCode.biometricLockout => const BiometricUnavailable(
        BiometricUnavailableReason.lockout,
      ),
      _ => const BiometricUnavailable(BiometricUnavailableReason.unsupported),
    };
  }
}
