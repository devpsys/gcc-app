import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_profile_state.dart';
import 'package:gcc_app/features/booking/presentation/gateway/lessee_profile_gateway.dart';

/// The signed-in lessee, and the switch into vendor mode.
class LesseeProfileCubit extends Cubit<LesseeProfileState> {
  LesseeProfileCubit(this._gateway, this._session)
    : super(const LesseeProfileLoading());

  final LesseeProfileGateway _gateway;
  final SessionRepository _session;

  Future<void> load() async {
    emit(const LesseeProfileLoading());
    try {
      emit(LesseeProfileReady(await _gateway.load()));
    } on Failure catch (failure) {
      emit(LesseeProfileFailed(failure));
    }
  }

  /// Keeps wallet and bookings. Only the signed-in role changes.
  Future<bool> switchToVendor() async {
    try {
      await _session.establish(AuthRole.vendor);
      return true;
    } on Failure {
      return false;
    }
  }
}
