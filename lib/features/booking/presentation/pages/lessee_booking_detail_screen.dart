import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_booking_detail_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_booking_detail_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_pane.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_language_chip.dart';
import 'package:go_router/go_router.dart';

class LesseeBookingDetailScreen extends StatelessWidget {
  const LesseeBookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LesseeBookingDetailCubit, LesseeBookingDetailState>(
      builder: (context, state) {
        final title = switch (state) {
          LesseeBookingDetailReady(:final detail) => detail.reference,
          _ => l10n.dashboardBookings,
        };
        return AppShell(
          title: title,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.bookings,
          navigationStyle: ShellNavigationStyle.topTabs,
          destinations: DashboardDestinations.lessee(l10n),
          leading: BackButton(
            onPressed: () {
              final router = GoRouter.maybeOf(context);
              if (router?.canPop() ?? false) {
                router?.pop();
              } else {
                router?.go(RoutePaths.bookings);
              }
            },
          ),
          actions: const [DashboardLanguageChip()],
          child: const LesseeBookingDetailPane(),
        );
      },
    );
  }
}
