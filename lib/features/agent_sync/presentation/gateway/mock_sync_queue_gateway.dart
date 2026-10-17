import 'package:gcc_app/features/agent_sync/presentation/bloc/conflict_claim.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/connection_quality.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_detail_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_status.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/sync_queue_gateway.dart';

/// In-memory queue used until the sync API exists.
///
/// Seeded with sample submissions so the queue screen is reviewable, and it
/// accepts captures the agent submits in this session. Those added items carry
/// only the fields the draft already had.
final class MockSyncQueueGateway implements SyncQueueGateway {
  MockSyncQueueGateway() {
    _items.addAll(_seed);
  }

  final List<QueueItem> _items = [];
  var _nextReference = 4000;

  /// The next submission id for a capture made in this session.
  String takeReference() {
    final reference = 'SUB-$_nextReference';
    _nextReference += 1;
    return reference;
  }

  static const _seed = <QueueItem>[
    QueueItem(
      reference: 'SUB-2214',
      shopName: 'Bola Hardware',
      capturedAt: '10:42',
      itemCount: 4,
      status: QueueItemStatus.queued,
      owner: 'Alhaji Musa Ibrahim',
      location: 'Kugbo Market · Zone C · Line 4',
    ),
    QueueItem(
      reference: 'SUB-2208',
      shopName: 'Amaka Electrical',
      capturedAt: '09:15',
      itemCount: 2,
      status: QueueItemStatus.failed,
      failureReason: 'The upload timed out before it finished.',
      owner: 'Amaka Obi',
      location: 'Kugbo Market · Zone A · Line 2',
    ),
  ];

  @override
  Future<void> enqueue(QueueItem item) async {
    _items.insert(0, item);
  }

  @override
  Future<SyncSummary> loadSummary() async {
    final waiting = _items
        .where(
          (item) =>
              item.status == QueueItemStatus.queued ||
              item.status == QueueItemStatus.uploading ||
              item.status == QueueItemStatus.failed,
        )
        .length;
    return SyncSummary(
      connection: ConnectionQuality.online,
      lastSync: '10:42',
      storageFree: '2.4 GB',
      storageTotal: '8 GB',
      queuedCount: waiting,
      queuedBytes: '',
    );
  }

  @override
  Future<List<QueueItem>> loadItems() async => List.unmodifiable(_items);

  @override
  Future<void> retrySubmission(String reference) async {
    final index = _indexOf(reference);
    if (index < 0) {
      return;
    }
    final item = _items[index];
    if (item.status != QueueItemStatus.failed) {
      return;
    }
    _items[index] = QueueItem(
      reference: item.reference,
      shopName: item.shopName,
      capturedAt: item.capturedAt,
      itemCount: item.itemCount,
      status: QueueItemStatus.queued,
      owner: item.owner,
      location: item.location,
    );
  }

  @override
  Future<void> discardSubmission(String reference) async {
    _items.removeWhere((item) => item.reference == reference);
  }

  @override
  Future<QueueItemDetailState?> loadDetail(String reference) async {
    final index = _indexOf(reference);
    if (index < 0) {
      return null;
    }
    return switch (_items[index].status) {
      QueueItemStatus.failed => QueueItemDetailState.failed,
      QueueItemStatus.synced => QueueItemDetailState.synced,
      QueueItemStatus.queued || QueueItemStatus.uploading => null,
    };
  }

  @override
  Future<ConflictClaim?> loadConflict(String reference) async => null;

  int _indexOf(String reference) =>
      _items.indexWhere((item) => item.reference == reference);
}
