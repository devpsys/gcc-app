import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/biometric_capability.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';

final class DeviceLockSnapshot extends Equatable {
  const DeviceLockSnapshot({
    required this.capability,
    required this.enrolled,
    required this.promptDeclined,
    this.lastRole,
  });

  final BiometricCapability capability;
  final bool enrolled;
  final bool promptDeclined;
  final AuthRole? lastRole;

  static const empty = DeviceLockSnapshot(
    capability: BiometricUnavailable(BiometricUnavailableReason.unsupported),
    enrolled: false,
    promptDeclined: false,
  );

  @override
  List<Object?> get props => [capability, enrolled, promptDeclined, lastRole];
}
