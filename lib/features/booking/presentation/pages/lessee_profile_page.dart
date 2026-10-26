import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/features/booking/domain/lessee_profile.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_profile_device_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_profile_header.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_profile_row.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_profile_section.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_profile_support_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_profile_top_bar.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_role_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_role_switch_dialog.dart';

class LesseeProfilePage extends StatelessWidget {
  const LesseeProfilePage({
    required this.profile,
    required this.onSwitchToVendor,
    required this.onSignOut,
    this.onOpenNotifications,
    this.onOpenBookings,
    this.onInstall,
    this.onCallSupport,
    super.key,
  });

  final LesseeProfile profile;
  final Future<void> Function() onSwitchToVendor;
  final VoidCallback onSignOut;
  final VoidCallback? onOpenNotifications;
  final VoidCallback? onOpenBookings;
  final VoidCallback? onInstall;
  final VoidCallback? onCallSupport;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
      children: [
        LesseeProfileTopBar(
          greetingName: profile.greetingName,
          initials: profile.initials,
          installLabel: l10n.profileInstallTitle,
          onInstall: onInstall,
        ),
        Expanded(
          child: ListView(
            primary: false,
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              LesseeProfileHeader(
                profile: profile,
                sinceLabel: l10n.lesseeProfileSince(
                  profile.memberSince,
                  profile.bookingCount,
                  profile.completedCount,
                ),
              ),
              if (profile.canSwitchToVendor) ...[
                const SizedBox(height: AppSpacing.md),
                LesseeRoleCard(
                  eyebrow: l10n.lesseeProfileDualAuthority,
                  body: l10n.lesseeProfileDualBody,
                  switchLabel: l10n.lesseeProfileSwitchMode,
                  onAskSwitch: () => _ask(context),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              LesseeProfileSection(
                title: l10n.lesseeProfileActivity,
                child: Column(
                  children: [
                    LesseeProfileRow(
                      icon: Icons.event_note_outlined,
                      label: l10n.lesseeProfileActiveBookings,
                      badge: l10n.lesseeProfileActiveCount(
                        profile.activeBookings,
                      ),
                      iconColor: scheme.primary,
                      onTap: onOpenBookings,
                    ),
                    Divider(height: 1, color: colors.border),
                    LesseeProfileRow(
                      icon: Icons.history,
                      label: l10n.lesseeProfileRentalHistory,
                      value: l10n.lesseeProfileCompletedCount(
                        profile.completedCount,
                      ),
                      onTap: onOpenBookings,
                    ),
                    Divider(height: 1, color: colors.border),
                    LesseeProfileRow(
                      icon: Icons.credit_card_outlined,
                      label: l10n.lesseeProfileSavedCards,
                      value: l10n.lesseeProfileCardsCount(profile.savedCards),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              LesseeProfileSection(
                title: l10n.profileSectionPreferences,
                child: Column(
                  children: [
                    LesseeProfileRow(
                      icon: Icons.language,
                      label: l10n.profileRowLanguage,
                      value: l10n.languageEnglishName,
                      onTap: () => showAppLanguagePicker(
                        context: context,
                        selectedId: 'english',
                      ),
                    ),
                    Divider(height: 1, color: colors.border),
                    LesseeProfileRow(
                      icon: Icons.notifications_none,
                      label: l10n.profileRowNotifications,
                      value: profile.notificationSummary,
                      onTap: onOpenNotifications,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              LesseeProfileDeviceCard(profile: profile),
              const SizedBox(height: AppSpacing.md),
              LesseeProfileSupportCard(
                phone: profile.supportPhone,
                onCall: onCallSupport,
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: onSignOut,
                icon: Icon(
                  Icons.logout,
                  size: AppDimensions.iconSm,
                  color: colors.danger,
                ),
                label: Text(l10n.lesseeProfileSignOut),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.danger,
                  backgroundColor: colors.dangerContainer.withValues(
                    alpha: 0.55,
                  ),
                  side: BorderSide(color: colors.dangerBorder),
                  minimumSize: const Size(
                    double.infinity,
                    AppDimensions.buttonHeightCompact,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.card),
                  ),
                ),
              ),
            ],
          ),
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
