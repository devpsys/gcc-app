import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';
import 'package:local_auth/local_auth.dart';

BiometricCapability capabilityFromBiometricTypes(List<BiometricType> types) {
  if (types.contains(BiometricType.face)) {
    return const BiometricAvailable(BiometricMethod.face);
  }
  if (types.contains(BiometricType.fingerprint)) {
    return const BiometricAvailable(BiometricMethod.fingerprint);
  }
  if (types.contains(BiometricType.iris)) {
    return const BiometricAvailable(BiometricMethod.iris);
  }
  if (types.contains(BiometricType.strong) ||
      types.contains(BiometricType.weak)) {
    return const BiometricAvailable(BiometricMethod.unknown);
  }
  return const BiometricUnavailable(BiometricUnavailableReason.noneEnrolled);
}
