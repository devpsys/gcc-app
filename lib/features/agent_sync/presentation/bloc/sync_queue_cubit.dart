import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/sync_queue_gateway.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_queue_state.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';

/// Drives the offline queue screen.
///
/// Sealed states, like the other presentation cubits in the app: the queue is
/// either loading, loaded, or failed, and the failed state carries the failure
/// so the screen can explain itself rather than showing a bare error.
class SyncQueueCubit extends Cubit<SyncQueueState> {
  SyncQueueCubit(this._gateway) : super(const SyncQueueLoading());
  final SyncQueueGateway _gateway;

  /// Reloads the summary and the item list together, so the counts in the
  /// status panel can never disagree with the cards below them.
  Future<void> load() async {
    emit(const SyncQueueLoading());
    await _read();
  }

  Future<void> retry(String reference) async {
    await _gateway.retrySubmission(reference);
    await _read();
  }

  Future<void> discard(String reference) async {
    await _gateway.discardSubmission(reference);
    await _read();
  }

  Future<void> _read() async {
    try {
      final results = await Future.wait([
        _gateway.loadSummary(),
        _gateway.loadItems(),
      ]);
      emit(
        SyncQueueLoaded(
          summary: results[0] as SyncSummary,
          items: results[1] as List<QueueItem>,
        ),
      );
    } on Failure catch (failure) {
      emit(SyncQueueFailed(failure));
    }
  }
}
