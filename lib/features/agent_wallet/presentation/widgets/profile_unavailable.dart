import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Shown when the app holds no profile for this device.
///
/// Notification channels stay reachable here: they are a device setting, so
/// gating them behind an agent profile would leave them with no entry point.
class ProfileUnavailable extends StatelessWidget {
  const ProfileUnavailable({this.onOpenNotifications, super.key});

  final VoidCallback? onOpenNotifications;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final openNotifications = onOpenNotifications;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_off_outlined,
              size: AppDimensions.emptyStateIcon,
              color: scheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.profileUnavailableTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.profileUnavailableBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            if (openNotifications != null) ...[
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: openNotifications,
                child: Text(l10n.notificationsTitle),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
