import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The assets / media / submitted-by block.
class SubmissionFactGrid extends StatelessWidget {
  const SubmissionFactGrid({
    required this.assetCount,
    required this.media,
    required this.reviewer,
    super.key,
  });

  final int assetCount;
  final String media;
  final String reviewer;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            _fact(context, l10n.bountyLabelAssets, assetCount.toString()),
            _fact(context, l10n.bountyLabelMedia, media),
            _fact(context, l10n.bountyLabelSubmittedBy, reviewer),
          ],
        ),
      ),
    );
  }

  Widget _fact(BuildContext context, String label, String value) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
