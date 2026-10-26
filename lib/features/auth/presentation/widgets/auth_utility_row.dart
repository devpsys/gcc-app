import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Language chip + Help action (MOB-AUTH-UNIFIED Frame 01 footer).
class AuthUtilityRow extends StatelessWidget {
  const AuthUtilityRow({
    required this.languageName,
    required this.onLanguage,
    required this.onHelp,
    super.key,
  });

  final String languageName;
  final VoidCallback onLanguage;
  final VoidCallback onHelp;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Material(
            color: scheme.surfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.button),
              side: BorderSide(color: colors.border),
            ),
            child: InkWell(
              onTap: onLanguage,
              borderRadius: BorderRadius.circular(AppRadii.button),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.language,
                      size: AppDimensions.iconSm,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Flexible(
                      child: Text(
                        l10n.authLanguageLabel(languageName),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.expand_more,
                      size: AppDimensions.iconSm,
                      color: scheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        TextButton.icon(
          onPressed: onHelp,
          style: TextButton.styleFrom(
            foregroundColor: scheme.primary,
            visualDensity: VisualDensity.compact,
          ),
          icon: Icon(
            Icons.help_outline,
            size: AppDimensions.iconSm,
            color: scheme.primary,
          ),
          label: Text(
            l10n.authHelp,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
