import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/network/controllable_online_checker.dart';
import 'package:gcc_app/core/network/online_status_cubit.dart';
import 'package:gcc_app/core/network/online_status_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ControllableOnlineChecker checker;

  setUp(() {
    checker = ControllableOnlineChecker();
  });

  tearDown(() async {
    await checker.dispose();
  });

  blocTest<OnlineStatusCubit, OnlineStatusState>(
    'resolves unknown then follows checker updates',
    build: () => OnlineStatusCubit(checker),
    act: (cubit) async {
      await pumpEventQueue();
      checker.setOnline(false);
      await pumpEventQueue();
      checker.setOnline(true);
      await pumpEventQueue();
    },
    expect: () => const [
      OnlineStatusState.online(),
      OnlineStatusState.offline(),
      OnlineStatusState.online(),
    ],
  );

  blocTest<OnlineStatusCubit, OnlineStatusState>(
    'refresh re-checks and can recover to online',
    build: () => OnlineStatusCubit(checker),
    act: (cubit) async {
      await pumpEventQueue();
      checker.setOnline(false);
      await pumpEventQueue();
      checker.isOnline = true;
      await cubit.refresh();
    },
    expect: () => const [
      OnlineStatusState.online(),
      OnlineStatusState.offline(),
      OnlineStatusState.online(),
    ],
  );

  blocTest<OnlineStatusCubit, OnlineStatusState>(
    'starts offline when the checker is already offline',
    build: () => OnlineStatusCubit(ControllableOnlineChecker(isOnline: false)),
    act: (cubit) => pumpEventQueue(),
    expect: () => const [OnlineStatusState.offline()],
  );
}
