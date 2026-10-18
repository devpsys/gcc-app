import 'dart:math';

import 'package:gcc_app/core/error/exception_mapper.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/storage/secure_credential_store.dart';
import 'package:gcc_app/features/auth/data/biometric_capability_reader.dart';
import 'package:gcc_app/features/auth/data/hive_device_lock_flag_store.dart';
import 'package:gcc_app/features/auth/data/session_memory.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/features/auth/domain/session_snapshot.dart';

final class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl({
    required this._credentials,
    required this._flags,
    required this._capability,
    required this._memory,
    Random? random,
  }) : _random = random ?? Random.secure();

  final SecureCredentialStore _credentials;
  final DeviceLockFlagStore _flags;
  final BiometricCapabilityReader _capability;
  final SessionMemory _memory;
  final Random _random;

  @override
  SessionSnapshot get current =>
      SessionSnapshot(unlocked: _memory.unlocked, role: _memory.role);

  @override
  Future<void> prepareColdStart() async {
    try {
      _memory.enrolled = _flags.enrolled;
      _memory.promptDeclined = _flags.promptDeclined;
      _memory.role = _flags.role;
      _memory.capability = await _capability.read();
      if (_memory.enrolled) {
        await _credentials.clear();
        _memory.unlocked = false;
      } else {
        final token = await _credentials.readAccessToken();
        _memory.unlocked = token != null && token.isNotEmpty;
      }
      _memory.publish();
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  @override
  Future<void> establish(AuthRole role) async {
    try {
      await _credentials.writeAccessToken(_marker());
      await _flags.writeRole(role);
      _memory.role = role;
      _memory.unlocked = true;
      _memory.publish();
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  @override
  Future<void> clearWorkingSet() async {
    try {
      await _credentials.clear();
      _memory.unlocked = false;
      _memory.publish();
    } on AppException catch (error) {
      throw toFailure(error);
    }
  }

  String _marker() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    final hex = bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
    return 'local.$hex';
  }
}
