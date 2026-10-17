import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_status.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/mock_sync_queue_gateway.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/sync_queue_gateway.dart';
import 'package:gcc_app/features/agent_capture/presentation/gateway/capture_gateway.dart';

/// Hands a submitted capture to the in-memory queue.
///
/// Stands in for the upload API. The queued item is built from the draft:
/// shop name, owner, place, and how many assets were attached. It does not
/// invent a bounty or a file size.
final class MockCaptureGateway implements CaptureGateway {
  MockCaptureGateway(this._queue);

  final SyncQueueGateway _queue;

  @override
  Future<void> submitDraft(CaptureDraft draft) async {
    final saved = draft.savedAt ?? DateTime.now();
    final queue = _queue;
    final reference = queue is MockSyncQueueGateway
        ? queue.takeReference()
        : 'SUB-${saved.millisecondsSinceEpoch}';
    await _queue.enqueue(
      QueueItem(
        reference: reference,
        shopName: draft.shopName.trim(),
        capturedAt: _clock(saved),
        itemCount: draft.assets.length,
        status: QueueItemStatus.queued,
        owner: draft.ownerName.trim(),
        location: _place(draft),
      ),
    );
  }

  @override
  Future<void> discardSubmission(String reference) =>
      _queue.discardSubmission(reference);

  String _place(CaptureDraft draft) {
    final parts = [
      draft.market.trim(),
      draft.zone.trim(),
      draft.line.trim(),
    ].where((part) => part.isNotEmpty);
    return parts.join(' · ');
  }

  String _clock(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
