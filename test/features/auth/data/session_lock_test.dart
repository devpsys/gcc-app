import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/storage/memory_credential_store.dart';
import 'package:gcc_app/features/auth/data/biometric_capability_reader.dart';
import 'package:gcc_app/features/auth/data/biometric_secret_store.dart';
import 'package:gcc_app/features/auth/data/biometric_storage_error.dart';
import 'package:gcc_app/features/auth/data/biometric_type_mapping.dart';
import 'package:gcc_app/features/auth/data/device_lock_repository_impl.dart';
import 'package:gcc_app/features/auth/data/hive_device_lock_flag_store.dart';
import 'package:gcc_app/features/auth/data/session_memory.dart';
import 'package:gcc_app/features/auth/data/session_repository_impl.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';
import 'package:gcc_app/features/auth/domain/enroll_device_lock.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  test('maps face before a generic strong biometric', () {
    final capability = capabilityFromBiometricTypes(const [
      BiometricType.strong,
      BiometricType.face,
    ]);

    expect(capability, const BiometricAvailable(BiometricMethod.face));
  });

  test('maps an empty sensor list to none enrolled', () {
    expect(
      capabilityFromBiometricTypes(const []),
      const BiometricUnavailable(BiometricUnavailableReason.noneEnrolled),
    );
  });

  test('maps cancel, lockout, and a changed biometric set', () {
    expect(
      mapBiometricStorageError(
        PlatformException(
          code: 'error',
          message: 'Biometric authentication error [10]: canceled',
        ),
      ),
      isA<CancelledException>(),
    );
    expect(
      mapBiometricStorageError(
        PlatformException(
          code: 'error',
          message: 'Biometric authentication error [7]: lockout',
        ),
      ),
      isA<BiometricLockoutException>(),
    );
    expect(
      mapBiometricStorageError(
        PlatformException(code: 'error', message: 'KeyPermanentlyInvalidated'),
      ),
      isA<BiometricEnrollmentLostException>(),
    );
    expect(
      mapBiometricStorageError(
        PlatformException(code: '-25293', message: 'auth failed'),
      ),
      isA<BiometricEnrollmentLostException>(),
    );
  });

  test('cold start wipes the working token only when enrolled', () async {
    final credentials = MemoryCredentialStore();
    final flags = _Flags()..enrolled = true;
    final memory = SessionMemory();
    final session = _session(credentials, flags, memory);
    await credentials.writeAccessToken('local.kept');

    await session.prepareColdStart();

    expect(await credentials.readAccessToken(), isNull);
    expect(memory.unlocked, isFalse);
    expect(memory.enrolled, isTrue);

    flags.enrolled = false;
    await credentials.writeAccessToken('local.kept');
    await session.prepareColdStart();

    expect(await credentials.readAccessToken(), 'local.kept');
    expect(memory.unlocked, isTrue);
  });

  test('enroll stores the working token and then the flag', () async {
    final credentials = MemoryCredentialStore();
    final flags = _Flags();
    final bundle = MemoryBiometricSecretStore();
    final memory = SessionMemory();
    final session = _session(credentials, flags, memory);
    await session.establish(AuthRole.agent);
    final locks = DeviceLockRepositoryImpl(
      flags: flags,
      bundle: bundle,
      capability: const _Reader(
        BiometricAvailable(BiometricMethod.fingerprint),
      ),
      credentials: credentials,
      memory: memory,
    );

    await EnrollDeviceLock(locks, session).call();

    expect(flags.enrolled, isTrue);
    expect(bundle.bundle?.accessToken, startsWith('local.'));
    expect(memory.enrolled, isTrue);
  });
}

SessionRepositoryImpl _session(
  MemoryCredentialStore credentials,
  _Flags flags,
  SessionMemory memory,
) {
  return SessionRepositoryImpl(
    credentials: credentials,
    flags: flags,
    capability: const _Reader(
      BiometricUnavailable(BiometricUnavailableReason.unsupported),
    ),
    memory: memory,
  );
}

final class _Reader implements BiometricCapabilityReader {
  const _Reader(this.capability);

  final BiometricCapability capability;

  @override
  Future<BiometricCapability> read() async => capability;
}

final class _Flags implements DeviceLockFlagStore {
  @override
  bool enrolled = false;

  @override
  bool promptDeclined = false;

  @override
  AuthRole? role;

  @override
  Future<void> writeEnrolled(AuthRole next) async {
    enrolled = true;
    role = next;
    promptDeclined = false;
  }

  @override
  Future<void> writeDeclined() async {
    promptDeclined = true;
  }

  @override
  Future<void> writeRole(AuthRole next) async {
    role = next;
  }

  @override
  Future<void> clearEnrolled() async {
    enrolled = false;
  }
}
