import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_scan_action.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_section_heading.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_text_field.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/spatial_selector_field.dart';

/// Section A of the asset step: what the equipment is.
///
/// Category and Make are closed sets and reuse the capture select row; the
/// remaining fields are free text. Only Category and Capacity carry the
/// required marker in the design.
class AssetEquipmentSection extends StatelessWidget {
  const AssetEquipmentSection({
    required this.asset,
    required this.categoryLabel,
    required this.categoryHint,
    required this.makeLabel,
    required this.makeHint,
    required this.capacityError,
    required this.categoryError,
    required this.onPickCategory,
    required this.onPickMake,
    required this.onCapacityChanged,
    required this.onModelChanged,
    required this.onYearChanged,
    required this.onSerialChanged,
    super.key,
  });

  final AssetDraft asset;

  /// Chosen category, or the placeholder when nothing is selected.
  final String categoryLabel;
  final String categoryHint;
  final String makeLabel;
  final String makeHint;
  final String? capacityError;
  final String? categoryError;
  final VoidCallback onPickCategory;
  final VoidCallback onPickMake;
  final ValueChanged<String> onCapacityChanged;
  final ValueChanged<String> onModelChanged;
  final ValueChanged<String> onYearChanged;
  final ValueChanged<String> onSerialChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssetSectionHeading(
          title: l10n.captureAssetSectionA,
          reference: asset.hasReference ? asset.displayReference : null,
        ),
        const SizedBox(height: AppSpacing.xs),
        SpatialSelectorField(
          label: l10n.captureAssetCategoryLabel,
          value: categoryLabel,
          hint: categoryHint,
          onPressed: onPickCategory,
          error: categoryError != null,
          errorText: categoryError,
        ),
        const SizedBox(height: AppSpacing.xs),
        SpatialSelectorField(
          label: l10n.captureAssetMakeLabel,
          value: makeLabel,
          hint: makeHint,
          onPressed: onPickMake,
        ),
        const SizedBox(height: AppSpacing.xs),
        AssetTextField(
          label: l10n.captureAssetCapacityLabel,
          hint: l10n.captureAssetCapacityHint,
          value: asset.capacity,
          errorText: capacityError,
          onChanged: onCapacityChanged,
          fieldKey: const Key('capture.assetCapacityField'),
        ),
        const SizedBox(height: AppSpacing.xs),
        AssetTextField(
          label: l10n.captureAssetModelLabel,
          hint: l10n.captureAssetModelHint,
          value: asset.model,
          onChanged: onModelChanged,
        ),
        const SizedBox(height: AppSpacing.xs),
        AssetTextField(
          label: l10n.captureAssetYearLabel,
          hint: l10n.captureAssetYearHint,
          value: asset.year,
          keyboardType: TextInputType.number,
          onChanged: onYearChanged,
        ),
        const SizedBox(height: AppSpacing.xs),
        AssetTextField(
          label: l10n.captureAssetSerialLabel,
          hint: l10n.captureAssetSerialHint,
          value: asset.serial,
          onChanged: onSerialChanged,
          action: AssetScanAction(label: l10n.captureAssetScan),
        ),
      ],
    );
  }
}
