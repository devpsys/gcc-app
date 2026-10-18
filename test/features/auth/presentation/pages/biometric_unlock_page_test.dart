import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:gcc_app/features/auth/presentation/pages/biometric_unlock_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_device_lock_repository.dart';
import '../../fake_session_gate.dart';
import '../../fake_session_repository.dart';

void main() {
  DeviceLockCubit cubitFor(FakeDeviceLockRepository locks) {
    final session = FakeSessionRepository(
      current: const SessionSnapshot(unlocked: true, role: AuthRole.agent),
    );
    return DeviceLockCubit(
      locks,
      EnrollDeviceLock(locks, session),
      UnlockDevice(locks),
      RevokeDeviceLock(locks, session),
      FakeSessionGate(),
    );
  }

  testWidgets('disables unlock and states why when biometrics are missing', (
    tester,
  ) async {
    final locks = FakeDeviceLockRepository(
      snapshot: const DeviceLockSnapshot(
        capability: BiometricUnavailable(BiometricUnavailableReason.noHardware),
        enrolled: false,
        promptDeclined: false,
      ),
    );
    final cubit = cubitFor(locks);
    await cubit.load();

    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const BiometricUnlockPage(),
      ),
    );

    expect(find.text('Unlock'), findsOneWidget);
    expect(find.text('This device has no biometric sensor.'), findsOneWidget);
    expect(find.text('Use verification code instead'), findsOneWidget);
  });

  testWidgets('cancel leaves unlock enabled and shows no error', (
    tester,
  ) async {
    final locks = FakeDeviceLockRepository(
      snapshot: const DeviceLockSnapshot(
        capability: BiometricAvailable(BiometricMethod.fingerprint),
        enrolled: true,
        promptDeclined: false,
        lastRole: AuthRole.agent,
      ),
    );
    locks.restoreFailure = const CancelledFailure();
    final cubit = cubitFor(locks);
    await cubit.load();

    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const BiometricUnlockPage(),
      ),
    );

    await tester.tap(find.text('Unlock'));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Biometric unlock failed. Try again, or use a verification code.',
      ),
      findsNothing,
    );
    expect(find.text('Unlock'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Unlock'))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('unlock page survives large text', (tester) async {
    final locks = FakeDeviceLockRepository(
      snapshot: const DeviceLockSnapshot(
        capability: BiometricAvailable(BiometricMethod.face),
        enrolled: true,
        promptDeclined: false,
        lastRole: AuthRole.agent,
      ),
    );
    final cubit = cubitFor(locks);
    await cubit.load();

    await pumpLocalized(
      tester,
      size: const Size(320, 640),
      textScaler: const TextScaler.linear(2),
      child: BlocProvider.value(
        value: cubit,
        child: const BiometricUnlockPage(),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Unlock with Face ID'), findsOneWidget);
  });
}
