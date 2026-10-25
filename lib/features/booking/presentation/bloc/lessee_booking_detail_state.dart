import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail.dart';

sealed class LesseeBookingDetailState extends Equatable {
  const LesseeBookingDetailState();
}

final class LesseeBookingDetailLoading extends LesseeBookingDetailState {
  const LesseeBookingDetailLoading();

  @override
  List<Object?> get props => [];
}

final class LesseeBookingDetailFailed extends LesseeBookingDetailState {
  const LesseeBookingDetailFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class LesseeBookingDetailMissing extends LesseeBookingDetailState {
  const LesseeBookingDetailMissing();

  @override
  List<Object?> get props => [];
}

final class LesseeBookingDetailReady extends LesseeBookingDetailState {
  const LesseeBookingDetailReady(this.detail);

  final LesseeBookingDetail detail;

  @override
  List<Object?> get props => [detail];
}
