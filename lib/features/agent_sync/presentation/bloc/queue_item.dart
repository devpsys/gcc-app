import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_status.dart';

/// One submission sitting in the offline queue.
class QueueItem extends Equatable {
  const QueueItem({
    required this.reference,
    required this.shopName,
    required this.capturedAt,
    required this.itemCount,
    required this.status,
    this.progress = 0,
    this.doneBytes,
    this.totalBytes,
    this.failureReason,
    this.syncedAt,
  });

  /// Stable submission id, e.g. `SUB-2214`.
  final String reference;
  final String shopName;

  /// When the agent captured it, e.g. `10:42`.
  final String capturedAt;

  /// Photos and videos attached.
  final int itemCount;
  final QueueItemStatus status;

  /// Upload progress 0 to 1 for the uploading state.
  final double progress;

  /// Bytes moved so far, e.g. `1.1 MB`.
  final String? doneBytes;
  final String? totalBytes;

  /// Why the upload failed, when it did.
  final String? failureReason;

  /// When it reached the server, once synced.
  final String? syncedAt;
  @override
  List<Object?> get props => [
    reference,
    shopName,
    capturedAt,
    itemCount,
    status,
    progress,
    doneBytes,
    totalBytes,
    failureReason,
    syncedAt,
  ];
}
