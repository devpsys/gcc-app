import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

/// The terminal frame after an agent discards their copy.
///
/// Muted rather than danger: nothing failed, the agent chose this, and the
/// reclaimed storage is stated so the decision reads as reversible in feeling —
/// the media is gone from the device, not from the record of what happened.
class DiscardedSubmissionFrame extends StatelessWidget {
  const DiscardedSubmissionFrame({
    required this.shopName,
    required this.bounty,
    super.key,
  });

  final String shopName;

  /// The bounty that is no longer claimable for this shop.
  final String bounty;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.itemTitle),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.semanticColors.border),
                ),
                child: SizedBox.square(
                  dimension: AppDimensions.emptyStateIcon,
                  child: Icon(
                    Icons.delete_outline,
                    size: AppDimensions.iconLg * 1.5,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.itemDiscardedHeadline,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.itemDiscardedBody(bounty, shopName),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.itemStorageReclaimed('Galaxy A12', '7.6 MB'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppSecondaryButton(
              label: l10n.itemBackToQueue,
              expand: true,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(height: AppSpacing.xs),
            AppPrimaryButton(
              label: l10n.itemCaptureAnother,
              expand: true,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    );
  }
}
