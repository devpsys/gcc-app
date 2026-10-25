import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/features/booking/domain/lessee_profile.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_profile_header.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_role_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_role_switch_dialog.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_profile_row.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_profile_section.dart';

class LesseeProfilePage extends StatelessWidget {
  const LesseeProfilePage({
    required this.profile,
    required this.onSwitchToVendor,
    required this.onSignOut,
    this.onOpenNotifications,
    super.key,
  });

  final LesseeProfile profile;
  final Future<void> Function() onSwitchToVendor;
  final VoidCallback onSignOut;
  final VoidCallback? onOpenNotifications;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      primary: false,
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          l10n.lesseeProfileGreeting(profile.greetingName),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(AppRadii.button),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add_to_home_screen,
                  size: AppDimensions.iconSm,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.profileInstallTitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        LesseeProfileHeader(
          profile: profile,
          sinceLabel: l10n.lesseeProfileSince(
            profile.memberSince,
            profile.bookingCount,
            profile.completedCount,
          ),
        ),
        if (profile.canSwitchToVendor) ...[
          const SizedBox(height: AppSpacing.sm),
          LesseeRoleCard(
            eyebrow: l10n.lesseeProfileDualAuthority,
            body: l10n.lesseeProfileDualBody,
            lesseeLabel: l10n.vendorProfileLessee,
            vendorLabel: l10n.vendorProfileVendor,
            switchLabel: l10n.lesseeProfileSwitchMode,
            onAskSwitch: () => _ask(context),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        VendorProfileSection(
          title: l10n.lesseeProfileActivity,
          children: [
            VendorProfileRow(
              icon: Icons.event_available_outlined,
              label: l10n.lesseeProfileActiveBookings,
              value: l10n.lesseeProfileActiveCount(profile.activeBookings),
              mono: true,
            ),
            VendorProfileRow(
              icon: Icons.history,
              label: l10n.lesseeProfileRentalHistory,
              value: l10n.lesseeProfileCompletedCount(profile.completedCount),
              mono: true,
            ),
            VendorProfileRow(
              icon: Icons.credit_card_outlined,
              label: l10n.lesseeProfileSavedCards,
              value: l10n.lesseeProfileCardsCount(profile.savedCards),
              mono: true,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        VendorProfileSection(
          title: l10n.profileSectionPreferences,
          children: [
            VendorProfileRow(
              icon: Icons.language,
              label: l10n.profileRowLanguage,
              value: l10n.languageEnglishName,
              onTap: () => showAppLanguagePicker(
                context: context,
                selectedId: 'english',
              ),
            ),
            VendorProfileRow(
              icon: Icons.notifications_none,
              label: l10n.profileRowNotifications,
              value: profile.notificationSummary,
              onTap: onOpenNotifications,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        VendorProfileSection(
          title: l10n.lesseeProfileDevice,
          children: [
            VendorProfileRow(
              icon: Icons.phone_android,
              label: l10n.profileRowModel,
              value: profile.deviceModel,
              mono: true,
            ),
            VendorProfileRow(
              icon: Icons.layers_outlined,
              label: l10n.lesseeProfileOsPlatform,
              value: profile.devicePlatform,
              mono: true,
            ),
            VendorProfileRow(
              icon: Icons.info_outline,
              label: l10n.profileRowAppVersion,
              value: profile.appVersion,
              mono: true,
            ),
            VendorProfileRow(
              icon: Icons.videocam_outlined,
              label: l10n.profileRowOfflineCapture,
              value: profile.offlineCapture,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        VendorProfileSection(
          title: l10n.lesseeProfileSupport,
          children: [
            VendorProfileRow(
              icon: Icons.phone_outlined,
              label: l10n.lesseeProfileCallSupport,
              value: profile.supportPhone,
              mono: true,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        VendorProfileSection(
          title: l10n.profileSectionAccount,
          children: [
            VendorProfileRow(
              icon: Icons.logout,
              label: l10n.lesseeProfileSignOut,
              destructive: true,
              showChevron: false,
              onTap: onSignOut,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _ask(BuildContext context) async {
    final confirmed = await showLesseeRoleSwitchDialog(
      context,
      name: profile.name,
    );
    if (!confirmed || !context.mounted) {
      return;
    }
    onSwitchToVendor();
  }
}
