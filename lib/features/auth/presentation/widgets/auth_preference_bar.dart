import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class AuthPreferenceBar extends StatelessWidget {
  const AuthPreferenceBar({
    required this.languageLabel,
    required this.languageValue,
    required this.onLanguage,
    required this.notificationsLabel,
    required this.notificationsValue,
    super.key,
  });

  final String languageLabel;
  final String languageValue;
  final VoidCallback onLanguage;
  final String notificationsLabel;
  final String notificationsValue;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Column(
          children: [
            preferenceRow(
              context,
              label: languageLabel,
              value: languageValue,
              onTap: onLanguage,
              showChevron: true,
            ),
            Divider(
              height: AppDimensions.borderWidth,
              thickness: AppDimensions.borderWidth,
              color: scheme.surfaceContainerHighest,
            ),
            preferenceRow(
              context,
              label: notificationsLabel,
              value: notificationsValue,
            ),
          ],
        ),
      ),
    );
  }

  Widget preferenceRow(
    BuildContext context, {
    required String label,
    required String value,
    VoidCallback? onTap,
    bool showChevron = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final row = ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: AppDimensions.minTouchTarget,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurface),
            ),
          ),
          if (showChevron)
            Icon(
              Icons.expand_more,
              size: AppDimensions.iconSm,
              color: scheme.onSurfaceVariant,
            ),
        ],
      ),
    );
    final action = onTap;
    if (action == null) {
      return row;
    }
    return InkWell(onTap: action, child: row);
  }
}
