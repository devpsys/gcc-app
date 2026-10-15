import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_availability.dart';

/// Explains what a chosen [AssetAvailability] means for the vendor.
///
/// The rental variant is drawn in the asset design; the bulk and both
/// variants follow the same structure and voice but are not themselves
/// specified by the design file.
class AssetAvailabilityHelper extends StatelessWidget {
  const AssetAvailabilityHelper({required this.availability, super.key});

  final AssetAvailability? availability;

  @override
  Widget build(BuildContext context) {
    final mode = availability;
    if (mode == null) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final (title, body) = switch (mode) {
      AssetAvailability.rentalOnly => (
        l10n.captureAssetRentalHelperTitle,
        l10n.captureAssetRentalHelperBody,
      ),
      AssetAvailability.bulkOnly => (
        l10n.captureAssetBulkHelperTitle,
        l10n.captureAssetBulkHelperBody,
      ),
      AssetAvailability.both => (
        l10n.captureAssetBothHelperTitle,
        l10n.captureAssetBothHelperBody,
      ),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: AppDimensions.iconMd,
                  color: scheme.primary,
                ),
                const SizedBox(width: AppSpacing.tight),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.tight),
            Text(
              body,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
