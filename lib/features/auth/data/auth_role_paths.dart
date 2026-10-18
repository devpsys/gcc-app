import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';

String homeLocationForRole(AuthRole role) {
  return switch (role) {
    AuthRole.agent => RoutePaths.agentToday,
    AuthRole.lessee => '${RoutePaths.home}?role=lessee',
    AuthRole.vendor => '${RoutePaths.home}?role=vendor',
  };
}

String signInLocationForRole(AuthRole role) {
  return switch (role) {
    AuthRole.agent => RoutePaths.agentSignIn,
    AuthRole.lessee || AuthRole.vendor => RoutePaths.onboardingSignIn,
  };
}
