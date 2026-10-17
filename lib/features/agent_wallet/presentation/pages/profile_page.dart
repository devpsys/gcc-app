import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
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
        toolbarHeight: AppDimensions.topBarHeight,
        title: Text(
          l10n.profileTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surface,
        elevation: 0,
        actions: [_languageChip(context)],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          children: [
            ProfileHeader(profile: profile),
            const SizedBox(height: AppSpacing.sm),
            SettingsSection(
              title: l10n.profileSectionPreferences,
              children: [
                SettingsRow(
                  icon: Icons.language,
                  label: l10n.profileRowLanguage,
                  value: l10n.authLanguage,
                  onTap: onOpenLanguage,
                ),
                SettingsRow(
                  icon: Icons.notifications_none,
                  label: l10n.profileRowNotifications,
                  value: l10n.profileRowSmsOnly,
                  onTap: onOpenNotifications,
                ),
              ],
            ),
            SettingsSection(
              title: l10n.profileSectionWork,
              children: [
                SettingsRow(
                  icon: Icons.place_outlined,
                  label: l10n.profileAssignedMarkets,
                  value: profile.coveredMarkets,
                ),
                if (profile.supportPhone != null)
                  // No dialer is wired up, so the row is shown but inert
                  // rather than accepting a tap that goes nowhere.
                  SettingsRow(
                    icon: Icons.phone_outlined,
                    label: l10n.profileSectionSupport,
                    value: profile.supportPhone,
                  ),
              ],
            ),
            SettingsSection(
              title: l10n.profileRowStorage,
              children: [
                SettingsRow(
                  icon: Icons.sd_storage_outlined,
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
                  icon: Icons.smartphone_outlined,
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
                  icon: Icons.cloud_off_outlined,
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
            SettingsSection(
              title: l10n.profileSectionAccount,
              children: [
                SettingsRow(
                  icon: Icons.logout,
                  label: l10n.profileSignOut,
                  destructive: true,
                  onTap: onSignOut,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageChip(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onOpenLanguage,
            customBorder: const StadiumBorder(),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                border: Border.all(color: scheme.outline),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: SizedBox(
                  height: AppSpacing.xxl,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.l10n.dashboardLanguageShort,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: AppDimensions.iconSm,
                        color: scheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
