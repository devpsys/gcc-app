import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shops_cubit.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shops_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/assigned_shops_page.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/empty_assignment_frame.dart';

/// Loads the assignment and hands it to [AssignedShopsPage].
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
        switch (state) {
          case AssignedShopsLoading():
            return const Scaffold(body: Center(child: AppLoadingIndicator()));
          case AssignedShopsFailed(:final failure):
            // Failures carry no user-facing copy, so name the kind rather than
            // inventing a message.
            return Scaffold(
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
            );
          case AssignedShopsLoaded(:final shops, :final summary):
            if (shops.isEmpty) return const EmptyAssignmentFrame();
            return AssignedShopsPage(
              // A route with no figures cannot show a summary strip; fall back
              // to the empty frame rather than inventing zeroes.
              summary:
                  summary ??
                  const RouteSummary(
                    done: 0,
                    total: 0,
                    captured: 0,
                    routeDistance: '',
                  ),
              shops: shops,
            );
        }
      },
    );
  }
}
