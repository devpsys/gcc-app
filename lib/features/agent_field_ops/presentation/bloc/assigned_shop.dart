import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop_status.dart';

/// One shop on the agent's assigned route.
class AssignedShop extends Equatable {
  const AssignedShop({
    required this.name,
    required this.location,
    required this.status,
    this.coordinates,
    this.distance,
    this.attentionReason,
    this.note,
  });

  final String name;

  /// Market, zone and line, e.g. `Kugbo Market · Zone C · Line 4`.
  final String location;
  final AssignedShopStatus status;

  /// `9.0580° N, 7.4100° E`, when the shop is pinned.
  final String? coordinates;

  /// `120 m away` or `1.2 km away`.
  final String? distance;

  /// Why a shop needs attention, e.g. `Reshoot requested — video too dark`.
  ///
  /// When set it replaces the coordinate line: the agent needs the reason more
  /// than they need the position.
  final String? attentionReason;

  /// Provenance line, e.g. `Verified 12 Oct by Amaka Obi`.
  final String? note;

  /// Whether this shop can be opened for capture.
  bool get isCapturable =>
      status == AssignedShopStatus.notStarted ||
      status == AssignedShopStatus.needsAttention;

  @override
  List<Object?> get props => [
    name,
    location,
    status,
    coordinates,
    distance,
    attentionReason,
    note,
  ];
}
