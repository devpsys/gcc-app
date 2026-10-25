import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/master_detail_split.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_booking_detail_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_bookings_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_bookings_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_bookings_page.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_pane.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_language_chip.dart';
import 'package:go_router/go_router.dart';

class LesseeBookingsScreen extends StatefulWidget {
  const LesseeBookingsScreen({super.key});

  @override
  State<LesseeBookingsScreen> createState() => _LesseeBookingsScreenState();
}

class _LesseeBookingsScreenState extends State<LesseeBookingsScreen> {
  String? _selectedId;

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
        if (state is LesseeBookingsReady &&
            _selectedId != null &&
            state.bookings.every((item) => item.id != _selectedId)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _selectedId = null);
            }
          });
        }
        return AppShell(
          title: l10n.dashboardBookings,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.bookings,
          navigationStyle: ShellNavigationStyle.topTabs,
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
            LesseeBookingsReady() => MasterDetailSplit(
              master: LesseeBookingsPage(
                state: state,
                selectedId: _selectedId,
                onTab: context.read<LesseeBookingsCubit>().setTab,
                onFilter: context.read<LesseeBookingsCubit>().setFilter,
                onOpen: (id) => _openBooking(context, id),
              ),
              detail: _detail(context),
            ),
          },
        );
      },
    );
  }

  Widget _detail(BuildContext context) {
    final l10n = context.l10n;
    final id = _selectedId;
    if (id == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            l10n.bookingsTabletSelectBooking,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.semanticColors.muted,
            ),
          ),
        ),
      );
    }
    return BlocProvider(
      key: ValueKey(id),
      create: (_) => getIt<LesseeBookingDetailCubit>(param1: id)..load(),
      child: const LesseeBookingDetailPane(),
    );
  }

  void _openBooking(BuildContext context, String id) {
    final width = MediaQuery.sizeOf(context).width;
    if (AppBreakpoints.isTablet(width)) {
      setState(() => _selectedId = id);
      return;
    }
    GoRouter.maybeOf(context)?.push(RoutePaths.bookingDetailOf(id));
  }
}
