import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/vendor_booking_request.dart';

sealed class VendorRequestState extends Equatable {
  const VendorRequestState();
}

final class VendorRequestLoading extends VendorRequestState {
  const VendorRequestLoading();

  @override
  List<Object?> get props => const [];
}

final class VendorRequestReady extends VendorRequestState {
  const VendorRequestReady({
    required this.request,
    required this.requestsWaiting,
  });

  final VendorBookingRequest? request;
  final int requestsWaiting;

  VendorRequestReady copyWith({VendorBookingRequest? request}) {
    return VendorRequestReady(
      request: request ?? this.request,
      requestsWaiting: requestsWaiting,
    );
  }

  @override
  List<Object?> get props => [request, requestsWaiting];
}

final class VendorRequestFailed extends VendorRequestState {
  const VendorRequestFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
