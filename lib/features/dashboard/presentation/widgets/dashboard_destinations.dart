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
      _built(
        l10n.dashboardBrowse,
        Icons.manage_search_outlined,
        Icons.manage_search,
        RoutePaths.browse,
      ),
      _built(
        l10n.dashboardBookings,
        Icons.calendar_today_outlined,
        Icons.calendar_today,
        RoutePaths.bookings,
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
      ShellDestination(
        label: l10n.dashboardHome,
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        location: '${RoutePaths.home}?role=vendor',
      ),
      _built(
        l10n.dashboardCatalog,
        Icons.inventory_2_outlined,
        Icons.inventory_2,
        RoutePaths.vendorCatalog,
      ),
      _built(
        l10n.dashboardRequests,
        Icons.inbox_outlined,
        Icons.inbox,
        RoutePaths.vendorRequests,
        badgeCount: requestsBadge,
      ),
      _built(
        l10n.dashboardWallet,
        Icons.account_balance_wallet_outlined,
        Icons.account_balance_wallet,
        RoutePaths.vendorWallet,
      ),
      _built(
        l10n.dashboardProfile,
        Icons.person_outline,
        Icons.person,
        RoutePaths.vendorProfile,
      ),
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
      // These three were switched off through _item() while the features did
      // not exist. Map, queue and wallet are all built now, so they point at
      // real routes and are available again.
      _built(
        l10n.dashboardMap,
        Icons.map_outlined,
        Icons.map,
        RoutePaths.agentMap,
      ),
      _built(
        l10n.dashboardQueue,
        Icons.cloud_upload_outlined,
        Icons.cloud_upload,
        RoutePaths.agentQueue,
      ),
      _built(
        l10n.dashboardWallet,
        Icons.account_balance_wallet_outlined,
        Icons.account_balance_wallet,
        RoutePaths.agentWallet,
      ),
    ];
  }

  /// A destination whose feature exists, so it navigates for real.
  static ShellDestination _built(
    String label,
    IconData icon,
    IconData selectedIcon,
    String location, {
    int badgeCount = 0,
  }) {
    return ShellDestination(
      label: label,
      icon: icon,
      selectedIcon: selectedIcon,
      location: location,
      badgeCount: badgeCount,
    );
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
    return _built(
      l10n.dashboardWallet,
      Icons.account_balance_wallet_outlined,
      Icons.account_balance_wallet,
      RoutePaths.wallet,
    );
  }

  static ShellDestination _profile(AppLocalizations l10n) {
    return _built(
      l10n.dashboardProfile,
      Icons.person_outline,
      Icons.person,
      RoutePaths.profile,
    );
  }

}
