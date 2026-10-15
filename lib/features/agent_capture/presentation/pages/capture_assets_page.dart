import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_availability.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_condition_grade.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_state.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_availability_section.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_details_section.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_empty_state.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_equipment_section.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_bounty_notice.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_issue_banner.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_option_picker.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_summary_row.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_wizard_scaffold.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/wizard_action_bar.dart';

/// Wizard step 3 — asset details and catalog routing.
///
/// Assets are optional by design: the design's own empty state says a shop can
/// be submitted without listing every one, so Continue is never gated on the
/// asset form. Only "+ Add another asset" requires the current asset to be
/// complete.
class CaptureAssetsPage extends StatelessWidget {
  const CaptureAssetsPage({super.key});

  /// Makes offered by the picker. A production list comes from the catalog;
  /// these are the makes the design's populated frame shows.
  static const List<String> _makes = [
    'Mika',
    'Mikano',
    'Cummins',
    'Mercury',
    'Bosch',
    'Makita',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureCubit, CaptureState>(
      builder: (context, state) {
        final draft = state.draft;
        final asset = draft.asset;
        final l10n = context.l10n;
        final cubit = context.read<CaptureCubit>();
        final savedAt = draft.savedAt;
        final showForm = draft.showAssetForm || draft.assets.isNotEmpty;
        final showErrors = draft.assetAttempted && !asset.isComplete;
        return CaptureWizardScaffold(
          title: l10n.captureAssetsTitle,
          stepLabels: [
            l10n.captureStepShop,
            l10n.captureStepLocation,
            l10n.captureStepAssets,
            l10n.captureStepMedia,
          ],
          currentIndex: 2,
          stepEyebrow: l10n.captureStepEyebrow(
            3,
            4,
            l10n.captureAssetCatalogHeading,
          ),
          stepBadge: l10n.captureStepActive(3, 4),
          stepBadgeStyle: WizardStepBadge.active,
          autosaveLabel: savedAt == null
              ? null
              : l10n.captureAutosaved(
                  DateFormat.jm(Localizations.localeOf(context).toString())
                      .format(savedAt),
                ),
          actionBar: WizardActionBar(
            secondaryLabel: l10n.captureSaveDraft,
            primaryLabel: l10n.captureAssetPrimaryLabel,
            onSecondary: cubit.rememberDraft,
            onPrimary: () =>
                GoRouter.maybeOf(context)?.push(RoutePaths.captureMedia),
            primaryDisabledReason: draft.assets.isEmpty && asset.isEmpty
                ? l10n.captureAssetSubmitWithoutAssets
                : null,
          ),
          children: [
            for (var index = 0; index < draft.assets.length; index++) ...[
              AssetSummaryRow(
                asset: draft.assets[index],
                categoryLabel: _categoryLabel(
                  context,
                  draft.assets[index].category,
                ),
                availabilityLabel: _availabilityLabel(
                  context,
                  draft.assets[index].availability,
                ),
                conditionLabel: _conditionLabel(
                  context,
                  draft.assets[index].condition,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            if (!showForm)
              AssetEmptyState(
                actionLabel: l10n.captureAssetAddFirst,
                onAction: cubit.startAssetForm,
              )
            else ...[
              if (showErrors) ...[
                AssetIssueBanner(count: asset.issueCount),
                const SizedBox(height: AppSpacing.sm),
              ],
              AssetEquipmentSection(
                asset: asset,
                categoryLabel: asset.category == null
                    ? l10n.captureAssetChooseCategory
                    : _categoryLabel(context, asset.category),
                categoryHint: l10n.captureAssetChooseCategory,
                makeLabel: asset.make.isEmpty
                    ? l10n.captureAssetChooseMake
                    : asset.make,
                makeHint: l10n.captureAssetChooseMake,
                categoryError: showErrors && asset.category == null
                    ? l10n.captureAssetCategoryRequired
                    : null,
                capacityError: showErrors && asset.capacity.trim().isEmpty
                    ? l10n.captureAssetCapacityRequired
                    : null,
                onPickCategory: () => _pickCategory(context, cubit),
                onPickMake: () => _pickMake(context, cubit),
                onCapacityChanged: cubit.editAssetCapacity,
                onModelChanged: cubit.editAssetModel,
                onYearChanged: cubit.editAssetYear,
                onSerialChanged: cubit.editAssetSerial,
              ),
              const SizedBox(height: AppSpacing.md),
              AssetDetailsSection(
                quantity: asset.quantity,
                onQuantityChanged: cubit.changeAssetQuantity,
                condition: asset.condition,
                onConditionChanged: cubit.selectAssetCondition,
                conditionError: showErrors && asset.condition == null
                    ? l10n.captureAssetConditionRequired
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),
              AssetAvailabilitySection(
                availability: asset.availability,
                onChanged: cubit.selectAssetAvailability,
              ),
              const SizedBox(height: AppSpacing.md),
              AppSecondaryButton(
                label: l10n.captureAssetAddAnother,
                icon: Icons.add,
                expand: true,
                onPressed: cubit.addAsset,
              ),
            ],
            if (draft.assets.length >= 2) ...[
              const SizedBox(height: AppSpacing.sm),
              AssetBountyNotice(count: draft.assets.length),
            ],
          ],
        );
      },
    );
  }

  Future<void> _pickCategory(BuildContext context, CaptureCubit cubit) async {
    final l10n = context.l10n;
    final picked = await showAssetOptionPicker(
      context: context,
      title: l10n.captureAssetCategoryLabel,
      selected: cubit.draft.asset.category?.name ?? '',
      options: [
        for (final category in AssetCategory.values)
          AssetPickerOption(
            value: category.name,
            label: _categoryLabel(context, category),
          ),
      ],
    );
    if (picked == null || !context.mounted) {
      return;
    }
    final match = AssetCategory.values.where((c) => c.name == picked);
    if (match.isNotEmpty) {
      cubit.selectAssetCategory(match.first);
    }
  }

  Future<void> _pickMake(BuildContext context, CaptureCubit cubit) async {
    final l10n = context.l10n;
    final picked = await showAssetOptionPicker(
      context: context,
      title: l10n.captureAssetMakeLabel,
      selected: cubit.draft.asset.make,
      options: [
        for (final make in _makes) AssetPickerOption(value: make, label: make),
      ],
    );
    if (picked != null) {
      cubit.editAssetMake(picked);
    }
  }

  String _categoryLabel(BuildContext context, AssetCategory? category) {
    final l10n = context.l10n;
    return switch (category) {
      AssetCategory.generators => l10n.captureCategoryGenerators,
      AssetCategory.waterPumps => l10n.captureCategoryWaterPumps,
      AssetCategory.welding => l10n.captureCategoryWelding,
      AssetCategory.buildingMaterials => l10n.captureCategoryBuilding,
      AssetCategory.electrical => l10n.captureCategoryElectrical,
      AssetCategory.sound => l10n.captureCategorySound,
      AssetCategory.lighting => l10n.captureCategoryLighting,
      AssetCategory.compression => l10n.captureCategoryCompression,
      AssetCategory.catering => l10n.captureCategoryCatering,
      AssetCategory.beverages => l10n.captureCategoryBeverages,
      AssetCategory.fertilizer => l10n.captureCategoryFertilizer,
      null => '',
    };
  }

  String _availabilityLabel(BuildContext context, AssetAvailability? value) {
    final l10n = context.l10n;
    return switch (value) {
      AssetAvailability.rentalOnly => l10n.captureAssetAvailabilityRental,
      AssetAvailability.bulkOnly => l10n.captureAssetAvailabilityBulk,
      AssetAvailability.both => l10n.captureAssetAvailabilityBoth,
      null => '',
    };
  }

  String _conditionLabel(BuildContext context, AssetConditionGrade? value) {
    final l10n = context.l10n;
    return switch (value) {
      AssetConditionGrade.newCondition => l10n.captureAssetConditionNew,
      AssetConditionGrade.good => l10n.captureAssetConditionGood,
      AssetConditionGrade.fair => l10n.captureAssetConditionFair,
      AssetConditionGrade.needsService => l10n.captureAssetConditionService,
      null => '',
    };
  }
}
