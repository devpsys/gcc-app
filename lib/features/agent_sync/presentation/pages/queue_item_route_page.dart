import 'package:flutter/material.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_file.dart';
import 'package:gcc_app/features/agent_sync/presentation/pages/queue_item_page.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:go_router/go_router.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_file_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_detail_state.dart';

/// Route-level entry for one queued submission.
///
/// Detail is loaded by the cubit once a storage layer exists; until then the
/// route renders the failed frame so the screen is reachable and honest about
/// what it knows.
class QueueItemRoutePage extends StatelessWidget {
  const QueueItemRoutePage({this.reference = 'SUB-2214', super.key});

  /// Taken from the route so the screen works for any queued submission.
  final String reference;
  @override
  Widget build(BuildContext context) {
    return QueueItemPage(
      state: QueueItemDetailState.failed,
      reference: reference,
      shopName: 'Bola Hardware',
      owner: 'Alhaji Musa Ibrahim',
      location: 'Kugbo · Zone C · Line 4',
      capturedAt: '13 Oct, 10:42',
      files: [
        QueueFile(
          name: 'shopfront-1042.jpg',
          sizeLabel: '1.4 MB',
          state: QueueFileState.failed,
        ),
        QueueFile(
          name: 'condition-clip-1042.mp4',
          sizeLabel: '6.2 MB',
          state: QueueFileState.failed,
        ),
      ],
      failureReason: 'Network timeout after 60 s',
      onViewSubmission: () =>
          GoRouter.maybeOf(context)
              ?.push('${RoutePaths.agentBountyStatus}/$reference'),
    );
  }
}
