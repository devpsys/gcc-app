import 'package:flutter/material.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/shell_destination.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

abstract final class DashboardDestinations {
  static List<ShellDestination> lessee(
    AppLocalizations l10n, {
    int bookingsBadge = 0,
  }) {
    return [
      _home(l10n),
      _item(
        l10n.dashboardBrowse,
        Icons.manage_search_outlined,
        Icons.manage_search,
        '/browse',
        l10n,
      ),
      _item(
        l10n.dashboardBookings,
        Icons.calendar_today_outlined,
        Icons.calendar_today,
        '/bookings',
        l10n,
        badgeCount: bookingsBadge,
      ),
      _wallet(l10n),
      _profile(l10n),
    ];
  }

  static List<ShellDestination> vendor(
    AppLocalizations l10n, {
    int requestsBadge = 0,
  }) {
    return [
      _home(l10n),
      _item(
        l10n.dashboardCatalog,
        Icons.inventory_2_outlined,
        Icons.inventory_2,
        '/catalog',
        l10n,
      ),
      _item(
        l10n.dashboardRequests,
        Icons.inbox_outlined,
        Icons.inbox,
        '/requests',
        l10n,
        badgeCount: requestsBadge,
      ),
      _wallet(l10n),
      _profile(l10n),
    ];
  }

  static List<ShellDestination> agent(AppLocalizations l10n) {
    return [
      ShellDestination(
        label: l10n.dashboardToday,
        icon: Icons.today_outlined,
        selectedIcon: Icons.today,
        location: RoutePaths.agentToday,
      ),
      _item(l10n.dashboardMap, Icons.map_outlined, Icons.map, '/map', l10n),
      _item(
        l10n.dashboardQueue,
        Icons.cloud_upload_outlined,
        Icons.cloud_upload,
        '/queue',
        l10n,
      ),
      _wallet(l10n),
    ];
  }

  static ShellDestination _home(AppLocalizations l10n) {
    return ShellDestination(
      label: l10n.dashboardHome,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      location: RoutePaths.home,
    );
  }

  static ShellDestination _wallet(AppLocalizations l10n) {
    return _item(
      l10n.dashboardWallet,
      Icons.account_balance_wallet_outlined,
      Icons.account_balance_wallet,
      '/wallet',
      l10n,
    );
  }

  static ShellDestination _profile(AppLocalizations l10n) {
    return _item(
      l10n.dashboardProfile,
      Icons.person_outline,
      Icons.person,
      '/profile',
      l10n,
    );
  }

  static ShellDestination _item(
    String label,
    IconData icon,
    IconData selectedIcon,
    String location,
    AppLocalizations l10n, {
    int badgeCount = 0,
  }) {
    return ShellDestination(
      label: label,
      icon: icon,
      selectedIcon: selectedIcon,
      location: location,
      available: false,
      unavailableReason: l10n.dashboardActionUnavailable,
      badgeCount: badgeCount,
    );
  }
}
