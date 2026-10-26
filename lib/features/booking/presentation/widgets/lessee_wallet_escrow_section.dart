import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/lessee_escrow_hold.dart';

/// Escrow and audit holds with hatch treatment (MOB-LSE-14 frame 3).
class LesseeWalletEscrowSection extends StatelessWidget {
  const LesseeWalletEscrowSection({
    required this.title,
    required this.holds,
    super.key,
  });

  final String title;
  final List<LesseeEscrowHold> holds;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
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
        for (final hold in holds) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.heldFundsContainer,
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(
                color: colors.heldFunds.withValues(alpha: 0.45),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.card),
              child: CustomPaint(
                painter: _EscrowCardHatchPainter(colors.heldFunds),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
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
                                        hold.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: colors.heldFunds,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.xxs),
                                Text(
                                  hold.caption,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: colors.heldFunds.withValues(
                                          alpha: 0.9,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.lock,
                                size: AppDimensions.iconSm,
                                color: colors.heldFunds,
                              ),
                              const SizedBox(width: AppSpacing.xxs),
                              Text(
                                hold.amount,
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
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Divider(
                        height: AppDimensions.borderWidth,
                        color: colors.heldFunds.withValues(alpha: 0.25),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              hold.reference,
                              style: AppTextStyles.mono(
                                Theme.of(context).textTheme.labelSmall!
                                    .copyWith(color: colors.heldFunds),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              hold.detail,
                              textAlign: TextAlign.end,
                              style: AppTextStyles.mono(
                                Theme.of(context).textTheme.labelSmall!
                                    .copyWith(color: colors.heldFunds),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _EscrowCardHatchPainter extends CustomPainter {
  _EscrowCardHatchPainter(this.color);

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
  bool shouldRepaint(_EscrowCardHatchPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
