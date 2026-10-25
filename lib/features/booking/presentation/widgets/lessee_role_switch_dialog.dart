import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

/// What Vendor mode shows. Wallet and history stay.
List<String> lesseeModeGains(BuildContext context) {
  final l10n = context.l10n;
  return [
    l10n.lesseeProfileGainRequests,
    l10n.lesseeProfileGainCatalog,
    l10n.lesseeProfileGainVideos,
  ];
}

/// Confirms a switch to vendor mode. Bookings stay intact.
class LesseeRoleSwitchDialog extends StatelessWidget {
  const LesseeRoleSwitchDialog({
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
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.88,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Icon(
                    Icons.sync_alt,
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadii.button),
                  border: Border.all(color: colors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.lesseeProfileSwitchGains,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      for (final line in gains)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.xxs,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '•',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  line,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: scheme.onSurfaceVariant,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Text(
                        l10n.lesseeProfileSwitchStill,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppPrimaryButton(
                label: l10n.lesseeProfileSwitchConfirm,
                onPressed: onConfirm,
              ),
              const SizedBox(height: AppSpacing.xs),
              AppSecondaryButton(
                label: l10n.lesseeProfileSwitchStay,
                onPressed: onStay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> showLesseeRoleSwitchDialog(
  BuildContext context, {
  required String name,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return LesseeRoleSwitchDialog(
        name: name,
        onConfirm: () => Navigator.of(dialogContext).pop(true),
        onStay: () => Navigator.of(dialogContext).pop(false),
      );
    },
  );
  return confirmed ?? false;
}
