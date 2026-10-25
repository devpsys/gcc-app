import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_profile_row.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_profile_section.dart';

/// Lean lessee profile — language and account preferences for App B.
class LesseeProfilePage extends StatelessWidget {
  const LesseeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppShell(
      title: l10n.dashboardProfile,
      menuLabel: l10n.openNavigationMenu,
      selectedLocation: RoutePaths.profile,
      navigationStyle: ShellNavigationStyle.topTabs,
      destinations: DashboardDestinations.lessee(l10n),
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.lesseeProfileTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.lesseeProfileBody,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.semanticColors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
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
            ],
          ),
        ],
      ),
    );
  }
}
