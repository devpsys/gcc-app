import 'package:flutter/foundation.dart';
import 'package:gcc_app/core/router/session_gate.dart';
import 'package:gcc_app/core/router/session_redirect_state.dart';

class FakeSessionGate implements SessionGate {
  FakeSessionGate({
    this.state = const SessionRedirectState(
      enrolled: false,
      unlocked: true,
      homeLocation: '/agent',
      signInLocation: '/auth/agent/sign-in',
    ),
  });

  @override
  SessionRedirectState state;

  final ChangeNotifier _changes = ChangeNotifier();

  @override
  Listenable get changes => _changes;
}
