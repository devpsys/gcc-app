import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The "Why did this fail?" disclosure on the failed frame.
///
/// The design's offline-first promise is reassuring failure messaging: an agent
/// needs the reason and the remedy, not a bare error code.
class FailureExplanation extends StatelessWidget {
  const FailureExplanation({
    required this.reason,
    required this.onExpand,
    this.expanded = false,
    super.key,
  });

  final String reason;
  final VoidCallback onExpand;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onExpand,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  Icons.help_outline,
                  size: AppDimensions.iconSm,
                  color: colors.danger,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.itemWhyFailed,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.danger,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: AppDimensions.iconSm,
                  color: colors.danger,
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text(
              reason,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.danger),
            ),
          ),
      ],
    );
  }
}
