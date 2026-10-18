import 'package:flutter/foundation.dart';
import 'package:gcc_app/core/router/session_redirect_state.dart';

/// In-memory session view the router refreshes from.
///
/// Implementations live in the auth feature. Core only sees this contract.
abstract interface class SessionGate {
  SessionRedirectState get state;

  Listenable get changes;
}
