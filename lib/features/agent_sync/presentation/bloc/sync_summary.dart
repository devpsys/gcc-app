import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/connection_quality.dart';

/// Device-level sync facts shown in the status panel.
class SyncSummary extends Equatable {
  const SyncSummary({
    required this.connection,
    required this.lastSync,
    required this.storageFree,
    required this.storageTotal,
    required this.queuedCount,
    required this.queuedBytes,
    this.overallProgress,
  });
  final ConnectionQuality connection;

  /// e.g. `09:24`, `In progress…` or `Just now`.
  final String lastSync;
  final String storageFree;
  final String storageTotal;
  final int queuedCount;
  final String queuedBytes;

  /// Whole-batch progress 0 to 1, present only while syncing.
  final double? overallProgress;

  /// Share of storage still free, 0 to 1.
  double get storageFraction {
    final free = double.tryParse(storageFree.split(' ').first);
    final total = double.tryParse(storageTotal.split(' ').first);
    if (free == null || total == null || total == 0) {
      return 0;
    }
    return (free / total).clamp(0.0, 1.0);
  }

  @override
  List<Object?> get props => [
    connection,
    lastSync,
    storageFree,
    storageTotal,
    queuedCount,
    queuedBytes,
    overallProgress,
  ];
}
