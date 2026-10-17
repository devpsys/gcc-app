import 'package:equatable/equatable.dart';

/// The three figures across the top of the work list.
class RouteSummary extends Equatable {
  const RouteSummary({
    required this.done,
    required this.total,
    required this.captured,
    required this.routeDistance,
  });

  /// Stops finished on today's route.
  final int done;

  /// Stops assigned in total.
  final int total;

  /// Stops captured, which can exceed [done] when work is still uploading.
  final int captured;

  /// e.g. `18.4 km`.
  final String routeDistance;

  @override
  List<Object?> get props => [done, total, captured, routeDistance];
}
