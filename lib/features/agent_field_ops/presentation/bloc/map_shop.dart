import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop_status.dart';

/// A shop pinned on the field map.
class MapShop extends Equatable {
  const MapShop({
    required this.name,
    required this.zone,
    required this.line,
    required this.distanceLabel,
    required this.status,
    this.isMine = false,
    this.provenance,
    this.reference,
    this.offset,
  });
  final String name;

  /// e.g. `Zone C`.
  final String zone;

  /// The bare line number, e.g. `4`. The word "Line" is part of the formatted
  /// string, so the model must not repeat it.
  final String line;

  /// e.g. `120 m away` or `at your location`.
  final String distanceLabel;
  final MapShopStatus status;

  /// Whether this agent captured it, which drives the filled pin.
  final bool isMine;

  /// e.g. `Verified 12 Oct by Amaka Obi` or `Captured 13 Oct 10:42 · SUB-2214`.
  final String? provenance;

  /// Submission id, when there is one.
  final String? reference;

  /// Normalised pin position within the canvas, 0 to 1 on both axes.
  ///
  /// The design places pins at fixed offsets inside the frame, so the canvas
  /// is driven by layout rather than by a tile projection.
  final ({double x, double y})? offset;
  @override
  List<Object?> get props => [
    name,
    zone,
    line,
    distanceLabel,
    status,
    isMine,
    provenance,
    reference,
    offset,
  ];
}
