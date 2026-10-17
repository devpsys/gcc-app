import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';

/// The three figures above the work list: done, captured, route distance.
///
/// The figures are tabular so they do not jitter as they tick up during a
/// shift. No money appears here — this is a work list, not a wallet.
class RouteSummaryStrip extends StatelessWidget {
  const RouteSummaryStrip({required this.summary, super.key});

  final RouteSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            _cell(
              context,
              '${summary.done} ${l10n.shopsSummaryDone}',
              l10n.shopsScopeToday,
            ),
            _cell(context, '${summary.captured}', l10n.shopsSummaryCaptured),
            _cell(context, summary.routeDistance, l10n.shopsSummaryRoute),
          ],
        ),
      ),
    );
  }

  Widget _cell(BuildContext context, String figure, String label) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            figure,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.tabular(
              Theme.of(context).textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
