import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_segment_option.dart';
import 'package:gcc_app/core/widgets/app_segment_style.dart';
import 'package:gcc_app/core/widgets/app_segmented_control.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_condition_grade.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_helper_line.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_quantity_stepper.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_section_heading.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_labeled_control.dart';

/// Section B of the asset step: how much, and in what condition.
///
/// Condition grade uses the `filled` segmented style — a 48 px control with a
/// `brand-50` selection — as drawn in the asset design, which differs from the
/// 40 px raised picker used for shop type.
class AssetDetailsSection extends StatelessWidget {
  const AssetDetailsSection({
    required this.quantity,
    required this.onQuantityChanged,
    required this.condition,
    required this.onConditionChanged,
    this.conditionError,
    super.key,
  });

  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final AssetConditionGrade? condition;
  final ValueChanged<AssetConditionGrade> onConditionChanged;
  final String? conditionError;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final helper = switch (condition) {
      AssetConditionGrade.newCondition => l10n.captureAssetConditionNewHelp,
      AssetConditionGrade.good => l10n.captureAssetConditionGoodHelp,
      AssetConditionGrade.fair => l10n.captureAssetConditionFairHelp,
      AssetConditionGrade.needsService => l10n.captureAssetConditionServiceHelp,
      null => null,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssetSectionHeading(title: l10n.captureAssetSectionB),
        const SizedBox(height: AppSpacing.xs),
        CaptureLabeledControl(
          label: l10n.captureAssetQuantityLabel,
          child: AssetQuantityStepper(
            quantity: quantity,
            onChanged: onQuantityChanged,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        CaptureLabeledControl(
          label: l10n.captureAssetConditionLabel,
          error: conditionError,
          child: AppSegmentedControl<AssetConditionGrade>(
            style: AppSegmentStyle.filled,
            selected: condition,
            onChanged: onConditionChanged,
            options: [
              AppSegmentOption(
                value: AssetConditionGrade.newCondition,
                label: l10n.captureAssetConditionNew,
              ),
              AppSegmentOption(
                value: AssetConditionGrade.good,
                label: l10n.captureAssetConditionGood,
              ),
              AppSegmentOption(
                value: AssetConditionGrade.fair,
                label: l10n.captureAssetConditionFair,
              ),
              AppSegmentOption(
                value: AssetConditionGrade.needsService,
                label: l10n.captureAssetConditionService,
              ),
            ],
          ),
        ),
        if (helper != null)
          AssetHelperLine(
            text: helper,
            icon: Icons.check_circle_outline,
            iconColor: Theme.of(context).colorScheme.secondary,
          ),
      ],
    );
  }
}
