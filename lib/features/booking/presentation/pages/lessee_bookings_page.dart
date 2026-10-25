import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_segment_option.dart';
import 'package:gcc_app/core/widgets/app_segment_style.dart';
import 'package:gcc_app/core/widgets/app_segmented_control.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_filters.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_bookings_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_bookings_filter_chip.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

class LesseeBookingsPage extends StatelessWidget {
  const LesseeBookingsPage({
    required this.state,
    required this.onTab,
    required this.onFilter,
    super.key,
  });

  final LesseeBookingsReady state;
  final ValueChanged<LesseeBookingTab> onTab;
  final ValueChanged<LesseeBookingFilter> onFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final visible = filterLesseeBookings(
      bookings: state.bookings,
      tab: state.tab,
      filter: state.filter,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.xs,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSegmentedControl<LesseeBookingTab>(
                style: AppSegmentStyle.filled,
                selected: state.tab,
                onChanged: onTab,
                options: [
                  AppSegmentOption(
                    value: LesseeBookingTab.active,
                    label: l10n.bookingsTabActive(state.activeCount),
                  ),
                  AppSegmentOption(
                    value: LesseeBookingTab.completed,
                    label: l10n.bookingsTabCompleted(state.completedCount),
                  ),
                  AppSegmentOption(
                    value: LesseeBookingTab.cancelled,
                    label: l10n.bookingsTabCancelled(state.cancelledCount),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs + AppSpacing.xxs / 2),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final filter in _filtersFor(state.tab)) ...[
                      LesseeBookingsFilterChip(
                        label: _filterLabel(l10n, state, filter),
                        count: filter == LesseeBookingFilter.needsAction
                            ? state.needsActionCount
                            : null,
                        selected: state.filter == filter,
                        onSelected: (_) => onFilter(filter),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: visible.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      l10n.bookingsEmpty,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              : ListView.separated(
                  key: const Key('lessee-bookings-body'),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.xs,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  itemCount:
                      visible.length +
                      (state.tab == LesseeBookingTab.cancelled ? 1 : 0),
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    if (state.tab == LesseeBookingTab.cancelled &&
                        index == visible.length) {
                      return Text(
                        l10n.bookingsCancelledRetention,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: context.semanticColors.muted),
                      );
                    }
                    return LesseeBookingCard(booking: visible[index]);
                  },
                ),
        ),
      ],
    );
  }

  List<LesseeBookingFilter> _filtersFor(LesseeBookingTab tab) {
    return switch (tab) {
      LesseeBookingTab.active => const [
        LesseeBookingFilter.needsAction,
        LesseeBookingFilter.all,
      ],
      LesseeBookingTab.completed => const [
        LesseeBookingFilter.all,
        LesseeBookingFilter.generators,
        LesseeBookingFilter.audio,
      ],
      LesseeBookingTab.cancelled => const [
        LesseeBookingFilter.recentCancelled,
        LesseeBookingFilter.archivedCancelled,
      ],
    };
  }

  String _filterLabel(
    AppLocalizations l10n,
    LesseeBookingsReady state,
    LesseeBookingFilter filter,
  ) {
    return switch (filter) {
      LesseeBookingFilter.needsAction => l10n.bookingsFilterNeedsAction,
      LesseeBookingFilter.all => switch (state.tab) {
        LesseeBookingTab.active => l10n.bookingsFilterAll,
        LesseeBookingTab.completed => l10n.bookingsFilterAllCompleted(
          state.completedCount,
        ),
        LesseeBookingTab.cancelled => l10n.bookingsFilterAll,
      },
      LesseeBookingFilter.generators => l10n.bookingsFilterGenerators,
      LesseeBookingFilter.audio => l10n.bookingsFilterAudio,
      LesseeBookingFilter.recentCancelled => l10n.bookingsFilterRecent,
      LesseeBookingFilter.archivedCancelled => l10n.bookingsFilterArchived,
    };
  }
}
