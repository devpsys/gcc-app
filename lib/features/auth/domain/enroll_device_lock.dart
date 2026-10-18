import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/device_lock_repository.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';

/// Turns the current session into a biometric-protected bundle.
///
/// Refuses unless a working session exists and the device can authenticate.
/// The enrollment flag is written only after the bundle write succeeds.
class EnrollDeviceLock {
  const EnrollDeviceLock(this._locks, this._session);

  final DeviceLockRepository _locks;
  final SessionRepository _session;

  Future<void> call() async {
    final session = _session.current;
    final role = session.role;
    if (!session.unlocked || role == null) {
      throw const UnexpectedFailure();
    }
    final snapshot = await _locks.read();
    if (snapshot.capability is! BiometricAvailable) {
      throw const UnexpectedFailure();
    }
    try {
      await _locks.protectWorkingSession();
      await _locks.markEnrolled(role);
    } on Failure {
      try {
        await _locks.clearEnrollment();
      } on Failure {
        // The protect or mark failure is the one the caller sees.
      }
      rethrow;
    }
  }
}
