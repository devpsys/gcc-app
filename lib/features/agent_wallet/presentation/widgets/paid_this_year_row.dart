import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The paid-this-year figure beside the escrow strip.
class PaidThisYearRow extends StatelessWidget {
  const PaidThisYearRow({required this.total, super.key});

  final String total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          size: AppSpacing.md,
          color: colors.success,
        ),
        const SizedBox(width: AppSpacing.xs),
        // Flexible so the label ellipsizes rather than pushing the total off
        // a narrow screen.
        Flexible(
          child: Text(
            context.l10n.walletPaidThisYear,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        const Spacer(),
        Text(
          total,
          maxLines: 1,
          style: AppTextStyles.tabular(
            Theme.of(context).textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
