import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_file_state.dart';

/// One file attached to a submission.
class QueueFile extends Equatable {
  const QueueFile({
    required this.name,
    required this.sizeLabel,
    required this.state,
    this.syncedAt,
  });
  final String name;
  final String sizeLabel;
  final QueueFileState state;

  /// When the file reached the server.
  final String? syncedAt;
  @override
  List<Object?> get props => [name, sizeLabel, state, syncedAt];
}
