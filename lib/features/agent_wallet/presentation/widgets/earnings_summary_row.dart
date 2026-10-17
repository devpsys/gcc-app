import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';

/// The earned-total and average beneath the chart.
class EarningsSummaryRow extends StatelessWidget {
  const EarningsSummaryRow({required this.weeks, super.key});

  final List<WeeklyEarning> weeks;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    if (weeks.isEmpty) {
      return const SizedBox.shrink();
    }
    final total = weeks.fold<double>(0, (sum, w) => sum + w.numeric);
    final average = total / weeks.length;

    return Row(
      children: [
        Expanded(
          child: Text(
            // Generated parameters are alphabetical: (period, total).
            context.l10n.walletEarnedOver(
              '6 weeks',
              '₦${_thousands(total / 1000)}K',
            ),
            style: AppTextStyles.mono(
              Theme.of(context).textTheme.labelSmall!
                  .copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ),
        Text(
          context.l10n.walletAverage('₦${_thousands(average / 1000)}K'),
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: colors.success, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  static String _thousands(double value) {
    final rounded = value.round();
    final text = rounded.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) buffer.write(',');
      buffer.write(text[i]);
    }
    return buffer.toString();
  }
}
