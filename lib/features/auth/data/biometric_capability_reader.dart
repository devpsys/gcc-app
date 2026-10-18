import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';

abstract interface class BiometricCapabilityReader {
  Future<BiometricCapability> read();
}

/// Used when the platform plugins are not available, including widget tests.
final class UnavailableBiometricCapabilityReader
    implements BiometricCapabilityReader {
  const UnavailableBiometricCapabilityReader();

  @override
  Future<BiometricCapability> read() async {
    return const BiometricUnavailable(BiometricUnavailableReason.unsupported);
  }
}
