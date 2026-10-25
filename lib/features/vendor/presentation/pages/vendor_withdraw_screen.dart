import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_language_chip.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_state.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_withdraw_page.dart';
import 'package:go_router/go_router.dart';

class VendorWithdrawScreen extends StatelessWidget {
  const VendorWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<VendorWithdrawCubit, VendorWithdrawState>(
      builder: (context, state) {
        final ready = state is VendorWithdrawReady ? state : null;
        final waiting = ready?.wallet.requestsWaiting ?? 0;
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              return;
            }
            final sent = ready?.receipt != null;
            context.pop(sent ? ready?.wallet : null);
          },
          child: AppShell(
            title: ready?.receipt == null
                ? l10n.vendorWithdrawTitle
                : l10n.vendorWithdrawStatus,
            menuLabel: l10n.openNavigationMenu,
            selectedLocation: RoutePaths.vendorWallet,
            navigationStyle: ShellNavigationStyle.topTabs,
            destinations: DashboardDestinations.vendor(
              l10n,
              requestsBadge: waiting,
            ),
            actions: const [DashboardLanguageChip()],
            child: switch (state) {
              VendorWithdrawLoading() => const Center(
                child: AppLoadingIndicator(),
              ),
              VendorWithdrawFailed() => AppEmptyState(
                icon: Icons.cloud_off,
                title: l10n.dashboardLoadFailed,
                actionLabel: l10n.dashboardRetry,
                onAction: () => context.read<VendorWithdrawCubit>().load(),
              ),
              VendorWithdrawReady() => VendorWithdrawPage(
                state: state,
                onCancel: () => context.pop(),
                onDone: () => context.pop(state.wallet),
              ),
            },
          ),
        );
      },
    );
  }
}
