import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/router/auth_redirect.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/router/session_redirect_state.dart';

void main() {
  const signedOut = SessionRedirectState(enrolled: false, unlocked: false);
  const unlocked = SessionRedirectState(
    enrolled: false,
    unlocked: true,
    homeLocation: RoutePaths.agentToday,
    signInLocation: RoutePaths.agentSignIn,
  );
  const locked = SessionRedirectState(
    enrolled: true,
    unlocked: false,
    homeLocation: RoutePaths.agentToday,
    signInLocation: RoutePaths.agentSignIn,
  );

  test('a signed-out person can stay on public routes', () {
    expect(
      authRedirect(session: signedOut, location: RoutePaths.onboardingLanguage),
      isNull,
    );
    expect(
      authRedirect(session: signedOut, location: RoutePaths.agentToday),
      RoutePaths.onboardingLanguage,
    );
  });

  test('a known role returns to that sign-in', () {
    expect(
      authRedirect(
        session: const SessionRedirectState(
          enrolled: false,
          unlocked: false,
          signInLocation: RoutePaths.agentSignIn,
        ),
        location: RoutePaths.agentWallet,
      ),
      RoutePaths.agentSignIn,
    );
  });

  test('an enrolled locked device opens the unlock screen', () {
    expect(
      authRedirect(session: locked, location: RoutePaths.agentToday),
      RoutePaths.biometricUnlock,
    );
    expect(
      authRedirect(session: locked, location: RoutePaths.biometricUnlock),
      isNull,
    );
    expect(
      authRedirect(session: locked, location: RoutePaths.agentSignIn),
      isNull,
    );
  });

  test('an unlocked session leaves the verification page in place', () {
    expect(
      authRedirect(session: unlocked, location: RoutePaths.agentVerify),
      isNull,
    );
    expect(
      authRedirect(session: unlocked, location: RoutePaths.biometricUnlock),
      RoutePaths.agentToday,
    );
    expect(
      authRedirect(session: unlocked, location: RoutePaths.agentToday),
      isNull,
    );
  });

  test('cold start picks unlock, home, or onboarding', () {
    expect(initialAuthLocation(locked), RoutePaths.biometricUnlock);
    expect(initialAuthLocation(unlocked), RoutePaths.agentToday);
    expect(initialAuthLocation(signedOut), RoutePaths.onboardingLanguage);
  });
}
