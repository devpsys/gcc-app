import 'package:gcc_app/features/auth/domain/device_lock_repository.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';

/// Ends the session and forgets biometric enrollment on this device.
///
/// Enrollment is cleared first so the router does not flash the unlock screen
/// while the working tokens are still present.
class RevokeDeviceLock {
  const RevokeDeviceLock(this._locks, this._session);

  final DeviceLockRepository _locks;
  final SessionRepository _session;

  Future<void> call() async {
    await _locks.clearEnrollment();
    await _session.clearWorkingSet();
  }
}
