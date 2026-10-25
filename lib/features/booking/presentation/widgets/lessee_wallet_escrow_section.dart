import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/lessee_escrow_hold.dart';

/// Escrow and audit holds shown when nothing is available to withdraw.
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
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final hold in holds) ...[
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(color: colors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock,
                    size: AppDimensions.iconMd,
                    color: colors.heldFunds,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hold.title,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: colors.heldFunds,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          hold.caption,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          hold.reference,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          hold.detail,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: scheme.onSurfaceVariant,
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
          const SizedBox(height: AppSpacing.xs),
        ],
      ],
    );
  }
}
