import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/route_names.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/route_error_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_assets_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_camera_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_location_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_review_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_shop_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/compression_route_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/submission_queued_page.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shops_cubit.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/assigned_shops_screen.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cubit.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/field_map_loader.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_queue_cubit.dart';
import 'package:gcc_app/features/agent_sync/presentation/pages/queue_item_route_page.dart';
import 'package:gcc_app/features/agent_sync/presentation/pages/sync_queue_screen.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_cubit.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/agent_profile_screen.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/agent_wallet_screen.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_status_screen.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/notification_channels_screen.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_otp_page.dart';
import 'package:gcc_app/features/auth/presentation/pages/agent_sign_in_page.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/agent_today_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_role_switcher.dart';
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
      ShellRoute(
        builder: (context, state, child) {
          final role = DashboardRole.fromQuery(
            state.uri.queryParameters['role'],
          );
          return BlocProvider(
            create: (_) => getIt<DashboardCubit>(param1: role)..load(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RoutePaths.home,
            name: RouteNames.home,
            builder: (context, state) => const DashboardRoleSwitcher(),
          ),
          GoRoute(
            path: RoutePaths.settings,
            name: RouteNames.settings,
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => getIt<CaptureCubit>(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RoutePaths.captureShop,
            name: RouteNames.captureShop,
            builder: (context, state) => const CaptureShopPage(),
          ),
          GoRoute(
            path: RoutePaths.captureLocation,
            name: RouteNames.captureLocation,
            builder: (context, state) => const CaptureLocationPage(),
          ),
          GoRoute(
            path: RoutePaths.captureAssets,
            name: RouteNames.captureAssets,
            builder: (context, state) => const CaptureAssetsPage(),
          ),
          GoRoute(
            path: RoutePaths.captureMedia,
            name: RouteNames.captureMedia,
            builder: (context, state) => const CaptureCameraPage(),
          ),
          GoRoute(
            path: RoutePaths.captureCompress,
            name: RouteNames.captureCompress,
            builder: (context, state) => const CompressionRoutePage(),
          ),
          GoRoute(
            path: RoutePaths.captureReview,
            name: RouteNames.captureReview,
            builder: (context, state) => const CaptureReviewPage(),
          ),
          GoRoute(
            path: RoutePaths.captureDone,
            name: RouteNames.captureDone,
            builder: (context, state) => const SubmissionQueuedPage(),
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.agentWallet,
        name: RouteNames.agentWallet,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<WalletCubit>()..loadOverview(),
          child: const AgentWalletScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.agentProfile,
        name: RouteNames.agentProfile,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<WalletCubit>()..loadProfile(),
          child: const AgentProfileScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.agentBountyStatus,
        name: RouteNames.agentBountyStatus,
        builder: (context, state) {
          final reference = state.pathParameters['reference'] ?? '';
          return BlocProvider(
            create: (_) => getIt<WalletCubit>()..loadBounty(reference),
            child: BountyStatusScreen(reference: reference),
          );
        },
      ),
      GoRoute(
        path: RoutePaths.agentNotifications,
        name: RouteNames.agentNotifications,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<WalletCubit>()..loadChannels(),
          child: const NotificationChannelsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.agentMap,
        name: RouteNames.agentMap,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<MapCubit>()..load(),
          child: const FieldMapLoader(),
        ),
      ),
      GoRoute(
        path: RoutePaths.agentShops,
        name: RouteNames.agentShops,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AssignedShopsCubit>()..load(),
          child: const AssignedShopsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.agentQueue,
        name: RouteNames.agentQueue,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SyncQueueCubit>()..load(),
          child: const SyncQueueScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.agentQueueItem,
        name: RouteNames.agentQueueItem,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SyncQueueCubit>()..load(),
          child: QueueItemRoutePage(
            reference: state.pathParameters['reference'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: RoutePaths.agentToday,
        name: RouteNames.agentToday,
        builder: (context, state) {
          return BlocProvider(
            create: (_) =>
                getIt<DashboardCubit>(param1: DashboardRole.agent)..load(),
            child: const AgentTodayPage(),
          );
        },
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
