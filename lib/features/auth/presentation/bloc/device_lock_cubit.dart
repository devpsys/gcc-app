import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/router/session_gate.dart';
import 'package:gcc_app/features/auth/domain/device_lock_repository.dart';
import 'package:gcc_app/features/auth/domain/device_lock_snapshot.dart';
import 'package:gcc_app/features/auth/domain/enroll_device_lock.dart';
import 'package:gcc_app/features/auth/domain/revoke_device_lock.dart';
import 'package:gcc_app/features/auth/domain/unlock_device.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_state.dart';

class DeviceLockCubit extends Cubit<DeviceLockState> {
  DeviceLockCubit(
    this._repository,
    this._enroll,
    this._unlock,
    this._revoke,
    this._gate,
  ) : super(const DeviceLockLoading());

  final DeviceLockRepository _repository;
  final EnrollDeviceLock _enroll;
  final UnlockDevice _unlock;
  final RevokeDeviceLock _revoke;
  final SessionGate _gate;

  bool get _busy => state is DeviceLockBusy;

  Future<void> load() async {
    if (_busy) {
      return;
    }
    try {
      emit(DeviceLockReady(await _repository.read()));
    } on Failure catch (failure) {
      emit(DeviceLockFailed(snapshot: state.snapshot, failure: failure));
    }
  }

  Future<void> enroll() async {
    if (_busy) {
      return;
    }
    final snapshot = state.snapshot;
    emit(DeviceLockBusy(snapshot));
    try {
      await _enroll.call();
      final next = await _repository.read();
      emit(DeviceLockUnlocked(snapshot: next, homeLocation: _home()));
    } on CancelledFailure {
      try {
        await _repository.declinePrompt();
      } on Failure {
        // Enrollment stayed off. The next sign-in can offer the prompt again.
      }
      emit(DeviceLockReady(await _readOr(snapshot)));
    } on Failure catch (failure) {
      emit(
        DeviceLockFailed(snapshot: await _readOr(snapshot), failure: failure),
      );
    }
  }

  Future<void> declinePrompt() async {
    if (_busy) {
      return;
    }
    try {
      await _repository.declinePrompt();
      emit(DeviceLockReady(await _repository.read()));
    } on Failure catch (failure) {
      emit(DeviceLockFailed(snapshot: state.snapshot, failure: failure));
    }
  }

  Future<void> unlock() async {
    if (_busy) {
      return;
    }
    final snapshot = state.snapshot;
    if (!snapshot.enrolled) {
      return;
    }
    emit(DeviceLockBusy(snapshot));
    try {
      await _unlock.call();
      final next = await _repository.read();
      emit(DeviceLockUnlocked(snapshot: next, homeLocation: _home()));
    } on CancelledFailure {
      emit(DeviceLockReady(snapshot));
    } on Failure catch (failure) {
      final next = failure is BiometricEnrollmentLostFailure
          ? await _readOr(snapshot)
          : snapshot;
      emit(DeviceLockFailed(snapshot: next, failure: failure));
    }
  }

  /// Stops protecting the next cold start and leaves this session unlocked.
  Future<void> disable() async {
    if (_busy) {
      return;
    }
    final snapshot = state.snapshot;
    emit(DeviceLockBusy(snapshot));
    try {
      await _repository.clearEnrollment();
      emit(DeviceLockReady(await _repository.read()));
    } on Failure catch (failure) {
      emit(DeviceLockFailed(snapshot: snapshot, failure: failure));
    }
  }

  Future<void> useVerificationCode() => _revokeAndLeave();

  Future<void> signOut() => _revokeAndLeave();

  Future<void> _revokeAndLeave() async {
    if (_busy) {
      return;
    }
    final snapshot = state.snapshot;
    emit(DeviceLockBusy(snapshot));
    try {
      await _revoke.call();
      emit(
        DeviceLockRevoked(
          snapshot: snapshot,
          signInLocation:
              _gate.state.signInLocation ?? RoutePaths.onboardingLanguage,
        ),
      );
    } on Failure catch (failure) {
      emit(DeviceLockFailed(snapshot: snapshot, failure: failure));
    }
  }

  Future<DeviceLockSnapshot> _readOr(DeviceLockSnapshot fallback) async {
    try {
      return await _repository.read();
    } on Failure {
      return fallback;
    }
  }

  String _home() {
    return _gate.state.homeLocation ?? RoutePaths.onboardingLanguage;
  }
}
