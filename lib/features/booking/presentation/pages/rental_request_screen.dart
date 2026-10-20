import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/rental_request_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_language_chip.dart';

class RentalRequestScreen extends StatelessWidget {
  const RentalRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<RentalRequestCubit, RentalRequestState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.rentalConfirmTitle),
            actions: const [DashboardLanguageChip()],
          ),
          body: switch (state) {
            RentalRequestLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            RentalRequestFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<RentalRequestCubit>().load(),
            ),
            RentalRequestMissing() => AppEmptyState(
              icon: Icons.search_off,
              title: l10n.marketplaceMissing,
            ),
            RentalRequestReady() => RentalRequestPage(state: state),
          },
        );
      },
    );
  }
}
