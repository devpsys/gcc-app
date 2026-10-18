import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_snapshot.dart';

abstract interface class SessionRepository {
  SessionSnapshot get current;

  /// Drops the working tokens when this device is enrolled, so a killed
  /// process cannot keep calling the API without a biometric read.
  Future<void> prepareColdStart();

  /// Records a session created by OTP. The unwired client stores a local
  /// marker. A later API writes the server tokens through the same method.
  Future<void> establish(AuthRole role);

  Future<void> clearWorkingSet();
}
