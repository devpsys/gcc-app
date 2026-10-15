import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class DailyProgressPanel extends StatelessWidget {
  const DailyProgressPanel({
    required this.assigned,
    required this.captured,
    required this.target,
    required this.pendingBounty,
    super.key,
  });

  final int assigned;
  final int captured;
  final int target;
  final String? pendingBounty;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (target == 0) {
      return Text(l10n.dashboardNoProgress);
    }
    final scheme = Theme.of(context).colorScheme;
    final bounty = pendingBounty;
    final progress = (captured / target).clamp(0, 1).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.dashboardTodayAtAGlance,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              l10n.dashboardDailyTarget(target),
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _figure(
                          context,
                          '$assigned',
                          l10n.dashboardShopsAssigned,
                        ),
                      ),
                      _divider(context),
                      Expanded(
                        child: _figure(
                          context,
                          '$captured',
                          l10n.dashboardCapturedToday,
                          color: scheme.primary,
                        ),
                      ),
                      if (bounty != null) ...[
                        _divider(context),
                        Expanded(
                          child: _figure(
                            context,
                            bounty,
                            l10n.dashboardPendingBounty,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Semantics(
                  label: l10n.dashboardProgressLabel(captured, target),
                  container: true,
                  child: ExcludeSemantics(
                    child: SizedBox.square(
                      dimension: AppSpacing.xxxl,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            strokeWidth: AppDimensions.borderWidth * 3,
                            color: scheme.primary,
                            backgroundColor: scheme.surfaceContainerHighest,
                          ),
                          Text(
                            '$captured/$target',
                            style: AppTextStyles.mono(
                              Theme.of(context).textTheme.labelSmall!
                                  .copyWith(letterSpacing: 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider(BuildContext context) {
    return SizedBox(
      width: AppDimensions.borderWidth,
      height: AppSpacing.xxl,
      child: ColoredBox(color: context.semanticColors.border),
    );
  }

  Widget _figure(
    BuildContext context,
    String value,
    String label, {
    Color? color,
  }) {
    final style = Theme.of(context).textTheme.headlineSmall
        ?.copyWith(color: color, fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style == null ? null : AppTextStyles.tabular(style),
          ),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
