import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class HeldFundsIndicator extends StatelessWidget {
  const HeldFundsIndicator({
    required this.label,
    required this.amount,
    this.caption,
    this.compact = false,
    super.key,
  });

  final String label;
  final String amount;
  final String? caption;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    if (compact) {
      return Semantics(
        label: '$label $amount',
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.heldFundsContainer,
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: colors.heldFunds),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.card),
            child: CustomPaint(
              painter: _EscrowHatchPainter(colors.heldFunds),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: AppDimensions.iconSm,
                      color: colors.heldFunds,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Flexible(
                      child: Text(
                        amount,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: colors.heldFunds),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    final captionText = caption;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.heldFundsContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.heldFunds),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: CustomPaint(
          painter: _EscrowHatchPainter(colors.heldFunds),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                Icon(
                  Icons.lock,
                  size: AppDimensions.iconSm,
                  color: colors.heldFunds,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (captionText != null)
                        Text(
                          captionText,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: Text(
                    amount,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.tabular(
                      Theme.of(context).textTheme.labelLarge!
                          .copyWith(color: colors.heldFunds),
                    ),
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

class _EscrowHatchPainter extends CustomPainter {
  _EscrowHatchPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..strokeWidth = AppDimensions.borderWidth * 4;
    const gap = 8.0;
    for (var x = -size.height; x < size.width; x += gap) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_EscrowHatchPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
