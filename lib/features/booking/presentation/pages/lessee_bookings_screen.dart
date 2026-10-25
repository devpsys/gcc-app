import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_bookings_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_bookings_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_bookings_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_language_chip.dart';

class LesseeBookingsScreen extends StatelessWidget {
  const LesseeBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LesseeBookingsCubit, LesseeBookingsState>(
      builder: (context, state) {
        final badge = switch (state) {
          LesseeBookingsReady(:final needsActionCount) => needsActionCount,
          _ => 0,
        };
        final activeBadge = switch (state) {
          LesseeBookingsReady(:final activeCount) => activeCount,
          _ => 0,
        };
        return AppShell(
          title: l10n.dashboardBookings,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.bookings,
          destinations: DashboardDestinations.lessee(
            l10n,
            bookingsBadge: activeBadge > 0 ? activeBadge : badge,
          ),
          actions: const [DashboardLanguageChip()],
          child: switch (state) {
            LesseeBookingsLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            LesseeBookingsFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<LesseeBookingsCubit>().load(),
            ),
            LesseeBookingsReady() => LesseeBookingsPage(
              state: state,
              onTab: context.read<LesseeBookingsCubit>().setTab,
              onFilter: context.read<LesseeBookingsCubit>().setFilter,
            ),
          },
        );
      },
    );
  }
}
