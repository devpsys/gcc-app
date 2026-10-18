import 'package:gcc_app/features/auth/data/hive_device_lock_flag_store.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';

/// Device-lock flags for tests. Production keeps them in Hive.
class MemoryDeviceLockFlagStore implements DeviceLockFlagStore {
  bool _enrolled = false;
  bool _promptDeclined = false;
  AuthRole? _role;

  @override
  bool get enrolled => _enrolled;

  @override
  bool get promptDeclined => _promptDeclined;

  @override
  AuthRole? get role => _role;

  @override
  Future<void> writeEnrolled(AuthRole role) async {
    _enrolled = true;
    _role = role;
    _promptDeclined = false;
  }

  @override
  Future<void> writeDeclined() async {
    _promptDeclined = true;
  }

  @override
  Future<void> writeRole(AuthRole role) async {
    _role = role;
  }

  @override
  Future<void> clearEnrolled() async {
    _enrolled = false;
  }
}
