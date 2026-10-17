import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// What the agent stands to earn if this shop verifies.
///
/// The design is explicit that this is **not** a held amount — no lock glyph,
/// and the panel is a warning wash rather than an escrow treatment. That keeps
/// it from reading as money the agent already owns.
class BountyExpectationPanel extends StatelessWidget {
  const BountyExpectationPanel({
    required this.amount,
    required this.note,
    super.key,
  });

  /// Per-shop bounty, e.g. `₦5,000`.
  final String amount;

  /// Running total context, e.g. what they have earned this week.
  final String note;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.warningContainer,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: colors.warning.withValues(alpha: 0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.reviewBountyEyebrow,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.warning,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              amount,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              note,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
