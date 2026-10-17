import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The banner shown once an agent has captured more than one shop in a day.
class DailyMilestoneBanner extends StatelessWidget {
  const DailyMilestoneBanner({required this.shopsToday, super.key});

  final int shopsToday;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.infoContainer,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.info.withValues(alpha: 0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: AppDimensions.iconMd,
              color: colors.info,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                  children: [
                    TextSpan(
                      text: l10n.queuedDailyMilestone(shopsToday),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    TextSpan(text: ' '),
                    TextSpan(text: l10n.queuedDailyPending('₦15,000')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
