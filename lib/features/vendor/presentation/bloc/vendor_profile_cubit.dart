import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_profile_state.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_profile_gateway.dart';

/// The signed-in yard, and the switch into lessee mode.
class VendorProfileCubit extends Cubit<VendorProfileState> {
  VendorProfileCubit(this._gateway, this._session)
    : super(const VendorProfileLoading());

  final VendorProfileGateway _gateway;
  final SessionRepository _session;

  Future<void> load() async {
    emit(const VendorProfileLoading());
    try {
      emit(VendorProfileReady(await _gateway.load()));
    } on Failure catch (failure) {
      emit(VendorProfileFailed(failure));
    }
  }

  /// Keeps the catalog and the wallet. Only the signed-in role changes.
  Future<bool> switchToLessee() async {
    try {
      await _session.establish(AuthRole.lessee);
      return true;
    } on Failure {
      return false;
    }
  }
}
