import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/features/auth/domain/session_snapshot.dart';

class FakeSessionRepository implements SessionRepository {
  FakeSessionRepository({
    this.current = const SessionSnapshot(unlocked: false),
  });
  Failure? establishFailure;
  int establishCount = 0;
  int clearCount = 0;
  AuthRole? establishedRole;

  @override
  SessionSnapshot current;

  @override
  Future<void> prepareColdStart() async {}

  @override
  Future<void> establish(AuthRole role) async {
    establishCount += 1;
    establishedRole = role;
    final failure = establishFailure;
    if (failure != null) {
      throw failure;
    }
    current = SessionSnapshot(unlocked: true, role: role);
  }

  @override
  Future<void> clearWorkingSet() async {
    clearCount += 1;
    current = SessionSnapshot(unlocked: false, role: current.role);
  }
}
