import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_download_step.dart';

/// A single line in the download progress list.
class MapDownloadLine extends Equatable {
  const MapDownloadLine({required this.step, required this.detail});
  final MapDownloadStep step;

  /// e.g. `Tile 24/81`.
  final String detail;
  @override
  List<Object?> get props => [step, detail];
}
