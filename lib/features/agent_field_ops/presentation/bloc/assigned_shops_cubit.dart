import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/assigned_shops_gateway.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shops_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';

/// Drives the work list.
///
/// Loads the stops and the counts together so the filter shortcut's number can
/// never disagree with the rows it filters.
class AssignedShopsCubit extends Cubit<AssignedShopsState> {
  AssignedShopsCubit(this._gateway) : super(const AssignedShopsLoading());

  final AssignedShopsGateway _gateway;

  Future<void> load() async {
    emit(const AssignedShopsLoading());
    try {
      final results = await Future.wait([
        _gateway.loadShops(),
        _gateway.loadAttentionCount(),
        _gateway.loadMarketCount(),
        _gateway.loadRouteSummary(),
      ]);
      emit(
        AssignedShopsLoaded(
          shops: results[0] as List<AssignedShop>,
          attentionCount: results[1] as int,
          marketCount: results[2] as int,
          summary: results[3] as RouteSummary?,
        ),
      );
    } on Failure catch (failure) {
      emit(AssignedShopsFailed(failure));
    }
  }
}
