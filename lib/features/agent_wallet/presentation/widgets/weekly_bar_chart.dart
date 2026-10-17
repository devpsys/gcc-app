import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/weekly_bar.dart';

/// Six weeks of weekly earnings as micro bars.
///
/// Each bar is labelled with its own figure, so the chart is readable without
/// hovering or tapping — an agent checking their week should not have to
/// interact to learn what they earned.
class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({
    required this.weeks,
    required this.title,
    this.onPreviousPeriod,
    this.previousLabel,
    super.key,
  });

  final List<WeeklyEarning> weeks;
  final String title;
  final VoidCallback? onPreviousPeriod;
  final String? previousLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final peak = weeks.fold<double>(
      0,
      (max, w) => w.numeric > max ? w.numeric : max,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            if (previousLabel != null)
              TextButton(
                onPressed: onPreviousPeriod,
                style: TextButton.styleFrom(foregroundColor: scheme.primary),
                child: Text(
                  previousLabel!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 112,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final week in weeks)
                Expanded(
                  child: WeeklyBar(
                    week: week,
                    fraction: peak == 0 ? 0 : week.numeric / peak,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
