import 'package:gcc_app/features/agent_sync/presentation/bloc/conflict_claim.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_detail_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';

/// Presentation-layer contract for the offline queue.
///
/// The queue is device-local, so this needs no backend contract yet. It exists
/// so the screens never reach for storage or network code directly, and so the
/// unwired implementation can be swapped for a real one without touching a
/// widget.
abstract interface class SyncQueueGateway {
  /// Returns the current queue. An unwired implementation returns empty.
  Future<SyncSummary> loadSummary();

  /// Returns the queued submissions. Unwired returns empty.
  Future<List<QueueItem>> loadItems();

  /// Records a submission the agent just captured.
  ///
  /// The item must carry only what the draft already has. An unwired
  /// implementation ignores it.
  Future<void> enqueue(QueueItem item);

  /// Asks the platform to retry one failed submission.
  Future<void> retrySubmission(String reference);

  /// Removes a submission from the device. Confirmation is the caller's job.
  Future<void> discardSubmission(String reference);

  /// Returns the frame a submission should show. Unwired returns null.
  Future<QueueItemDetailState?> loadDetail(String reference);

  /// A peer claim that blocks this submission, when there is one.
  Future<ConflictClaim?> loadConflict(String reference);
}
