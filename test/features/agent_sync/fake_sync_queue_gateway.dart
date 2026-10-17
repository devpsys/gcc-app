import 'package:gcc_app/features/agent_sync/presentation/bloc/conflict_claim.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/connection_quality.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_detail_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/sync_queue_gateway.dart';

/// A gateway that reports an empty queue, matching the unwired one.
///
/// Used to prove the screen's empty path never claims a success it did not get.
class FakeSyncQueueGateway implements SyncQueueGateway {
  FakeSyncQueueGateway({
    this.summary = const SyncSummary(
      connection: ConnectionQuality.offline,
      lastSync: '',
      storageFree: '',
      storageTotal: '',
      queuedCount: 0,
      queuedBytes: '',
    ),
    this.items = const [],
  });

  final SyncSummary summary;
  final List<QueueItem> items;

  final List<String> retried = [];
  final List<String> discarded = [];

  @override
  Future<SyncSummary> loadSummary() async => summary;

  @override
  Future<List<QueueItem>> loadItems() async => items;

  @override
  Future<void> retrySubmission(String reference) async =>
      retried.add(reference);

  @override
  Future<void> discardSubmission(String reference) async =>
      discarded.add(reference);

  @override
  Future<QueueItemDetailState?> loadDetail(String reference) async => null;

  @override
  Future<ConflictClaim?> loadConflict(String reference) async => null;
}
