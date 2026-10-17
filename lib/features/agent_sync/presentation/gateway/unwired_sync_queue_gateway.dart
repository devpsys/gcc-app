import 'package:gcc_app/features/agent_sync/presentation/bloc/conflict_claim.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/connection_quality.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_detail_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/sync_queue_gateway.dart';

/// Returns empty rather than inventing submissions.
///
/// No sync or storage layer exists yet, so this deliberately reports an empty
/// queue instead of fabricating shops, sizes or transfers. That keeps the
/// screens honest about having nothing to show.
final class UnwiredSyncQueueGateway implements SyncQueueGateway {
  const UnwiredSyncQueueGateway();

  @override
  Future<SyncSummary> loadSummary() async => const SyncSummary(
    connection: ConnectionQuality.offline,
    lastSync: '',
    storageFree: '',
    storageTotal: '',
    queuedCount: 0,
    queuedBytes: '',
  );

  @override
  Future<List<QueueItem>> loadItems() async => const [];

  @override
  Future<void> enqueue(QueueItem item) async {}

  @override
  Future<void> retrySubmission(String reference) async {}

  @override
  Future<void> discardSubmission(String reference) async {}

  @override
  Future<QueueItemDetailState?> loadDetail(String reference) async => null;

  @override
  Future<ConflictClaim?> loadConflict(String reference) async => null;
}
