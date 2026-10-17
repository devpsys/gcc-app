import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';

/// One bar, with its figure above and its week end below.
class WeeklyBar extends StatelessWidget {
  const WeeklyBar({required this.week, required this.fraction, super.key});

  final WeeklyEarning week;

  /// Bar height as a fraction of the tallest week, 0 to 1.
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          week.amount,
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.labelSmall!
                .copyWith(color: scheme.onSurface, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 2),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            child: FractionallySizedBox(
              heightFactor: fraction.clamp(0.04, 1),
              alignment: Alignment.bottomCenter,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.success,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          week.weekEnding,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.labelSmall!
                .copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
