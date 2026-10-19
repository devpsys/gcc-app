import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_filter.dart';

sealed class VendorNoticeState extends Equatable {
  const VendorNoticeState();
}

final class VendorNoticeLoading extends VendorNoticeState {
  const VendorNoticeLoading();

  @override
  List<Object?> get props => const [];
}

final class VendorNoticeReady extends VendorNoticeState {
  const VendorNoticeReady({
    required this.notices,
    required this.requestsWaiting,
    this.filter = VendorNoticeFilter.all,
  });

  final List<VendorNotice> notices;
  final int requestsWaiting;
  final VendorNoticeFilter filter;

  List<VendorNotice> get visible {
    return [
      for (final notice in notices)
        if (notice.shownIn(filter)) notice,
    ];
  }

  int countOf(VendorNoticeFilter lane) {
    return notices.where((notice) => notice.shownIn(lane)).length;
  }

  VendorNotice? get decision {
    for (final notice in notices) {
      if (notice.needsDecision) {
        return notice;
      }
    }
    return null;
  }

  VendorNoticeReady copyWith({
    List<VendorNotice>? notices,
    VendorNoticeFilter? filter,
  }) {
    return VendorNoticeReady(
      notices: notices ?? this.notices,
      requestsWaiting: requestsWaiting,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [notices, requestsWaiting, filter];
}

final class VendorNoticeFailed extends VendorNoticeState {
  const VendorNoticeFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
