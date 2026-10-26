import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/network/online_checker.dart';
import 'package:gcc_app/core/network/online_status_state.dart';

/// Streams device online / offline status for chrome like the auth banner.
class OnlineStatusCubit extends Cubit<OnlineStatusState> {
  OnlineStatusCubit(this._checker) : super(const OnlineStatusState.unknown()) {
    _subscription = _checker.watch().listen(
      _emit,
      onError: (_) => _emit(false),
    );
    _lifecycle = AppLifecycleListener(onResume: () {
      unawaited(refresh());
    });
  }

  final OnlineChecker _checker;
  StreamSubscription<bool>? _subscription;
  AppLifecycleListener? _lifecycle;

  Future<void> refresh() async {
    try {
      _emit(await _checker.check());
    } catch (_) {
      _emit(false);
    }
  }

  void _emit(bool online) {
    if (isClosed) {
      return;
    }
    emit(
      online
          ? const OnlineStatusState.online()
          : const OnlineStatusState.offline(),
    );
  }

  @override
  Future<void> close() async {
    _lifecycle?.dispose();
    await _subscription?.cancel();
    return super.close();
  }
}
