import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_booking_detail_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_booking_detail_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_booking_detail_page.dart';

/// Booking detail body for phone pages and tablet master-detail panes.
class LesseeBookingDetailPane extends StatelessWidget {
  const LesseeBookingDetailPane({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LesseeBookingDetailCubit, LesseeBookingDetailState>(
      builder: (context, state) {
        return switch (state) {
          LesseeBookingDetailLoading() => const Center(
            child: AppLoadingIndicator(),
          ),
          LesseeBookingDetailFailed() => AppEmptyState(
            icon: Icons.cloud_off,
            title: l10n.dashboardLoadFailed,
            actionLabel: l10n.dashboardRetry,
            onAction: () => context.read<LesseeBookingDetailCubit>().load(),
          ),
          LesseeBookingDetailMissing() => AppEmptyState(
            icon: Icons.search_off,
            title: l10n.bookingsDetailMissing,
          ),
          LesseeBookingDetailReady(:final detail) =>
            LesseeBookingDetailPage(detail: detail),
        };
      },
    );
  }
}
