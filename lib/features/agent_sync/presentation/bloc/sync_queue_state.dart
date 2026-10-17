import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';

sealed class SyncQueueState extends Equatable {
  const SyncQueueState();
  @override
  List<Object?> get props => const [];
}

final class SyncQueueLoading extends SyncQueueState {
  const SyncQueueLoading();
}

final class SyncQueueLoaded extends SyncQueueState {
  const SyncQueueLoaded({required this.summary, required this.items});
  final SyncSummary summary;
  final List<QueueItem> items;
  @override
  List<Object?> get props => [summary, items];
}

final class SyncQueueFailed extends SyncQueueState {
  const SyncQueueFailed(this.failure);
  final Failure failure;
  @override
  List<Object?> get props => [failure];
}
