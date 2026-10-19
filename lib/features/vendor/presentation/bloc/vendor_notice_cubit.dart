import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_filter.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_notice_state.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_notice_gateway.dart';

/// The vendor inbox. Marking read only clears the unread dots.
class VendorNoticeCubit extends Cubit<VendorNoticeState> {
  VendorNoticeCubit(this._gateway) : super(const VendorNoticeLoading());

  final VendorNoticeGateway _gateway;

  Future<void> load() async {
    emit(const VendorNoticeLoading());
    try {
      final inbox = await _gateway.load();
      emit(
        VendorNoticeReady(
          notices: inbox.notices,
          requestsWaiting: inbox.requestsWaiting,
        ),
      );
    } on Failure catch (failure) {
      emit(VendorNoticeFailed(failure));
    }
  }

  void select(VendorNoticeFilter filter) {
    final ready = _ready;
    if (ready == null || ready.filter == filter) {
      return;
    }
    emit(ready.copyWith(filter: filter));
  }

  void markAllRead() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      ready.copyWith(
        notices: [
          for (final notice in ready.notices) notice.copyWith(unread: false),
        ],
      ),
    );
  }

  VendorNoticeReady? get _ready {
    final current = state;
    return current is VendorNoticeReady ? current : null;
  }
}
