import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class WatchGateCheck extends StatelessWidget {
  const WatchGateCheck({
    required this.title,
    required this.caption,
    required this.value,
    this.onChanged,
    super.key,
  });

  final String title;
  final String caption;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final changed = onChanged;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: changed == null ? null : () => changed(!value),
          borderRadius: BorderRadius.circular(AppRadii.card),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  checked: value,
                  enabled: changed != null,
                  child: SizedBox(
                    width: AppDimensions.minTouchTarget,
                    height: AppDimensions.minTouchTarget,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: value ? scheme.primary : scheme.surface,
                          borderRadius: BorderRadius.circular(AppRadii.button),
                          border: Border.all(
                            color: value ? scheme.primary : scheme.outline,
                            width: AppDimensions.emphasisBorderWidth,
                          ),
                        ),
                        child: SizedBox(
                          width: AppDimensions.iconLg,
                          height: AppDimensions.iconLg,
                          child: value
                              ? Icon(
                                  Icons.check,
                                  size: AppDimensions.iconSm,
                                  color: scheme.onPrimary,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: textTheme.bodyMedium),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(caption, style: textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
