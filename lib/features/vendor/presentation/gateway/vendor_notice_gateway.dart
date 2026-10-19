import 'package:gcc_app/features/vendor/domain/vendor_notice_inbox.dart';

/// Reads the vendor notification inbox.
abstract interface class VendorNoticeGateway {
  Future<VendorNoticeInbox> load();
}
