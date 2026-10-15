import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_segment_option.dart';
import 'package:gcc_app/core/widgets/app_segmented_control.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_type.dart';

class ShopTypeField extends StatelessWidget {
  const ShopTypeField({
    required this.selected,
    required this.onChanged,
    this.errorText,
    super.key,
  });

  final ShopType? selected;
  final ValueChanged<ShopType> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final error = errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.captureShopType,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: error == null
                      ? null
                      : Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            if (error == null && selected == null)
              Text(
                l10n.captureRequired,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.semanticColors.muted,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        AppSegmentedControl<ShopType>(
          selected: selected,
          onChanged: onChanged,
          options: [
            AppSegmentOption(
              value: ShopType.equipmentYard,
              label: l10n.captureShopTypeEquipment,
            ),
            AppSegmentOption(
              value: ShopType.bulkSupplier,
              label: l10n.captureShopTypeBulk,
            ),
            AppSegmentOption(
              value: ShopType.both,
              label: l10n.captureShopTypeBoth,
            ),
          ],
        ),
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
