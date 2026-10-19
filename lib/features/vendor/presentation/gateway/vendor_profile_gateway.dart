import 'package:gcc_app/features/vendor/domain/vendor_profile.dart';

/// Reads the signed-in vendor profile.
abstract interface class VendorProfileGateway {
  Future<VendorProfile> load();
}
