import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_booking_detail_state.dart';
import 'package:gcc_app/features/booking/presentation/gateway/lessee_booking_detail_gateway.dart';

class LesseeBookingDetailCubit extends Cubit<LesseeBookingDetailState> {
  LesseeBookingDetailCubit(this._gateway, this.id)
    : super(const LesseeBookingDetailLoading());

  final LesseeBookingDetailGateway _gateway;
  final String id;

  Future<void> load() async {
    emit(const LesseeBookingDetailLoading());
    try {
      final detail = await _gateway.load(id);
      if (detail == null) {
        emit(const LesseeBookingDetailMissing());
        return;
      }
      emit(LesseeBookingDetailReady(detail));
    } on Failure catch (failure) {
      emit(LesseeBookingDetailFailed(failure));
    }
  }
}
