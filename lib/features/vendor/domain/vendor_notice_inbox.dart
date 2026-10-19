import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice.dart';

/// The vendor inbox and the requests badge shared with the rest of the shell.
class VendorNoticeInbox extends Equatable {
  const VendorNoticeInbox({
    required this.notices,
    required this.requestsWaiting,
  });

  final List<VendorNotice> notices;
  final int requestsWaiting;

  @override
  List<Object?> get props => [notices, requestsWaiting];
}
