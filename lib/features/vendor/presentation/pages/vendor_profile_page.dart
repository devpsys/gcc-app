import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_profile.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_profile_header.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_profile_row.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_profile_section.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_role_card.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_role_switch_dialog.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_ussd_card.dart';

class VendorProfilePage extends StatelessWidget {
  const VendorProfilePage({
    required this.profile,
    required this.onSwitchToLessee,
    required this.onCopyUssd,
    required this.onSignOut,
    this.onOpenNotifications,
    super.key,
  });

  final VendorProfile profile;
  final Future<void> Function() onSwitchToLessee;
  final Future<void> Function() onCopyUssd;
  final VoidCallback onSignOut;
  final VoidCallback? onOpenNotifications;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      primary: false,
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        VendorProfileHeader(
          profile: profile,
          verifiedLabel: l10n.vendorProfileVerified,
        ),
        const SizedBox(height: AppSpacing.sm),
        VendorRoleCard(
          eyebrow: l10n.vendorProfileBoth,
          lesseeLabel: l10n.vendorProfileLessee,
          vendorLabel: l10n.vendorProfileVendor,
          explanation: l10n.vendorProfileModeExplanation,
          kept: vendorModeKeeps(context),
          changesLabel: l10n.vendorProfileWhatChanges,
          onAskSwitch: () => _ask(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        VendorProfileSection(
          title: l10n.vendorProfileBusiness,
          children: [
            VendorProfileRow(
              icon: Icons.place_outlined,
              label: l10n.vendorProfileAddresses,
              value: '${profile.savedAddresses}',
              mono: true,
            ),
            VendorProfileRow(
              icon: Icons.account_balance_outlined,
              label: l10n.vendorProfilePayout,
              value: profile.payoutAccount,
              mono: true,
              verified: true,
            ),
            VendorProfileRow(
              icon: Icons.storefront_outlined,
              label: l10n.vendorProfileShop,
              value: profile.shopLocation,
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
          title: l10n.vendorProfileHelp,
          children: [
            VendorProfileRow(
              icon: Icons.phone_outlined,
              label: l10n.profileSectionSupport,
              value: profile.supportPhone,
              mono: true,
            ),
            VendorProfileRow(
              icon: Icons.info_outline,
              label: l10n.vendorProfileAbout,
              value: l10n.vendorProfileVersion(profile.version),
              mono: true,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        VendorUssdCard(
          eyebrow: l10n.vendorProfileUssdEyebrow,
          beforeCode: l10n.vendorProfileUssdBefore,
          code: profile.ussd,
          afterCode: l10n.vendorProfileUssdAfter,
          detail: l10n.vendorProfileUssdDetail,
          copyLabel: l10n.vendorProfileCopyCode(profile.ussd),
          onCopy: onCopyUssd,
        ),
        const SizedBox(height: AppSpacing.sm),
        VendorProfileSection(
          title: l10n.profileSectionAccount,
          children: [
            VendorProfileRow(
              icon: Icons.logout,
              label: l10n.profileSignOut,
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
    final confirmed = await showVendorRoleSwitchDialog(context);
    if (!confirmed || !context.mounted) {
      return;
    }
    onSwitchToLessee();
  }
}
