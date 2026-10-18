import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/device_lock_repository.dart';

/// Restores a working session from the biometric bundle.
///
/// A changed biometric set clears enrollment and leaves the working set empty.
class UnlockDevice {
  const UnlockDevice(this._locks);

  final DeviceLockRepository _locks;

  Future<void> call() async {
    final snapshot = await _locks.read();
    if (!snapshot.enrolled) {
      throw const UnexpectedFailure();
    }
    try {
      await _locks.restoreWorkingSession();
    } on BiometricEnrollmentLostFailure {
      await _locks.clearEnrollment();
      rethrow;
    }
  }
}
