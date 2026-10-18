import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';
import 'package:gcc_app/features/auth/domain/device_lock_snapshot.dart';
import 'package:gcc_app/features/auth/domain/enroll_device_lock.dart';
import 'package:gcc_app/features/auth/domain/revoke_device_lock.dart';
import 'package:gcc_app/features/auth/domain/session_snapshot.dart';
import 'package:gcc_app/features/auth/domain/unlock_device.dart';

import '../fake_device_lock_repository.dart';
import '../fake_session_repository.dart';

void main() {
  late FakeDeviceLockRepository locks;
  late FakeSessionRepository session;

  setUp(() {
    locks = FakeDeviceLockRepository(
      snapshot: const DeviceLockSnapshot(
        capability: BiometricAvailable(BiometricMethod.fingerprint),
        enrolled: false,
        promptDeclined: false,
      ),
    );
    session = FakeSessionRepository(
      current: const SessionSnapshot(unlocked: true, role: AuthRole.agent),
    );
  });

  test('enroll refuses without a working session', () async {
    session.current = const SessionSnapshot(unlocked: false);
    final enroll = EnrollDeviceLock(locks, session);

    await expectLater(enroll.call(), throwsA(isA<UnexpectedFailure>()));
    expect(locks.protectCount, 0);
    expect(locks.snapshot.enrolled, isFalse);
  });

  test('enroll refuses when biometrics are unavailable', () async {
    locks.snapshot = DeviceLockSnapshot.empty;
    final enroll = EnrollDeviceLock(locks, session);

    await expectLater(enroll.call(), throwsA(isA<UnexpectedFailure>()));
    expect(locks.markCount, 0);
  });

  test('enroll writes the bundle before the flag', () async {
    final enroll = EnrollDeviceLock(locks, session);

    await enroll.call();

    expect(locks.protectCount, 1);
    expect(locks.markedRole, AuthRole.agent);
    expect(locks.snapshot.enrolled, isTrue);
  });

  test('a failed bundle write leaves enrollment off', () async {
    locks.protectFailure = const CacheFailure();
    final enroll = EnrollDeviceLock(locks, session);

    await expectLater(enroll.call(), throwsA(isA<CacheFailure>()));
    expect(locks.markCount, 0);
    expect(locks.clearCount, 1);
    expect(locks.snapshot.enrolled, isFalse);
  });

  test('unlock refuses when the device is not enrolled', () async {
    final unlock = UnlockDevice(locks);

    await expectLater(unlock.call(), throwsA(isA<UnexpectedFailure>()));
    expect(locks.restoreCount, 0);
  });

  test('unlock restores the working session', () async {
    locks.snapshot = const DeviceLockSnapshot(
      capability: BiometricAvailable(BiometricMethod.face),
      enrolled: true,
      promptDeclined: false,
      lastRole: AuthRole.agent,
    );
    final unlock = UnlockDevice(locks);

    await unlock.call();

    expect(locks.restoreCount, 1);
    expect(locks.clearCount, 0);
  });

  test('a changed biometric set clears enrollment and stays locked', () async {
    locks.snapshot = const DeviceLockSnapshot(
      capability: BiometricAvailable(BiometricMethod.face),
      enrolled: true,
      promptDeclined: false,
    );
    locks.restoreFailure = const BiometricEnrollmentLostFailure();
    final unlock = UnlockDevice(locks);

    await expectLater(
      unlock.call(),
      throwsA(isA<BiometricEnrollmentLostFailure>()),
    );
    expect(locks.clearCount, 1);
    expect(locks.snapshot.enrolled, isFalse);
  });

  test('cancel does not clear enrollment', () async {
    locks.snapshot = const DeviceLockSnapshot(
      capability: BiometricAvailable(BiometricMethod.fingerprint),
      enrolled: true,
      promptDeclined: false,
    );
    locks.restoreFailure = const CancelledFailure();
    final unlock = UnlockDevice(locks);

    await expectLater(unlock.call(), throwsA(isA<CancelledFailure>()));
    expect(locks.clearCount, 0);
    expect(locks.snapshot.enrolled, isTrue);
  });

  test('revoke clears the bundle and the working session', () async {
    locks.snapshot = const DeviceLockSnapshot(
      capability: BiometricAvailable(BiometricMethod.fingerprint),
      enrolled: true,
      promptDeclined: false,
      lastRole: AuthRole.agent,
    );
    final revoke = RevokeDeviceLock(locks, session);

    await revoke.call();

    expect(locks.clearCount, 1);
    expect(locks.snapshot.enrolled, isFalse);
    expect(session.clearCount, 1);
    expect(session.current.unlocked, isFalse);
  });
}
