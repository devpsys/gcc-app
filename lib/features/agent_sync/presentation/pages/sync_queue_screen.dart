import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_queue_cubit.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_queue_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';
import 'package:gcc_app/features/agent_sync/presentation/pages/sync_queue_page.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/sync_queue_nothing_yet.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// Loads the queue and hands it to [SyncQueuePage].
///
/// Every branch is wrapped in [AgentShell] rather than only the loaded one: a
/// loading spinner with no navigation is just as much a dead end as a missing
/// one, and the designs show the bar under every frame.
///
/// The unwired gateway reports an empty queue with no last-sync time. That must
/// **not** render as "everything is synced" — nothing has synced. It shows a
/// neutral empty state instead, so the screen never claims a success that has
/// not happened.
class SyncQueueScreen extends StatelessWidget {
  const SyncQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncQueueCubit, SyncQueueState>(
      builder: (context, state) {
        return AgentShell(
          selectedLocation: RoutePaths.agentQueue,
          title: context.l10n.syncQueueTitle,
          child: switch (state) {
            SyncQueueLoading() => const Scaffold(
              body: Center(child: AppLoadingIndicator()),
            ),
            // Failures carry no user-facing copy, so name the kind rather than
            // inventing a message.
            SyncQueueFailed(:final failure) => Scaffold(
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
            SyncQueueLoaded(:final summary, :final items) => _loaded(
              context,
              summary: summary,
              items: items,
            ),
          },
        );
      },
    );
  }

  Widget _loaded(
    BuildContext context, {
    required SyncSummary summary,
    required List<QueueItem> items,
  }) {
    final cubit = context.read<SyncQueueCubit>();
    // Nothing has ever synced: that is not "everything is synced".
    if (items.isEmpty && summary.lastSync.isEmpty) {
      return const SyncQueueNothingYet();
    }
    return SyncQueuePage(
      summary: summary,
      items: items,
      onViewSubmitted: () =>
          GoRouter.maybeOf(context)?.go(RoutePaths.agentQueue),
      onDiscardFailed: (references) async {
        for (final reference in references) {
          await cubit.discard(reference);
        }
        await cubit.load();
        return true;
      },
    );
  }
}
