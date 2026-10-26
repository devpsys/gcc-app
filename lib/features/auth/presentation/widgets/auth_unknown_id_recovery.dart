import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_scan_qr_button.dart';

/// Frame 03 “help, don't block” recovery for an unrecognized ID.
class AuthUnknownIdRecovery extends StatelessWidget {
  const AuthUnknownIdRecovery({
    required this.identifier,
    required this.onTryAgain,
    required this.onDifferentId,
    required this.onScanQr,
    required this.onCallCoordinator,
    required this.onWhatsApp,
    this.scanDisabledReason,
    super.key,
  });

  final String identifier;
  final VoidCallback onTryAgain;
  final VoidCallback onDifferentId;
  final VoidCallback? onScanQr;
  final VoidCallback onCallCoordinator;
  final VoidCallback onWhatsApp;
  final String? scanDisabledReason;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.dangerContainer,
            borderRadius: BorderRadius.circular(AppRadii.cardLarge),
            border: Border.all(
              color: colors.danger,
              width: AppDimensions.emphasisBorderWidth,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: colors.danger,
                      size: AppDimensions.iconMd,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      l10n.authUnknownIdentifierTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: colors.danger,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.authUnknownIdentifier(identifier),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onErrorContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.authTryAgain,
          icon: Icons.refresh,
          onPressed: onTryAgain,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: AuthScanQrButton(
                label: l10n.authScanQrShort,
                onPressed: onScanQr,
                disabledReason: scanDisabledReason,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: SizedBox(
                height: AppDimensions.minTouchTarget,
                child: OutlinedButton.icon(
                  onPressed: onDifferentId,
                  icon: Icon(
                    Icons.edit_outlined,
                    size: AppDimensions.iconSm,
                    color: scheme.onSurfaceVariant,
                  ),
                  label: Text(
                    l10n.authDifferentId,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: scheme.onSurface,
                    side: BorderSide(color: colors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.input),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.secondaryContainer.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(AppRadii.cardLarge),
            border: Border.all(
              color: scheme.primary.withValues(alpha: 0.25),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.support_agent,
                  color: scheme.primary,
                  size: AppDimensions.iconMd,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.authCoordinatorTitle,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.primary,
                        ),
                      ),
                      Text(
                        l10n.authCoordinatorBody,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: scheme.onSecondaryContainer,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.xxs,
                        children: [
                          TextButton.icon(
                            onPressed: onCallCoordinator,
                            style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              foregroundColor: scheme.primary,
                            ),
                            icon: Icon(
                              Icons.call,
                              size: AppDimensions.iconSm,
                              color: scheme.primary,
                            ),
                            label: Text(
                              l10n.authCallCoordinator,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: onWhatsApp,
                            style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              foregroundColor: scheme.primary,
                            ),
                            icon: Icon(
                              Icons.chat,
                              size: AppDimensions.iconSm,
                              color: scheme.primary,
                            ),
                            label: Text(
                              l10n.authWhatsAppDesk,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
