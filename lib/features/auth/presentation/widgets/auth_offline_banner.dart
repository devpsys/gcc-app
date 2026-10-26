import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Warning banner for cached offline session (MOB-AUTH-UNIFIED Frame 01).
class AuthOfflineBanner extends StatelessWidget {
  const AuthOfflineBanner({this.onRetry, super.key});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.warningContainer,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.warning.withValues(alpha: 0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Icon(
              Icons.cloud_off,
              size: AppDimensions.iconMd,
              color: colors.warning,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.authOfflineBannerTitle,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.warning,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.authOfflineBannerBody,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.warning,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                foregroundColor: colors.warning,
                backgroundColor: scheme.surface,
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: colors.warning.withValues(alpha: 0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.input),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs,
                ),
              ),
              child: Text(l10n.authOfflineRetry),
            ),
          ],
        ),
      ),
    );
  }
}
