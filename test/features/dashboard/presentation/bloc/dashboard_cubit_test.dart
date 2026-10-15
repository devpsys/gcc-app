import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_section_id.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_state.dart';

import '../../fake_dashboard_gateway.dart';

void main() {
  late FakeDashboardGateway gateway;

  setUp(() {
    gateway = FakeDashboardGateway();
  });

  blocTest<DashboardCubit, DashboardState>(
    'loads a ready snapshot',
    build: () => DashboardCubit(gateway),
    act: (cubit) => cubit.load(),
    expect: () => [
      const DashboardReady(DashboardRole.lessee, DashboardSnapshot()),
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'keeps the current snapshot visible while refreshing',
    build: () => DashboardCubit(gateway),
    seed: () => const DashboardReady(
      DashboardRole.lessee,
      DashboardSnapshot(place: 'Before'),
    ),
    act: (cubit) {
      gateway.snapshot = const DashboardSnapshot(place: 'After');
      return cubit.refresh();
    },
    expect: () => [
      const DashboardRefreshing(
        DashboardRole.lessee,
        DashboardSnapshot(place: 'Before'),
      ),
      const DashboardReady(
        DashboardRole.lessee,
        DashboardSnapshot(place: 'After'),
      ),
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'ignores a second refresh while one is running',
    build: () => DashboardCubit(gateway),
    seed: () => const DashboardReady(DashboardRole.lessee, DashboardSnapshot()),
    act: (cubit) async {
      gateway.refreshGate = Completer<void>();
      final first = cubit.refresh();
      final second = cubit.refresh();
      gateway.refreshGate!.complete();
      await Future.wait([first, second]);
    },
    verify: (_) {
      expect(gateway.refreshCount, 1);
    },
  );

  blocTest<DashboardCubit, DashboardState>(
    'keeps loaded sections when one section fails',
    build: () => DashboardCubit(gateway),
    act: (cubit) {
      gateway.snapshot = const DashboardSnapshot(
        place: 'Kugbo Market',
        failedSection: DashboardSectionId.earnings,
      );
      return cubit.load();
    },
    expect: () => [
      const DashboardPartial(
        DashboardRole.lessee,
        DashboardSnapshot(
          place: 'Kugbo Market',
          failedSection: DashboardSectionId.earnings,
        ),
        DashboardSectionId.earnings,
      ),
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'reports a full load failure',
    build: () => DashboardCubit(gateway),
    act: (cubit) {
      gateway.loadFailure = const NetworkFailure();
      return cubit.load();
    },
    expect: () => [
      const DashboardFailure(DashboardRole.lessee, NetworkFailure()),
    ],
  );
}
