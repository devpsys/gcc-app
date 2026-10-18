import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/device_lock_snapshot.dart';

sealed class DeviceLockState extends Equatable {
  const DeviceLockState(this.snapshot);

  final DeviceLockSnapshot snapshot;

  @override
  List<Object?> get props => [snapshot];
}

final class DeviceLockLoading extends DeviceLockState {
  const DeviceLockLoading() : super(DeviceLockSnapshot.empty);
}

final class DeviceLockReady extends DeviceLockState {
  const DeviceLockReady(super.snapshot);
}

final class DeviceLockBusy extends DeviceLockState {
  const DeviceLockBusy(super.snapshot);
}

final class DeviceLockUnlocked extends DeviceLockState {
  const DeviceLockUnlocked({
    required DeviceLockSnapshot snapshot,
    required this.homeLocation,
  }) : super(snapshot);

  final String homeLocation;

  @override
  List<Object?> get props => [snapshot, homeLocation];
}

final class DeviceLockRevoked extends DeviceLockState {
  const DeviceLockRevoked({
    required DeviceLockSnapshot snapshot,
    required this.signInLocation,
  }) : super(snapshot);

  final String signInLocation;

  @override
  List<Object?> get props => [snapshot, signInLocation];
}

final class DeviceLockFailed extends DeviceLockState {
  const DeviceLockFailed({
    required DeviceLockSnapshot snapshot,
    required this.failure,
  }) : super(snapshot);

  final Failure failure;

  @override
  List<Object?> get props => [snapshot, failure];
}
