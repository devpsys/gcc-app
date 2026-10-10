import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/route_names.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/route_error_page.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_otp_page.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_sign_in_page.dart';
import 'package:gcc_app/features/home/presentation/pages/home_page.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_language_page.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_role_page.dart';
import 'package:gcc_app/features/onboarding/presentation/pages/onboarding_sign_in_page.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: RoutePaths.onboardingLanguage,
    errorBuilder: (context, state) => const RouteErrorPage(),
    routes: [
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => getIt<OnboardingCubit>(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RoutePaths.onboardingLanguage,
            name: RouteNames.onboardingLanguage,
            builder: (context, state) => const OnboardingLanguagePage(),
          ),
          GoRoute(
            path: RoutePaths.onboardingRole,
            name: RouteNames.onboardingRole,
            builder: (context, state) => const OnboardingRolePage(),
          ),
          GoRoute(
            path: RoutePaths.onboardingSignIn,
            name: RouteNames.onboardingSignIn,
            builder: (context, state) => const OnboardingSignInPage(),
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => getIt<AgentAuthCubit>(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RoutePaths.agentSignIn,
            name: RouteNames.agentSignIn,
            builder: (context, state) => const AgentSignInPage(),
          ),
          GoRoute(
            path: RoutePaths.agentVerify,
            name: RouteNames.agentVerify,
            builder: (context, state) => const AgentOtpPage(),
          ),
        ],
      ),
    ],
  );
}
