import 'dart:async';

import 'package:gcc_app/core/network/online_checker.dart';

/// Test / in-memory [OnlineChecker] with a pushable online flag.
final class ControllableOnlineChecker implements OnlineChecker {
  ControllableOnlineChecker({this.isOnline = true});

  bool isOnline;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  void setOnline(bool online) {
    if (isOnline == online) {
      return;
    }
    isOnline = online;
    if (!_controller.isClosed) {
      _controller.add(isOnline);
    }
  }

  @override
  Future<bool> check() async => isOnline;

  @override
  Stream<bool> watch() async* {
    yield isOnline;
    yield* _controller.stream;
  }

  Future<void> dispose() => _controller.close();
}
