import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';
import 'package:go_router/go_router.dart';

class RouteErrorPage extends StatelessWidget {
  const RouteErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: ResponsiveContent(
        child: AppEmptyState(
          icon: Icons.search_off_outlined,
          title: l10n.routeNotFound,
          actionLabel: l10n.goHome,
          onAction: () => context.go(RoutePaths.home),
        ),
      ),
    );
  }
}
