import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';

/// Ready, rented, and maintenance as one segmented control.
class CatalogStatusControl extends StatelessWidget {
  const CatalogStatusControl({
    required this.status,
    required this.readyLabel,
    required this.rentedLabel,
    required this.maintenanceLabel,
    required this.onSelected,
    this.enabled = true,
    super.key,
  });

  final VendorAssetStatus status;
  final String readyLabel;
  final String rentedLabel;
  final String maintenanceLabel;
  final ValueChanged<VendorAssetStatus>? onSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.button),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: Row(
          children: [
            _segment(
              context,
              label: readyLabel,
              value: VendorAssetStatus.ready,
              selected: status == VendorAssetStatus.ready,
            ),
            _segment(
              context,
              label: rentedLabel,
              value: VendorAssetStatus.rented,
              selected: status == VendorAssetStatus.rented,
            ),
            _segment(
              context,
              label: maintenanceLabel,
              value: VendorAssetStatus.maintenance,
              selected: status == VendorAssetStatus.maintenance,
            ),
          ],
        ),
      ),
    );
  }

  Widget _segment(
    BuildContext context, {
    required String label,
    required VendorAssetStatus value,
    required bool selected,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final fill = switch (value) {
      VendorAssetStatus.ready => colors.success,
      VendorAssetStatus.rented => colors.info,
      VendorAssetStatus.maintenance => colors.heldFunds,
      VendorAssetStatus.pending => scheme.surface,
    };
    final canTap = enabled && onSelected != null;
    return Expanded(
      child: Material(
        color: selected ? fill : scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.input),
        child: InkWell(
          onTap: canTap ? () => onSelected!(value) : null,
          borderRadius: BorderRadius.circular(AppRadii.input),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimensions.minTouchTarget - AppSpacing.xs,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.input),
                border: selected ? null : Border.all(color: scheme.outline),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                child: Center(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: selected ? scheme.surface : scheme.onSurface,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
