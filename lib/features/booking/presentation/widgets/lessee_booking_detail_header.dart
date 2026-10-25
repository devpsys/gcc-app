import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail_phase.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_progress.dart';

class LesseeBookingDetailHeader extends StatelessWidget {
  const LesseeBookingDetailHeader({required this.detail, super.key});

  final LesseeBookingDetail detail;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _thumb(context),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs / 2),
                      Text(
                        detail.yardLine,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.muted,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      StatusChip(
                        label: detail.statusChipLabel,
                        tone: switch (detail.phase) {
                          LesseeBookingDetailPhase.completed =>
                            StatusTone.success,
                          LesseeBookingDetailPhase.reviewPending =>
                            StatusTone.warning,
                          LesseeBookingDetailPhase.inProgress =>
                            StatusTone.info,
                          LesseeBookingDetailPhase.cancelled =>
                            StatusTone.muted,
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            LesseeBookingDetailProgress(
              tones: detail.stageTones,
              phase: detail.phase,
            ),
          ],
        ),
      ),
    );
  }

  Widget _thumb(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.border),
      ),
      child: SizedBox(
        width: AppDimensions.skeletonThumb,
        height: AppDimensions.skeletonThumb,
        child: Center(
          child: Text(
            detail.mark ?? detail.reference,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
