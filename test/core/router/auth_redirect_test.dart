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
    signInLocation: RoutePaths.authSignIn,
  );
  const locked = SessionRedirectState(
    enrolled: true,
    unlocked: false,
    homeLocation: RoutePaths.agentToday,
    signInLocation: RoutePaths.authSignIn,
  );

  test('a signed-out person can stay on public auth routes', () {
    expect(
      authRedirect(session: signedOut, location: RoutePaths.authSignIn),
      isNull,
    );
    expect(
      authRedirect(session: signedOut, location: RoutePaths.onboardingLanguage),
      RoutePaths.authSignIn,
    );
    expect(
      authRedirect(session: signedOut, location: RoutePaths.agentToday),
      RoutePaths.authSignIn,
    );
    expect(
      authRedirect(session: signedOut, location: RoutePaths.home),
      RoutePaths.authSignIn,
    );
  });

  test('an unlocked vendor can stay on home', () {
    expect(
      authRedirect(
        session: const SessionRedirectState(
          enrolled: false,
          unlocked: true,
          homeLocation: '/?role=vendor',
          signInLocation: RoutePaths.authSignIn,
        ),
        location: RoutePaths.home,
      ),
      isNull,
    );
  });

  test('a known role returns to that sign-in', () {
    expect(
      authRedirect(
        session: const SessionRedirectState(
          enrolled: false,
          unlocked: false,
          signInLocation: RoutePaths.authSignIn,
        ),
        location: RoutePaths.agentWallet,
      ),
      RoutePaths.authSignIn,
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
      authRedirect(session: locked, location: RoutePaths.authSignIn),
      isNull,
    );
  });

  test('an unlocked session leaves the verification page in place', () {
    expect(
      authRedirect(session: unlocked, location: RoutePaths.authVerify),
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

  test('cold start picks unlock, home, or unified sign-in', () {
    expect(initialAuthLocation(locked), RoutePaths.biometricUnlock);
    expect(initialAuthLocation(unlocked), RoutePaths.agentToday);
    expect(initialAuthLocation(signedOut), RoutePaths.authSignIn);
  });
}
