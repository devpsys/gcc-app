import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/auth/data/auth_role_paths.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_state.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_profile_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_profile_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_profile_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:go_router/go_router.dart';

class LesseeProfileScreen extends StatelessWidget {
  const LesseeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LesseeProfileCubit, LesseeProfileState>(
      builder: (context, state) {
        final shell = AppShell(
          title: l10n.dashboardProfile,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.profile,
          navigationStyle: ShellNavigationStyle.topTabs,
          showAppBar: false,
          destinations: DashboardDestinations.lessee(l10n),
          child: switch (state) {
            LesseeProfileLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            LesseeProfileFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<LesseeProfileCubit>().load(),
            ),
            LesseeProfileReady(:final profile) => LesseeProfilePage(
              profile: profile,
              onSwitchToVendor: () async {
                final moved = await context
                    .read<LesseeProfileCubit>()
                    .switchToVendor();
                if (!context.mounted || !moved) {
                  return;
                }
                GoRouter.maybeOf(context)
                    ?.go(homeLocationForRole(AuthRole.vendor));
              },
              onSignOut: () => context.read<DeviceLockCubit>().signOut(),
              onOpenBookings: () =>
                  GoRouter.maybeOf(context)?.go(RoutePaths.bookings),
              onInstall: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.dashboardActionUnavailable)),
                );
              },
              onCallSupport: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.dashboardActionUnavailable)),
                );
              },
              onOpenNotifications: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.dashboardActionUnavailable)),
                );
              },
            ),
          },
        );
        final lock = _lockOf(context);
        if (lock == null) {
          return shell;
        }
        return BlocListener<DeviceLockCubit, DeviceLockState>(
          bloc: lock,
          listenWhen: (previous, current) => current is DeviceLockRevoked,
          listener: (context, state) {
            if (state is! DeviceLockRevoked) {
              return;
            }
            GoRouter.maybeOf(context)?.go(state.signInLocation);
          },
          child: shell,
        );
      },
    );
  }

  DeviceLockCubit? _lockOf(BuildContext context) {
    try {
      return context.read<DeviceLockCubit>();
    } on ProviderNotFoundException {
      return null;
    }
  }
}
