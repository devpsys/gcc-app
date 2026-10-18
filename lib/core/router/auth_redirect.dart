import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/router/session_redirect_state.dart';

/// First location once cold start has filled [session].
String initialAuthLocation(SessionRedirectState session) {
  if (session.enrolled && !session.unlocked) {
    return RoutePaths.biometricUnlock;
  }
  if (session.unlocked) {
    return session.homeLocation ?? RoutePaths.onboardingLanguage;
  }
  return RoutePaths.onboardingLanguage;
}

/// Redirect for a real session.
///
/// A missing session leaves public auth routes alone and sends every other
/// path to sign-in. An enrolled device that has not unlocked this process
/// goes to the biometric screen, except the verification routes used to
/// recover. The agent verification route stays put while unlocked so the
/// enrollment sheet can finish before navigation.
String? authRedirect({
  required SessionRedirectState session,
  required String location,
}) {
  final home = session.homeLocation ?? RoutePaths.onboardingLanguage;
  final signIn = session.signInLocation ?? RoutePaths.onboardingLanguage;

  if (session.enrolled && !session.unlocked) {
    if (location == RoutePaths.biometricUnlock || _isRecovery(location)) {
      return null;
    }
    return RoutePaths.biometricUnlock;
  }

  if (session.unlocked) {
    if (location == RoutePaths.biometricUnlock) {
      return home;
    }
    if (location == RoutePaths.agentVerify) {
      return null;
    }
    if (location == RoutePaths.onboardingLanguage ||
        location == RoutePaths.onboardingRole) {
      return home;
    }
    return null;
  }

  if (_isPublic(location)) {
    return null;
  }
  return signIn;
}

bool _isRecovery(String location) {
  return location == RoutePaths.agentSignIn ||
      location == RoutePaths.agentVerify ||
      location == RoutePaths.onboardingSignIn;
}

bool _isPublic(String location) {
  return location == RoutePaths.onboardingLanguage ||
      location == RoutePaths.onboardingRole ||
      location == RoutePaths.onboardingSignIn ||
      location == RoutePaths.agentSignIn ||
      location == RoutePaths.agentVerify ||
      location == RoutePaths.biometricUnlock;
}
