import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_state.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_type.dart';

import '../../fake_capture_gateway.dart';

void main() {
  late FakeCaptureGateway gateway;
  final clock = DateTime.utc(2026, 10, 13, 10, 41);

  setUp(() {
    gateway = FakeCaptureGateway();
  });

  CaptureCubit cubit() => CaptureCubit(gateway, clock: () => clock);

  blocTest<CaptureCubit, CaptureState>(
    'keeps shop edits on the draft and blocks an incomplete continue',
    build: cubit,
    act: (cubit) {
      cubit.editShopName('Bola Hardware');
      cubit.editOwnerName('Alhaji Musa Ibrahim');
      expect(cubit.attemptShopContinue(), isFalse);
    },
    verify: (cubit) {
      final draft = cubit.state.draft;
      expect(draft.shopName, 'Bola Hardware');
      expect(draft.ownerName, 'Alhaji Musa Ibrahim');
      expect(draft.shopAttempted, isTrue);
      expect(draft.savedAt, clock);
    },
  );

  blocTest<CaptureCubit, CaptureState>(
    'accepts a shop that has a name, owner, phone, type, and category',
    build: cubit,
    act: (cubit) {
      cubit
        ..editShopName('Bola Hardware')
        ..editOwnerName('Alhaji Musa Ibrahim')
        ..editPhone('8034412290')
        ..selectShopType(ShopType.equipmentYard)
        ..toggleCategory(ShopCategory.generators);
      expect(cubit.attemptShopContinue(), isTrue);
    },
    verify: (cubit) {
      expect(cubit.state.draft.shopIsValid, isTrue);
      expect(cubit.state.draft.shopAttempted, isFalse);
    },
  );

  test('ignores a second submit while the first is in flight', () async {
    final hold = Completer<void>();
    gateway.pending = hold.future;
    final capture = cubit();
    final first = capture.submit();
    await capture.submit();
    expect(gateway.submits, 1);
    hold.complete();
    await first;
    expect(capture.state, isA<CaptureSubmitted>());
    await capture.close();
  });

  blocTest<CaptureCubit, CaptureState>(
    'clears the deeper spatial levels when a parent changes',
    build: cubit,
    act: (cubit) {
      cubit
        ..editMarket('Kugbo Market')
        ..editZone('Zone C')
        ..editLine('Line 4')
        ..editMarket('Wuse Market');
    },
    verify: (cubit) {
      final draft = cubit.state.draft;
      expect(draft.market, 'Wuse Market');
      expect(draft.zone, isEmpty);
      expect(draft.line, isEmpty);
    },
  );

  blocTest<CaptureCubit, CaptureState>(
    'surfaces a gateway failure',
    build: cubit,
    act: (cubit) {
      gateway.failure = const NetworkFailure();
      return cubit.submit();
    },
    expect: () => [
      const CaptureSubmitting(CaptureDraft()),
      const CaptureFailed(CaptureDraft(), NetworkFailure()),
    ],
  );
}
