import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail_phase.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_stage_tone.dart';

class LesseeBookingDetailProgress extends StatelessWidget {
  const LesseeBookingDetailProgress({
    required this.tones,
    required this.phase,
    super.key,
  });

  final List<LesseeBookingStageTone> tones;
  final LesseeBookingDetailPhase phase;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final labels = [
      l10n.bookingsDetailStageBooked,
      l10n.bookingsDetailStageInUse,
      switch (phase) {
        LesseeBookingDetailPhase.completed =>
          l10n.bookingsDetailStageReturnedClosed,
        LesseeBookingDetailPhase.cancelled => l10n.bookingsCancelled,
        LesseeBookingDetailPhase.reviewPending =>
          l10n.bookingsDetailStageReturnedPending,
        LesseeBookingDetailPhase.inProgress => l10n.bookingsDetailStageInUse,
      },
    ];
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xxs),
        child: Column(
          children: [
            Row(
              children: [
                for (var i = 0; i < tones.length; i++) ...[
                  if (i > 0) const SizedBox(width: AppSpacing.xxs),
                  Expanded(child: _segment(context, tones[i])),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.tight),
            Row(
              children: [
                for (var i = 0; i < labels.length; i++)
                  Expanded(
                    child: Text(
                      tones[i] == LesseeBookingStageTone.complete
                          ? '✓ ${labels[i]}'
                          : labels[i],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: i == 0
                          ? TextAlign.start
                          : i == labels.length - 1
                          ? TextAlign.end
                          : TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: tones[i] == LesseeBookingStageTone.pending
                            ? colors.muted
                            : scheme.primary,
                        fontWeight: tones[i] == LesseeBookingStageTone.active
                            ? FontWeight.w700
                            : FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _segment(BuildContext context, LesseeBookingStageTone tone) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return switch (tone) {
      LesseeBookingStageTone.complete => DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(AppRadii.micro + 1),
        ),
        child: const SizedBox(height: AppDimensions.syncProgressHeight),
      ),
      LesseeBookingStageTone.active => DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadii.micro + 1),
          border: Border.all(
            color: scheme.primary,
            width: AppDimensions.focusBorderWidth,
          ),
        ),
        child: const SizedBox(height: AppDimensions.syncProgressHeight),
      ),
      LesseeBookingStageTone.pending => DecoratedBox(
        decoration: BoxDecoration(
          color: colors.border,
          borderRadius: BorderRadius.circular(AppRadii.micro + 1),
        ),
        child: const SizedBox(height: AppDimensions.syncProgressHeight),
      ),
    };
  }
}
