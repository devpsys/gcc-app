import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';

sealed class RentalRequestState extends Equatable {
  const RentalRequestState();
}

final class RentalRequestLoading extends RentalRequestState {
  const RentalRequestLoading();

  @override
  List<Object?> get props => [];
}

final class RentalRequestMissing extends RentalRequestState {
  const RentalRequestMissing();

  @override
  List<Object?> get props => [];
}

final class RentalRequestFailed extends RentalRequestState {
  const RentalRequestFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class RentalRequestReady extends RentalRequestState {
  const RentalRequestReady(this.request);

  final RentalRequest request;

  @override
  List<Object?> get props => [request];
}
