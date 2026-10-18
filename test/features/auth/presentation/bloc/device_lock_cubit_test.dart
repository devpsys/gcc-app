import 'package:bloc_test/bloc_test.dart';
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
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_state.dart';

import '../../fake_device_lock_repository.dart';
import '../../fake_session_gate.dart';
import '../../fake_session_repository.dart';

void main() {
  late FakeDeviceLockRepository locks;
  late FakeSessionRepository session;
  late FakeSessionGate gate;

  const offered = DeviceLockSnapshot(
    capability: BiometricAvailable(BiometricMethod.fingerprint),
    enrolled: false,
    promptDeclined: false,
  );

  const declined = DeviceLockSnapshot(
    capability: BiometricAvailable(BiometricMethod.fingerprint),
    enrolled: false,
    promptDeclined: true,
  );

  const available = DeviceLockSnapshot(
    capability: BiometricAvailable(BiometricMethod.fingerprint),
    enrolled: true,
    promptDeclined: false,
    lastRole: AuthRole.agent,
  );

  DeviceLockCubit build() {
    return DeviceLockCubit(
      locks,
      EnrollDeviceLock(locks, session),
      UnlockDevice(locks),
      RevokeDeviceLock(locks, session),
      gate,
    );
  }

  setUp(() {
    locks = FakeDeviceLockRepository(snapshot: available);
    session = FakeSessionRepository(
      current: const SessionSnapshot(unlocked: true, role: AuthRole.agent),
    );
    gate = FakeSessionGate();
  });

  blocTest<DeviceLockCubit, DeviceLockState>(
    'load emits the snapshot',
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => [const DeviceLockReady(available)],
  );

  blocTest<DeviceLockCubit, DeviceLockState>(
    'a second unlock while busy is ignored',
    build: build,
    seed: () => const DeviceLockBusy(available),
    act: (cubit) => cubit.unlock(),
    expect: () => <DeviceLockState>[],
  );

  blocTest<DeviceLockCubit, DeviceLockState>(
    'cancel returns to ready without a failure',
    build: build,
    seed: () => const DeviceLockReady(available),
    act: (cubit) {
      locks.restoreFailure = const CancelledFailure();
      return cubit.unlock();
    },
    expect: () => [
      const DeviceLockBusy(available),
      const DeviceLockReady(available),
    ],
  );

  blocTest<DeviceLockCubit, DeviceLockState>(
    'lockout keeps the device enrolled',
    build: build,
    seed: () => const DeviceLockReady(available),
    act: (cubit) {
      locks.restoreFailure = const BiometricLockoutFailure();
      return cubit.unlock();
    },
    expect: () => [
      const DeviceLockBusy(available),
      const DeviceLockFailed(
        snapshot: available,
        failure: BiometricLockoutFailure(),
      ),
    ],
  );

  blocTest<DeviceLockCubit, DeviceLockState>(
    'cancelling enrollment remembers the dismissal',
    build: build,
    seed: () => const DeviceLockReady(offered),
    act: (cubit) {
      locks.snapshot = offered;
      locks.protectFailure = const CancelledFailure();
      return cubit.enroll();
    },
    expect: () => [
      const DeviceLockBusy(offered),
      const DeviceLockReady(declined),
    ],
  );

  blocTest<DeviceLockCubit, DeviceLockState>(
    'decline remembers the dismissal',
    build: build,
    seed: () => const DeviceLockReady(
      DeviceLockSnapshot(
        capability: BiometricAvailable(BiometricMethod.fingerprint),
        enrolled: false,
        promptDeclined: false,
      ),
    ),
    act: (cubit) => cubit.declinePrompt(),
    verify: (cubit) {
      expect(locks.declineCount, 1);
      expect(cubit.state, isA<DeviceLockReady>());
      expect(cubit.state.snapshot.promptDeclined, isTrue);
    },
  );
}
