import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/auth/domain/biometric_method.dart';

sealed class BiometricCapability extends Equatable {
  const BiometricCapability();
}

final class BiometricAvailable extends BiometricCapability {
  const BiometricAvailable(this.method);

  final BiometricMethod method;

  @override
  List<Object?> get props => [method];
}

final class BiometricUnavailable extends BiometricCapability {
  const BiometricUnavailable(this.reason);

  final BiometricUnavailableReason reason;

  @override
  List<Object?> get props => [reason];
}
