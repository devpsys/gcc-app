import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/language_option.dart';

/// One orthography row inside the language sheet (MOB-AUTH-UNIFIED Frame 04).
class LanguagePickerOptionRow extends StatelessWidget {
  const LanguagePickerOptionRow({
    required this.option,
    required this.selected,
    required this.activeLabel,
    required this.unavailableReason,
    required this.onTap,
    super.key,
  });

  final LanguageOption option;
  final bool selected;
  final String activeLabel;
  final String unavailableReason;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? scheme.secondaryContainer.withValues(alpha: 0.35)
          : scheme.surface,
      child: InkWell(
        onTap: option.enabled ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            option.nativeName,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        if (selected) ...[
                          const SizedBox(width: AppSpacing.xs),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: scheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(
                                AppRadii.pill,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                                vertical: 2,
                              ),
                              child: Text(
                                activeLabel,
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: scheme.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      option.sample,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    if (!option.enabled)
                      Text(
                        unavailableReason,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: scheme.error,
                        ),
                      ),
                  ],
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? scheme.primary : null,
                  border: Border.all(
                    color: selected ? scheme.primary : scheme.outline,
                    width: AppDimensions.emphasisBorderWidth,
                  ),
                ),
                child: SizedBox.square(
                  dimension: AppDimensions.iconMd,
                  child: selected
                      ? Icon(
                          Icons.check,
                          size: AppDimensions.iconSm,
                          color: scheme.onPrimary,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
