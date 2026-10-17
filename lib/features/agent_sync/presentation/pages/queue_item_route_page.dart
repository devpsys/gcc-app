import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_detail_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_status.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_queue_cubit.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_queue_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/pages/queue_item_page.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_item_summary.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:go_router/go_router.dart';

/// Route-level entry for one queued submission.
///
/// Reads the item the queue already holds. Fields the draft did not carry stay
/// blank, and the page does not invent a file size or a bounty figure.
class QueueItemRoutePage extends StatelessWidget {
  const QueueItemRoutePage({required this.reference, super.key});

  final String reference;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncQueueCubit, SyncQueueState>(
      builder: (context, state) {
        if (state is! SyncQueueLoaded) {
          return const Scaffold(body: Center(child: AppLoadingIndicator()));
        }
        final matches = state.items.where(
          (item) => item.reference == reference,
        );
        if (matches.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(reference)),
            body: Center(child: Text(context.l10n.syncItemMissing)),
          );
        }
        final item = matches.first;
        if (item.status == QueueItemStatus.queued ||
            item.status == QueueItemStatus.uploading) {
          return QueueItemSummary(
            reference: item.reference,
            shopName: item.shopName,
            owner: item.owner,
            location: item.location,
            capturedAt: item.capturedAt,
          );
        }
        final detail = item.status == QueueItemStatus.synced
            ? QueueItemDetailState.synced
            : QueueItemDetailState.failed;
        return QueueItemPage(
          state: detail,
          reference: item.reference,
          shopName: item.shopName,
          owner: item.owner,
          location: item.location,
          capturedAt: item.capturedAt,
          files: const [],
          failureReason: item.failureReason,
          syncedAt: item.syncedAt,
          onRetry: () => context.read<SyncQueueCubit>().retry(item.reference),
          onViewSubmission: () =>
              GoRouter.maybeOf(context)
                  ?.push('${RoutePaths.agentBountyStatus}/$reference'),
        );
      },
    );
  }
}
