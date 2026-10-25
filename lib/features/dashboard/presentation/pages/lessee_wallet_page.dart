import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:go_router/go_router.dart';

/// Lessee wallet stub — deposits and refunds surface here after handback.
class LesseeWalletPage extends StatelessWidget {
  const LesseeWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return AppShell(
      title: l10n.dashboardWallet,
      menuLabel: l10n.openNavigationMenu,
      selectedLocation: RoutePaths.wallet,
      navigationStyle: ShellNavigationStyle.topTabs,
      destinations: DashboardDestinations.lessee(l10n),
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.lesseeWalletTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.lesseeWalletBody,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppPrimaryButton(
            label: l10n.dashboardBookings,
            onPressed: () =>
                GoRouter.maybeOf(context)?.go(RoutePaths.bookings),
          ),
        ],
      ),
    );
  }
}
