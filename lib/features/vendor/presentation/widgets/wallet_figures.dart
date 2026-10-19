import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_held_amount.dart';

/// Available, awaiting, and held. Only the last two are escrow.
class WalletFigures extends StatelessWidget {
  const WalletFigures({
    required this.availableLabel,
    required this.available,
    required this.awaitingLabel,
    required this.awaitingCaption,
    required this.awaiting,
    required this.heldLabel,
    required this.heldCaption,
    required this.held,
    super.key,
  });

  final String availableLabel;
  final String available;
  final String awaitingLabel;
  final String awaitingCaption;
  final String awaiting;
  final String heldLabel;
  final String heldCaption;
  final String held;

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
      child: Column(
        children: [
          _plain(context, availableLabel, available),
          Divider(height: AppDimensions.borderWidth, color: colors.border),
          _held(context, awaitingLabel, awaitingCaption, awaiting),
          Divider(height: AppDimensions.borderWidth, color: colors.border),
          _held(context, heldLabel, heldCaption, held),
        ],
      ),
    );
  }

  Widget _plain(BuildContext context, String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                amount,
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _held(
    BuildContext context,
    String label,
    String caption,
    String amount,
  ) {
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colors.heldFunds,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  caption,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: FittedBox(child: WalletHeldAmount(amount: amount)),
          ),
        ],
      ),
    );
  }
}
