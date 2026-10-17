import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The install prompt.
class InstallPromptCard extends StatelessWidget {
  const InstallPromptCard({this.onInstall, super.key});

  final VoidCallback? onInstall;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.infoContainer,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.add_to_home_screen,
                  size: AppSpacing.md,
                  color: colors.info,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.profileInstallTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.info,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.profileInstallBody,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: AppDimensions.buttonHeight,
              child: FilledButton(
                onPressed: onInstall,
                style: FilledButton.styleFrom(
                  backgroundColor: colors.info,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                ),
                child: Text(l10n.profileInstallCta),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
