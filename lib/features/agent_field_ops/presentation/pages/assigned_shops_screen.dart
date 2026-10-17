import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shops_cubit.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shops_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/assigned_shops_page.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/empty_assignment_frame.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// Loads the assignment and hands it to [AssignedShopsPage].
///
/// Wrapped in [AgentShell] because the designs put the agent navigation under
/// every work-list frame, and because an assignment with no route to Today is a
/// dead end.
///
/// An assignment with no stops shows the empty frame, not a zeroed summary —
/// "nothing assigned" and "everything done" are different situations and must
/// not look the same.
class AssignedShopsScreen extends StatelessWidget {
  const AssignedShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignedShopsCubit, AssignedShopsState>(
      builder: (context, state) {
        return AgentShell(
          selectedLocation: RoutePaths.agentShops,
          title: context.l10n.shopsTitle,
          child: switch (state) {
            AssignedShopsLoading() => const Scaffold(
              body: Center(child: AppLoadingIndicator()),
            ),
            // Failures carry no user-facing copy, so name the kind rather than
            // inventing a message.
            AssignedShopsFailed(:final failure) => Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Text(
                    failure.runtimeType.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            AssignedShopsLoaded(:final shops, :final summary) => _loaded(
              context,
              shops: shops,
              summary: summary,
            ),
          },
        );
      },
    );
  }

  Widget _loaded(
    BuildContext context, {
    required List<AssignedShop> shops,
    required RouteSummary? summary,
  }) {
    if (shops.isEmpty) {
      return const EmptyAssignmentFrame();
    }
    return AssignedShopsPage(
      // A route with no figures cannot show a summary strip; fall back to
      // zeroes rather than inventing a distance.
      summary:
          summary ??
          const RouteSummary(done: 0, total: 0, captured: 0, routeDistance: ''),
      shops: shops,
    );
  }
}
