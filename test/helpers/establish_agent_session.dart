import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';

/// Gives router tests a working agent session so protected routes stay open.
Future<void> establishAgentSession() {
  return getIt<SessionRepository>().establish(AuthRole.agent);
}
