import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_segment_option.dart';
import 'package:gcc_app/core/widgets/app_segment_style.dart';
import 'package:gcc_app/core/widgets/app_segmented_control.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_availability.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_availability_helper.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_helper_line.dart';

/// Section C of the asset step: which catalog this asset routes into.
///
/// This is the routing decision, so it gets its own eyebrow and title rather
/// than the single heading used by sections A and B.
class AssetAvailabilitySection extends StatelessWidget {
  const AssetAvailabilitySection({
    required this.availability,
    required this.onChanged,
    super.key,
  });

  final AssetAvailability? availability;
  final ValueChanged<AssetAvailability> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.captureAssetSectionCEyebrow.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
            letterSpacing: AppTextStyles.eyebrowLetterSpacing,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs / 2),
        Text(
          l10n.captureAssetSectionC,
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.tight),
        AppSegmentedControl<AssetAvailability>(
          style: AppSegmentStyle.filled,
          selected: availability,
          onChanged: onChanged,
          options: [
            AppSegmentOption(
              value: AssetAvailability.rentalOnly,
              label: l10n.captureAssetAvailabilityRental,
            ),
            AppSegmentOption(
              value: AssetAvailability.bulkOnly,
              label: l10n.captureAssetAvailabilityBulk,
            ),
            AppSegmentOption(
              value: AssetAvailability.both,
              label: l10n.captureAssetAvailabilityBoth,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        AssetAvailabilityHelper(availability: availability),
        AssetHelperLine(text: l10n.captureAssetChangeLater),
      ],
    );
  }
}
