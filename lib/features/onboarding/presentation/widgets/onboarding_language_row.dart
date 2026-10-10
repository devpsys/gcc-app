import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/auth/presentation/widgets/language_option.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_selection_mark.dart';

class OnboardingLanguageRow extends StatelessWidget {
  const OnboardingLanguageRow({
    required this.option,
    required this.selected,
    required this.unavailableReason,
    required this.onTap,
    super.key,
  });

  final LanguageOption option;
  final bool selected;
  final String unavailableReason;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final title = switch (option.id) {
      'english' || 'pidgin' => option.englishName,
      'yoruba' => l10n.languageYorubaTitle,
      _ => option.nativeName,
    };
    final showSample = option.id != 'english' && option.id != 'pidgin';
    final subtitle = Theme.of(context).textTheme.bodySmall;

    return Semantics(
      button: true,
      selected: selected,
      enabled: option.enabled,
      label: title,
      child: Material(
        color: selected
            ? scheme.secondaryContainer.withValues(alpha: 0.5)
            : scheme.surface,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: AppSpacing.max),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (showSample)
                          Text.rich(
                            TextSpan(
                              style: subtitle,
                              children: [
                                TextSpan(text: '${option.englishName} · '),
                                TextSpan(
                                  text: option.sample,
                                  style: subtitle?.copyWith(
                                    color: scheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Text(option.englishName, style: subtitle),
                        if (!option.enabled)
                          Text(unavailableReason, style: subtitle),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  OnboardingSelectionMark(selected: selected),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
