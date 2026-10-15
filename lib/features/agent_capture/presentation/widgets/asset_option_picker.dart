import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Option presented by [showAssetOptionPicker].
class AssetPickerOption {
  const AssetPickerOption({required this.value, required this.label});

  final String value;
  final String label;
}

/// Full-screen picker for a closed set of values (equipment category, make).
///
/// Returns the chosen value, or null when dismissed. The asset design draws
/// both of these as a 52 px select row; a full screen is used rather than a
/// dropdown because the market's make list is long and needs search.
Future<String?> showAssetOptionPicker({
  required BuildContext context,
  required String title,
  required List<AssetPickerOption> options,
  String selected = '',
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (context) {
      final media = MediaQuery.of(context);
      return Padding(
        padding: EdgeInsets.only(top: media.padding.top),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, _) => Divider(
                  height: AppDimensions.borderWidth,
                  color: context.semanticColors.border,
                ),
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = option.value == selected;
                  return InkWell(
                    onTap: () => Navigator.of(context).pop(option.value),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: AppDimensions.buttonHeightCompact,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option.label,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: isSelected
                                          ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                          : Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check,
                                size: AppDimensions.iconSm,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: media.padding.bottom),
          ],
        ),
      );
    },
  );
}
