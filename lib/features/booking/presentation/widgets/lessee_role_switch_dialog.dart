import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

/// What Vendor mode unlocks. Wallet and history stay.
List<String> lesseeModeGains(BuildContext context) {
  final l10n = context.l10n;
  return [
    l10n.lesseeProfileGainRequests,
    l10n.lesseeProfileGainCatalog,
    l10n.lesseeProfileGainVideos,
  ];
}

/// Bottom sheet confirming a switch to vendor mode (MOB-LSE-17 frame 2).
class LesseeRoleSwitchSheet extends StatelessWidget {
  const LesseeRoleSwitchSheet({
    required this.name,
    required this.onConfirm,
    required this.onStay,
    super.key,
  });

  final String name;
  final VoidCallback onConfirm;
  final VoidCallback onStay;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final gains = lesseeModeGains(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.outline,
              borderRadius: BorderRadius.circular(AppRadii.pill),
            ),
            child: const SizedBox(
              width: AppDimensions.sheetHandleWidth,
              height: AppDimensions.sheetHandleHeight,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              shape: BoxShape.circle,
              border: Border.all(
                color: scheme.primary.withValues(alpha: 0.25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Icon(
                Icons.swap_horiz,
                size: AppDimensions.iconLg,
                color: scheme.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.lesseeProfileSwitchTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.lesseeProfileSwitchBody(name),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(color: colors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.lesseeProfileSwitchGains.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final line in gains)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '✓',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: colors.success,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              line,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Divider(height: AppSpacing.md, color: colors.border),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: AppDimensions.iconSm,
                        color: scheme.primary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          l10n.lesseeProfileSwitchStill,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.lesseeProfileSwitchConfirm,
            icon: Icons.arrow_forward,
            onPressed: onConfirm,
          ),
          const SizedBox(height: AppSpacing.xs),
          AppSecondaryButton(
            label: l10n.lesseeProfileSwitchStay,
            onPressed: onStay,
          ),
        ],
      ),
    );
  }
}

Future<bool> showLesseeRoleSwitchDialog(
  BuildContext context, {
  required String name,
}) async {
  final confirmed = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: false,
    builder: (sheetContext) {
      return SafeArea(
        child: LesseeRoleSwitchSheet(
          name: name,
          onConfirm: () => Navigator.of(sheetContext).pop(true),
          onStay: () => Navigator.of(sheetContext).pop(false),
        ),
      );
    },
  );
  return confirmed ?? false;
}
