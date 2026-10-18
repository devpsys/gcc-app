import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/decline_request_ready.dart';
import 'package:gcc_app/features/vendor/domain/vendor_booking_request.dart';
import 'package:gcc_app/features/vendor/domain/vendor_decline_reason.dart';
import 'package:gcc_app/features/vendor/domain/vendor_request_stage.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_request_state.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_request_gateway.dart';

/// Drives the booking request the vendor can accept or decline.
///
/// SMS delivery and the expiry countdown stay on the server. This screen
/// only records the decision.
class VendorRequestCubit extends Cubit<VendorRequestState> {
  VendorRequestCubit(this._gateway) : super(const VendorRequestLoading());

  final VendorRequestGateway _gateway;

  Future<void> load() async {
    emit(const VendorRequestLoading());
    try {
      final request = await _gateway.loadRequest();
      final waiting = await _gateway.loadRequestsWaiting();
      emit(VendorRequestReady(request: request, requestsWaiting: waiting));
    } on Failure catch (failure) {
      emit(VendorRequestFailed(failure));
    }
  }

  void accept() {
    final request = _request;
    if (request == null || request.stage != VendorRequestStage.active) {
      return;
    }
    emit(
      _ready!.copyWith(
        request: request.copyWith(stage: VendorRequestStage.accepted),
      ),
    );
  }

  void decline({required VendorDeclineReason? reason, required String note}) {
    final request = _request;
    if (request == null ||
        request.stage == VendorRequestStage.declined ||
        !declineRequestReady(reason: reason, note: note)) {
      return;
    }
    emit(
      _ready!.copyWith(
        request: request.copyWith(
          stage: VendorRequestStage.declined,
          declineReason: reason,
          declineNote: note.trim(),
        ),
      ),
    );
  }

  VendorRequestReady? get _ready {
    final current = state;
    return current is VendorRequestReady ? current : null;
  }

  VendorBookingRequest? get _request => _ready?.request;
}
