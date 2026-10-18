import 'package:flutter/foundation.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';

/// Shared enrollment and unlock flags. Notifies the router when they change.
class SessionMemory extends ChangeNotifier {
  bool enrolled = false;
  bool unlocked = false;
  AuthRole? role;
  bool promptDeclined = false;
  BiometricCapability capability = const BiometricUnavailable(
    BiometricUnavailableReason.unsupported,
  );

  String _published = '';

  void publish() {
    final next =
        '$enrolled|$unlocked|${role?.name}|$promptDeclined|'
        '${capability.runtimeType}|${_capabilityDetail()}';
    if (next == _published) {
      return;
    }
    _published = next;
    notifyListeners();
  }

  String _capabilityDetail() {
    final current = capability;
    return switch (current) {
      BiometricAvailable(:final method) => method.name,
      BiometricUnavailable(:final reason) => reason.name,
    };
  }
}
