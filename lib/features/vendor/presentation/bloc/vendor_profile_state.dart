import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/vendor_profile.dart';

sealed class VendorProfileState extends Equatable {
  const VendorProfileState();
}

final class VendorProfileLoading extends VendorProfileState {
  const VendorProfileLoading();

  @override
  List<Object?> get props => const [];
}

final class VendorProfileReady extends VendorProfileState {
  const VendorProfileReady(this.profile);

  final VendorProfile profile;

  @override
  List<Object?> get props => [profile];
}

final class VendorProfileFailed extends VendorProfileState {
  const VendorProfileFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
