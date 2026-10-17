import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The recovery path on the rejected frame.
///
/// States plainly what a resubmission costs — a new reference, with the
/// original kept on record — so an agent is not surprised to see two
/// submissions for one shop.
class RejectionRecoveryPanel extends StatelessWidget {
  const RejectionRecoveryPanel({
    required this.newReference,
    required this.resubmitLabel,
    required this.discardLabel,
    this.onResubmit,
    this.onDiscard,
    super.key,
  });

  /// The reference the resubmission will get, e.g. `SUB-2231`.
  final String newReference;
  final String resubmitLabel;
  final String discardLabel;
  final VoidCallback? onResubmit;
  final VoidCallback? onDiscard;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.cardLarge),
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: AppSpacing.md,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.bountyResubmitNote(newReference),
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: AppDimensions.buttonHeight,
          child: FilledButton(
            onPressed: onResubmit,
            child: Text(resubmitLabel),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          height: AppDimensions.buttonHeight,
          child: OutlinedButton(
            onPressed: onDiscard,
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.danger,
              side: BorderSide(color: colors.dangerBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.button),
              ),
            ),
            child: Text(discardLabel),
          ),
        ),
      ],
    );
  }
}
