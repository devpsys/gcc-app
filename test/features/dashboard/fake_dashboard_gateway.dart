import 'dart:async';

import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/gateway/dashboard_gateway.dart';

class FakeDashboardGateway implements DashboardGateway {
  DashboardSnapshot snapshot = const DashboardSnapshot();
  Failure? loadFailure;
  Failure? refreshFailure;
  Completer<void>? refreshGate;
  int refreshCount = 0;

  @override
  Future<DashboardSnapshot> load(DashboardRole role) async {
    final failure = loadFailure;
    if (failure != null) {
      throw failure;
    }
    return snapshot;
  }

  @override
  Future<DashboardSnapshot> refresh(DashboardRole role) async {
    refreshCount += 1;
    final gate = refreshGate;
    if (gate != null) {
      await gate.future;
    }
    final failure = refreshFailure;
    if (failure != null) {
      throw failure;
    }
    return snapshot;
  }
}
