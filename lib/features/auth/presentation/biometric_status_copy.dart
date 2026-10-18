import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

final class BiometricStatusCopy {
  const BiometricStatusCopy({this.value, this.detail, required this.available});

  final String? value;
  final String? detail;
  final bool available;
}

BiometricStatusCopy biometricStatusCopy(
  AppLocalizations l10n,
  BiometricCapability capability,
) {
  return switch (capability) {
    BiometricAvailable(:final method) => BiometricStatusCopy(
      available: true,
      value: _methodName(l10n, method),
    ),
    BiometricUnavailable(:final reason) => BiometricStatusCopy(
      available: false,
      detail: _unavailable(l10n, reason),
    ),
  };
}

String biometricUnlockTitle(
  AppLocalizations l10n,
  BiometricCapability capability,
) {
  if (capability is! BiometricAvailable) {
    return l10n.biometricUnlockTitleGeneric;
  }
  return switch (capability.method) {
    BiometricMethod.face => l10n.biometricUnlockTitleFace,
    BiometricMethod.fingerprint => l10n.biometricUnlockTitleFingerprint,
    BiometricMethod.iris ||
    BiometricMethod.unknown => l10n.biometricUnlockTitleGeneric,
  };
}

String _methodName(AppLocalizations l10n, BiometricMethod method) {
  return switch (method) {
    BiometricMethod.face => l10n.biometricMethodFace,
    BiometricMethod.fingerprint => l10n.biometricMethodFingerprint,
    BiometricMethod.iris => l10n.biometricMethodIris,
    BiometricMethod.unknown => l10n.biometricMethodGeneric,
  };
}

String _unavailable(AppLocalizations l10n, BiometricUnavailableReason reason) {
  return switch (reason) {
    BiometricUnavailableReason.web => l10n.biometricUnavailableWeb,
    BiometricUnavailableReason.noHardware => l10n.biometricUnavailableHardware,
    BiometricUnavailableReason.noneEnrolled =>
      l10n.biometricUnavailableNoneEnrolled,
    BiometricUnavailableReason.lockout => l10n.biometricUnavailableLockout,
    BiometricUnavailableReason.unsupported => l10n.biometricGenericFailure,
  };
}
