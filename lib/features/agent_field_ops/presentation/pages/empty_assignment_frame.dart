import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/empty_route_panel.dart';

/// The screen shown when the agent has no stops assigned at all.
///
/// Distinct from the completed route: no stops is something a supervisor fixes,
/// not something the agent achieved, so there is no success treatment here.
class EmptyAssignmentFrame extends StatelessWidget {
  const EmptyAssignmentFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.shopsTitle),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: const EmptyRoutePanel(),
          ),
        ),
      ),
    );
  }
}
