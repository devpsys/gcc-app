import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/router/session_redirect_state.dart';

/// First location once cold start has filled [session].
String initialAuthLocation(SessionRedirectState session) {
  if (session.enrolled && !session.unlocked) {
    return RoutePaths.biometricUnlock;
  }
  if (session.unlocked) {
    return session.homeLocation ?? RoutePaths.authSignIn;
  }
  return RoutePaths.authSignIn;
}

/// Redirect for a real session.
///
/// A missing session leaves public auth routes alone and sends every other
/// path to sign-in. An enrolled device that has not unlocked this process
/// goes to the biometric screen, except the verification routes used to
/// recover. The verify route stays put while unlocked so biometric
/// enrollment can finish before navigation.
String? authRedirect({
  required SessionRedirectState session,
  required String location,
}) {
  final home = session.homeLocation ?? RoutePaths.authSignIn;
  final signIn = session.signInLocation ?? RoutePaths.authSignIn;

  if (_isOnboarding(location)) {
    if (session.unlocked) {
      return home;
    }
    return RoutePaths.authSignIn;
  }

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
    if (location == RoutePaths.authVerify ||
        location == RoutePaths.agentVerify) {
      return null;
    }
    return null;
  }

  if (_isPublic(location)) {
    return null;
  }
  return signIn;
}

bool _isOnboarding(String location) {
  return location == RoutePaths.onboardingLanguage ||
      location == RoutePaths.onboardingRole ||
      location == RoutePaths.onboardingSignIn;
}

bool _isRecovery(String location) {
  return location == RoutePaths.authSignIn ||
      location == RoutePaths.authVerify ||
      location == RoutePaths.agentSignIn ||
      location == RoutePaths.agentVerify;
}

bool _isPublic(String location) {
  return location == RoutePaths.authSignIn ||
      location == RoutePaths.authVerify ||
      location == RoutePaths.agentSignIn ||
      location == RoutePaths.agentVerify ||
      location == RoutePaths.biometricUnlock ||
      _isOnboarding(location);
}
