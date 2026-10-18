import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/device_lock_snapshot.dart';

abstract interface class DeviceLockRepository {
  Future<DeviceLockSnapshot> read();

  /// Remembers that the agent dismissed the one-time enrollment offer.
  Future<void> declinePrompt();

  /// Copies the working tokens into the biometric-protected bundle.
  ///
  /// Throws a cache failure when there is no working token or the write fails.
  Future<void> protectWorkingSession();

  /// Sets the enrollment flag only after [protectWorkingSession] has succeeded.
  Future<void> markEnrolled(AuthRole role);

  /// Reads the bundle through the OS prompt and restores the working tokens.
  ///
  /// A dismissed prompt, a lockout, and a changed biometric set are distinct
  /// failures. The working set is unchanged when the read fails.
  Future<void> restoreWorkingSession();

  /// Deletes the bundle and the enrollment flag. The working session stays.
  Future<void> clearEnrollment();
}
