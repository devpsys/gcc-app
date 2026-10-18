import 'package:gcc_app/core/constants/storage_keys.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:hive/hive.dart';

abstract interface class DeviceLockFlagStore {
  bool get enrolled;

  bool get promptDeclined;

  AuthRole? get role;

  Future<void> writeEnrolled(AuthRole role);

  Future<void> writeDeclined();

  Future<void> writeRole(AuthRole role);

  Future<void> clearEnrolled();
}

final class HiveDeviceLockFlagStore implements DeviceLockFlagStore {
  HiveDeviceLockFlagStore(this._box);

  final Box<String> _box;

  @override
  bool get enrolled => _read(StorageKeys.deviceLockEnrolled) == 'true';

  @override
  bool get promptDeclined =>
      _read(StorageKeys.deviceLockPromptDeclined) == 'true';

  @override
  AuthRole? get role => authRoleFromStorage(_read(StorageKeys.deviceLockRole));

  @override
  Future<void> writeEnrolled(AuthRole role) async {
    await _put(StorageKeys.deviceLockEnrolled, 'true');
    await _put(StorageKeys.deviceLockRole, role.name);
    await _delete(StorageKeys.deviceLockPromptDeclined);
  }

  @override
  Future<void> writeDeclined() {
    return _put(StorageKeys.deviceLockPromptDeclined, 'true');
  }

  @override
  Future<void> writeRole(AuthRole role) {
    return _put(StorageKeys.deviceLockRole, role.name);
  }

  @override
  Future<void> clearEnrolled() {
    return _delete(StorageKeys.deviceLockEnrolled);
  }

  String? _read(String key) {
    try {
      return _box.get(key);
    } catch (error) {
      throw CacheException(error);
    }
  }

  Future<void> _put(String key, String value) async {
    try {
      await _box.put(key, value);
    } catch (error) {
      throw CacheException(error);
    }
  }

  Future<void> _delete(String key) async {
    try {
      await _box.delete(key);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
