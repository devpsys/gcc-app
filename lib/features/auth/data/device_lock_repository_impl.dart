import 'package:gcc_app/core/error/exception_mapper.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/storage/secure_credential_store.dart';
import 'package:gcc_app/features/auth/data/biometric_capability_reader.dart';
import 'package:gcc_app/features/auth/data/biometric_secret_store.dart';
import 'package:gcc_app/features/auth/data/hive_device_lock_flag_store.dart';
import 'package:gcc_app/features/auth/data/session_memory.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/device_lock_repository.dart';
import 'package:gcc_app/features/auth/domain/device_lock_snapshot.dart';

final class DeviceLockRepositoryImpl implements DeviceLockRepository {
  DeviceLockRepositoryImpl({
    required this._flags,
    required this._bundle,
    required this._capability,
    required this._credentials,
    required this._memory,
  });

  final DeviceLockFlagStore _flags;
  final BiometricSecretStore _bundle;
  final BiometricCapabilityReader _capability;
  final SecureCredentialStore _credentials;
  final SessionMemory _memory;

  @override
  Future<DeviceLockSnapshot> read() async {
    try {
      _memory.enrolled = _flags.enrolled;
      _memory.promptDeclined = _flags.promptDeclined;
      _memory.role = _flags.role;
      _memory.capability = await _capability.read();
      _memory.publish();
      return _snapshot();
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  @override
  Future<void> declinePrompt() async {
    try {
      await _flags.writeDeclined();
      _memory.promptDeclined = true;
      _memory.publish();
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  @override
  Future<void> protectWorkingSession() async {
    try {
      final access = await _credentials.readAccessToken();
      if (access == null || access.isEmpty) {
        throw const CacheException();
      }
      final refresh = await _credentials.readRefreshToken();
      await _bundle.write(
        BiometricBundle(
          accessToken: access,
          refreshToken: refresh == null || refresh.isEmpty ? null : refresh,
        ),
      );
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  @override
  Future<void> markEnrolled(AuthRole role) async {
    try {
      await _flags.writeEnrolled(role);
      _memory.enrolled = true;
      _memory.role = role;
      _memory.promptDeclined = false;
      _memory.publish();
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  @override
  Future<void> restoreWorkingSession() async {
    try {
      final bundle = await _bundle.read();
      await _credentials.writeAccessToken(bundle.accessToken);
      final refresh = bundle.refreshToken;
      if (refresh != null && refresh.isNotEmpty) {
        await _credentials.writeRefreshToken(refresh);
      }
      _memory.unlocked = true;
      _memory.publish();
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  @override
  Future<void> clearEnrollment() async {
    try {
      await _bundle.delete();
      await _flags.clearEnrolled();
      _memory.enrolled = false;
      _memory.publish();
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  DeviceLockSnapshot _snapshot() {
    return DeviceLockSnapshot(
      capability: _memory.capability,
      enrolled: _memory.enrolled,
      promptDeclined: _memory.promptDeclined,
      lastRole: _memory.role,
    );
  }
}
