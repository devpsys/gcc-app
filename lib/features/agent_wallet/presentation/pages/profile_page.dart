import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/core/widgets/app_switch_track.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/install_prompt_card.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/profile_header.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/settings_row.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/settings_section.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/storage_category_row.dart';

/// Agent profile and settings.
///
/// The design is explicit: **zero money context and zero lock glyphs**. There is
/// no bounty figure on this screen — the wallet is a separate destination, and
/// a profile that quoted earnings would read as a payment record.
class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.profile,
    required this.storageCategories,
    this.onOpenLanguage,
    this.onOpenNotifications,
    this.onInstall,
    this.onSignOut,
    this.onClearStorage,
    this.offlineCaptureAllowed = true,
    this.onOfflineCaptureChanged,
    super.key,
  });

  final AgentProfile profile;
  final List<StorageCategory> storageCategories;
  final VoidCallback? onOpenLanguage;
  final VoidCallback? onOpenNotifications;
  final VoidCallback? onInstall;
  final VoidCallback? onSignOut;

  /// Clears one storage category. Null withholds the clear affordance.
  final void Function(String label)? onClearStorage;

  final bool offlineCaptureAllowed;
  final ValueChanged<bool>? onOfflineCaptureChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            ProfileHeader(profile: profile),
            const SizedBox(height: AppSpacing.sm),
            SettingsSection(
              title: l10n.profileSectionPreferences,
              children: [
                SettingsRow(
                  label: l10n.profileRowLanguage,
                  value: l10n.authLanguage,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onOpenLanguage,
                ),
                SettingsRow(
                  label: l10n.profileRowNotifications,
                  value: l10n.profileRowSmsOnly,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onOpenNotifications,
                ),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionWork,
              children: [
                SettingsRow(
                  label: l10n.profileAssignedMarkets,
                  value: profile.coveredMarkets,
                ),
                if (profile.supportPhone != null)
                  // No dialer is wired up, so the row is shown but inert
                  // rather than accepting a tap that goes nowhere.
                  SettingsRow(label: l10n.profileRowSupportPhone),
              ],
            ),
            SettingsSection(
              title: l10n.profileRowStorage,
              children: [
                SettingsRow(
                  label: l10n.profileStorageFree,
                  detail: profile.coveredMarkets,
                  value: profile.agentId,
                  onTap: null,
                ),
                for (final category in storageCategories)
                  StorageCategoryRow(
                    category: category,
                    onClear: onClearStorage == null
                        ? null
                        : () => onClearStorage!(category.label),
                  ),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionThisDevice,
              children: [
                SettingsRow(
                  label: l10n.profileRowModel,
                  value: l10n.profileDeviceModelValue,
                ),
                SettingsRow(
                  label: l10n.profileRowAndroidVersion,
                  value: l10n.profileAndroidVersionValue,
                ),
                SettingsRow(
                  label: l10n.profileRowAppVersion,
                  value: l10n.profileAppVersion,
                ),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionOffline,
              children: [
                SettingsRow(
                  label: l10n.profileRowOfflineCapture,
                  trailing: AppSwitchTrack(
                    value: offlineCaptureAllowed,
                    onChanged: onOfflineCaptureChanged,
                  ),
                ),
              ],
            ),
            InstallPromptCard(onInstall: onInstall),
            const SizedBox(height: AppSpacing.sm),
            AppSecondaryButton(
              label: l10n.profileSignOut,
              expand: true,
              onPressed: onSignOut,
            ),
          ],
        ),
      ),
    );
  }
}
