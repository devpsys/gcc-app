import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/language_option.dart';

class LanguageOptionRow extends StatelessWidget {
  const LanguageOptionRow({
    required this.option,
    required this.selected,
    required this.unavailableReason,
    this.currentLabel,
    this.onTap,
    super.key,
  });

  final LanguageOption option;
  final bool selected;
  final String unavailableReason;
  final String? currentLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final current = currentLabel;
    return Semantics(
      selected: selected,
      enabled: option.enabled,
      button: option.enabled,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: option.enabled ? onTap : null,
          borderRadius: BorderRadius.circular(AppRadii.dialog),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(AppRadii.dialog),
              border: Border.all(
                color: selected
                    ? scheme.primary
                    : context.semanticColors.border,
                width: selected
                    ? AppDimensions.emphasisBorderWidth
                    : AppDimensions.borderWidth,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.dialog),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ColoredBox(
                    color: selected
                        ? scheme.secondaryContainer
                        : scheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.sm,
                      ),
                      child: Row(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selected ? scheme.primary : null,
                              border: Border.all(
                                color: selected
                                    ? scheme.primary
                                    : scheme.outline,
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
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              option.nativeName,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          if (selected && current != null)
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: scheme.primaryContainer,
                                borderRadius: BorderRadius.circular(
                                  AppRadii.pill,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xs,
                                  vertical: AppSpacing.xxs,
                                ),
                                child: Text(
                                  current,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: scheme.onPrimaryContainer,
                                      ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  ColoredBox(
                    color: scheme.surfaceContainerLow,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option.sample,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurface),
                          ),
                          if (!option.enabled) ...[
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              unavailableReason,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: scheme.error),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
