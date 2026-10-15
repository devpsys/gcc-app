import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_section_id.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';

sealed class DashboardState extends Equatable {
  const DashboardState(this.role);

  final DashboardRole role;

  DashboardSnapshot? get content => null;

  @override
  List<Object?> get props => [role];
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading(super.role);
}

final class DashboardReady extends DashboardState {
  const DashboardReady(super.role, this.snapshot);

  final DashboardSnapshot snapshot;

  @override
  DashboardSnapshot get content => snapshot;

  @override
  List<Object?> get props => [role, snapshot];
}

final class DashboardRefreshing extends DashboardState {
  const DashboardRefreshing(super.role, this.snapshot);

  final DashboardSnapshot snapshot;

  @override
  DashboardSnapshot get content => snapshot;

  @override
  List<Object?> get props => [role, snapshot];
}

final class DashboardPartial extends DashboardState {
  const DashboardPartial(super.role, this.snapshot, this.failedSection);

  final DashboardSnapshot snapshot;
  final DashboardSectionId failedSection;

  @override
  DashboardSnapshot get content => snapshot;

  @override
  List<Object?> get props => [role, snapshot, failedSection];
}

final class DashboardFailure extends DashboardState {
  const DashboardFailure(super.role, this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [role, failure];
}
