import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/device_lock_repository.dart';
import 'package:gcc_app/features/auth/domain/device_lock_snapshot.dart';

class FakeDeviceLockRepository implements DeviceLockRepository {
  FakeDeviceLockRepository({this.snapshot = DeviceLockSnapshot.empty});

  DeviceLockSnapshot snapshot;
  Failure? failure;
  Failure? protectFailure;
  Failure? restoreFailure;
  int protectCount = 0;
  int markCount = 0;
  int restoreCount = 0;
  int clearCount = 0;
  int declineCount = 0;
  AuthRole? markedRole;

  @override
  Future<DeviceLockSnapshot> read() async {
    final error = failure;
    if (error != null) {
      throw error;
    }
    return snapshot;
  }

  @override
  Future<void> declinePrompt() async {
    declineCount += 1;
    snapshot = DeviceLockSnapshot(
      capability: snapshot.capability,
      enrolled: snapshot.enrolled,
      promptDeclined: true,
      lastRole: snapshot.lastRole,
    );
  }

  @override
  Future<void> protectWorkingSession() async {
    protectCount += 1;
    final error = protectFailure;
    if (error != null) {
      throw error;
    }
  }

  @override
  Future<void> markEnrolled(AuthRole role) async {
    markCount += 1;
    markedRole = role;
    snapshot = DeviceLockSnapshot(
      capability: snapshot.capability,
      enrolled: true,
      promptDeclined: false,
      lastRole: role,
    );
  }

  @override
  Future<void> restoreWorkingSession() async {
    restoreCount += 1;
    final error = restoreFailure;
    if (error != null) {
      throw error;
    }
  }

  @override
  Future<void> clearEnrollment() async {
    clearCount += 1;
    snapshot = DeviceLockSnapshot(
      capability: snapshot.capability,
      enrolled: false,
      promptDeclined: snapshot.promptDeclined,
      lastRole: snapshot.lastRole,
    );
  }
}
