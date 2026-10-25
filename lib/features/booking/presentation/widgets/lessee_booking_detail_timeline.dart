import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_stage_tone.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_timeline_event.dart';

class LesseeBookingDetailTimeline extends StatelessWidget {
  const LesseeBookingDetailTimeline({required this.events, super.key});

  final List<LesseeBookingTimelineEvent> events;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.bookingsDetailAuditEyebrow.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.muted,
            fontWeight: FontWeight.w600,
            letterSpacing: AppTextStyles.eyebrowLetterSpacing,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
            ),
            child: Column(
              children: [
                for (var i = 0; i < events.length; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.md),
                  _eventRow(
                    context,
                    event: events[i],
                    showLine: i < events.length - 1,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _eventRow(
    BuildContext context, {
    required LesseeBookingTimelineEvent event,
    required bool showLine,
  }) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSpacing.lg,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (showLine)
                  Positioned(
                    top: AppSpacing.lg,
                    bottom: -AppSpacing.md,
                    child: ColoredBox(
                      color: colors.border,
                      child: const SizedBox(width: AppDimensions.borderWidth),
                    ),
                  ),
                _marker(context, event.tone),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs + AppSpacing.xxs / 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppSpacing.tight,
                  children: [
                    Text(
                      event.timeLabel,
                      style: AppTextStyles.tabular(
                        Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: colors.muted,
                        ),
                      ),
                    ),
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (event.detail != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xxs / 2),
                    child: Text(
                      event.detail!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: event.detailHighlight
                            ? colors.warning
                            : scheme.onSurfaceVariant,
                        fontWeight: event.detailHighlight
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _marker(BuildContext context, LesseeBookingStageTone tone) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    const size = 14.0;
    return switch (tone) {
      LesseeBookingStageTone.complete => DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primary,
          shape: BoxShape.circle,
        ),
        child: const SizedBox(width: size, height: size),
      ),
      LesseeBookingStageTone.active => DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.25),
              spreadRadius: 3,
            ),
          ],
        ),
        child: const SizedBox(width: size, height: size),
      ),
      LesseeBookingStageTone.pending => DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: colors.border,
            width: AppDimensions.focusBorderWidth,
          ),
        ),
        child: const SizedBox(width: size, height: size),
      ),
    };
  }
}
