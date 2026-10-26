import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Three-figure breakdown with NO LOCK / ESCROW / AUDIT badges (MOB-LSE-14).
class LesseeWalletBreakdown extends StatelessWidget {
  const LesseeWalletBreakdown({
    required this.title,
    required this.availableLabel,
    required this.availableCaption,
    required this.available,
    required this.availableBadge,
    required this.depositsLabel,
    required this.depositsCaption,
    required this.deposits,
    required this.depositsBadge,
    required this.pendingLabel,
    required this.pendingCaption,
    required this.pending,
    required this.pendingBadge,
    super.key,
  });

  final String title;
  final String availableLabel;
  final String availableCaption;
  final String available;
  final String availableBadge;
  final String depositsLabel;
  final String depositsCaption;
  final String deposits;
  final String depositsBadge;
  final String pendingLabel;
  final String pendingCaption;
  final String pending;
  final String pendingBadge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _plainRow(
              context,
              label: availableLabel,
              caption: availableCaption,
              amount: available,
              badge: availableBadge,
              amountColor: colors.success,
              dotColor: colors.success,
            ),
            Divider(height: AppSpacing.md, color: colors.border),
            _escrowRow(
              context,
              label: depositsLabel,
              caption: depositsCaption,
              amount: deposits,
              badge: depositsBadge,
            ),
            Divider(height: AppSpacing.md, color: colors.border),
            _plainRow(
              context,
              label: pendingLabel,
              caption: pendingCaption,
              amount: pending,
              badge: pendingBadge,
              amountColor: colors.info,
              dotColor: colors.info,
            ),
          ],
        ),
      ),
    );
  }

  Widget _plainRow(
    BuildContext context, {
    required String label,
    required String caption,
    required String amount,
    required String badge,
    required Color amountColor,
    required Color dotColor,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.square(dimension: AppSpacing.xxs),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                caption,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  amount,
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: amountColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Text(
                badge,
                textAlign: TextAlign.end,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _escrowRow(
    BuildContext context, {
    required String label,
    required String caption,
    required String amount,
    required String badge,
  }) {
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.heldFundsContainer,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.heldFunds.withValues(alpha: 0.35)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: CustomPaint(
          painter: _BreakdownHatchPainter(colors.heldFunds),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: AppDimensions.iconSm,
                            color: colors.heldFunds,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          Expanded(
                            child: Text(
                              label,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: colors.heldFunds,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        caption,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.heldFunds.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.lock,
                              size: AppDimensions.iconSm,
                              color: colors.heldFunds,
                            ),
                            const SizedBox(width: AppSpacing.xxs),
                            Text(
                              amount,
                              style: AppTextStyles.tabular(
                                Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: colors.heldFunds,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.heldFunds.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppRadii.input),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: 1,
                          ),
                          child: Text(
                            badge,
                            style: AppTextStyles.mono(
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: colors.heldFunds,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BreakdownHatchPainter extends CustomPainter {
  _BreakdownHatchPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..strokeWidth = AppDimensions.borderWidth * 4;
    const gap = 12.0;
    for (var x = -size.height; x < size.width; x += gap) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BreakdownHatchPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
