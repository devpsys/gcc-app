import 'package:flutter/foundation.dart';
import 'package:gcc_app/core/router/session_gate.dart';
import 'package:gcc_app/core/router/session_redirect_state.dart';
import 'package:gcc_app/features/auth/data/auth_role_paths.dart';
import 'package:gcc_app/features/auth/data/session_memory.dart';

final class AuthSessionGate implements SessionGate {
  AuthSessionGate(this._memory);

  final SessionMemory _memory;

  @override
  Listenable get changes => _memory;

  @override
  SessionRedirectState get state {
    final role = _memory.role;
    return SessionRedirectState(
      enrolled: _memory.enrolled,
      unlocked: _memory.unlocked,
      homeLocation: role == null ? null : homeLocationForRole(role),
      signInLocation: role == null ? null : signInLocationForRole(role),
    );
  }
}
