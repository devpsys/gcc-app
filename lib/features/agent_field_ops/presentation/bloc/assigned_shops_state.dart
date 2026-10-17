import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';

/// Sealed states for the work list, as elsewhere in the app.
sealed class AssignedShopsState extends Equatable {
  const AssignedShopsState();

  @override
  List<Object?> get props => const [];
}

final class AssignedShopsLoading extends AssignedShopsState {
  const AssignedShopsLoading();
}

final class AssignedShopsLoaded extends AssignedShopsState {
  const AssignedShopsLoaded({
    required this.shops,
    required this.attentionCount,
    required this.marketCount,
    this.summary,
  });

  final List<AssignedShop> shops;
  final int attentionCount;
  final int marketCount;

  /// Null when the gateway has no route figures to report.
  final RouteSummary? summary;

  @override
  List<Object?> get props => [shops, attentionCount, marketCount, summary];
}

final class AssignedShopsFailed extends AssignedShopsState {
  const AssignedShopsFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
