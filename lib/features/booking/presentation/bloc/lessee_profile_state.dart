import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/lessee_profile.dart';

sealed class LesseeProfileState extends Equatable {
  const LesseeProfileState();
}

final class LesseeProfileLoading extends LesseeProfileState {
  const LesseeProfileLoading();

  @override
  List<Object?> get props => const [];
}

final class LesseeProfileReady extends LesseeProfileState {
  const LesseeProfileReady(this.profile);

  final LesseeProfile profile;

  @override
  List<Object?> get props => [profile];
}

final class LesseeProfileFailed extends LesseeProfileState {
  const LesseeProfileFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
