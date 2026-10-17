import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/escrow_hatch.dart';

/// The escrow strip under the balance card.
///
/// This is where the lock belongs: GCC is holding this pending verification.
/// The amber hatch marks it, and the design allows no lock anywhere else in the
/// wallet.
class PendingEscrowCard extends StatelessWidget {
  const PendingEscrowCard({
    required this.amount,
    required this.label,
    required this.note,
    super.key,
  });

  final String amount;
  final String label;
  final String note;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        child: Stack(
          children: [
            const Positioned.fill(
              child: CustomPaint(painter: EscrowHatchPainter()),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Row(
                children: [
                  Icon(
                    Icons.lock,
                    size: AppSpacing.lg,
                    color: context.semanticColors.heldFunds,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                        Text(
                          amount,
                          style: AppTextStyles.tabular(
                            Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
