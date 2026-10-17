import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_center_action.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';

/// The agent chrome shared by every agent destination outside the capture
/// wizard: map, queue, assigned shops and wallet.
///
/// The designs put the same bottom navigation under all of them, so this wraps
/// [AppShell] once with the agent destinations and the capture centre action
/// rather than letting each screen re-derive it — and drift.
///
/// Each screen keeps its own title bar, because they are not identical: the map
/// frames a compact strip, the queue a full title. This shell supplies only the
/// navigation, with [showAppBar] off, so the page's own bar stays authoritative.
class AgentShell extends StatelessWidget {
  const AgentShell({
    required this.selectedLocation,
    required this.title,
    required this.child,
    this.showAppBar = false,
    super.key,
  });

  /// Which agent tab this screen is, so the bar highlights correctly.
  final String selectedLocation;

  /// Used for the drawer and the medium-width rail heading.
  final String title;
  final Widget child;

  /// Off by default: the child screens draw their own title bar.
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppShell(
      title: title,
      menuLabel: l10n.openNavigationMenu,
      showAppBar: showAppBar,
      selectedLocation: selectedLocation,
      destinations: DashboardDestinations.agent(l10n),
      centerAction: ShellCenterAction(
        label: l10n.dashboardCapture,
        icon: Icons.photo_camera_outlined,
        onPressed: () =>
            GoRouter.maybeOf(context)?.push(RoutePaths.captureShop),
      ),
      child: child,
    );
  }
}
