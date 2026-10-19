import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/features/auth/data/auth_role_paths.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_state.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_language_chip.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_profile_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_profile_state.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_profile_page.dart';
import 'package:go_router/go_router.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<VendorProfileCubit, VendorProfileState>(
      builder: (context, state) {
        final waiting = state is VendorProfileReady
            ? state.profile.requestsWaiting
            : 0;
        final shell = AppShell(
          title: l10n.dashboardProfile,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.vendorProfile,
          destinations: DashboardDestinations.vendor(
            l10n,
            requestsBadge: waiting,
          ),
          actions: const [DashboardLanguageChip()],
          child: switch (state) {
            VendorProfileLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            VendorProfileFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<VendorProfileCubit>().load(),
            ),
            VendorProfileReady(:final profile) => VendorProfilePage(
              profile: profile,
              onSwitchToLessee: () async {
                final moved = await context
                    .read<VendorProfileCubit>()
                    .switchToLessee();
                if (!context.mounted || !moved) {
                  return;
                }
                GoRouter.maybeOf(context)
                    ?.go(homeLocationForRole(AuthRole.lessee));
              },
              onCopyUssd: () async {
                await Clipboard.setData(ClipboardData(text: profile.ussd));
                if (!context.mounted) {
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.vendorProfileCopied(profile.ussd)),
                  ),
                );
              },
              onSignOut: () => context.read<DeviceLockCubit>().signOut(),
              onOpenNotifications: () =>
                  GoRouter.maybeOf(context)
                      ?.push(RoutePaths.vendorNotifications),
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
