import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_view_state.dart';

/// The field map's load result.
sealed class MapState extends Equatable {
  const MapState();
}

final class MapLoading extends MapState {
  const MapLoading();

  @override
  List<Object?> get props => const [];
}

final class MapReady extends MapState {
  const MapReady({required this.view, required this.roadLabels});

  final MapViewState view;
  final List<String> roadLabels;

  @override
  List<Object?> get props => [view, roadLabels];
}

final class MapFailed extends MapState {
  const MapFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
