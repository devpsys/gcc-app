import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_section_id.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gcc_app/features/dashboard/presentation/gateway/dashboard_gateway.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._gateway, {DashboardRole role = DashboardRole.lessee})
    : super(DashboardLoading(role));

  final DashboardGateway _gateway;

  Future<void> load() async {
    final role = state.role;
    if (state is! DashboardLoading) {
      emit(DashboardLoading(role));
    }
    try {
      _emitSnapshot(role, await _gateway.load(role));
    } on Failure catch (failure) {
      emit(DashboardFailure(role, failure));
    }
  }

  Future<void> refresh() async {
    if (state is DashboardRefreshing) {
      return;
    }
    final role = state.role;
    final current = state.content;
    if (current == null) {
      await load();
      return;
    }
    emit(DashboardRefreshing(role, current));
    try {
      _emitSnapshot(role, await _gateway.refresh(role));
    } on Failure catch (failure) {
      emit(DashboardFailure(role, failure));
    }
  }

  Future<void> retrySection(DashboardSectionId section) => refresh();

  Future<void> selectRole(DashboardRole role) async {
    if (role == state.role || state is DashboardRefreshing) {
      return;
    }
    emit(DashboardLoading(role));
    await load();
  }

  void _emitSnapshot(DashboardRole role, DashboardSnapshot snapshot) {
    final failed = snapshot.failedSection;
    if (failed == null) {
      emit(DashboardReady(role, snapshot));
      return;
    }
    emit(DashboardPartial(role, snapshot, failed));
  }
}
