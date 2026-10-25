import 'package:gcc_app/features/booking/domain/lessee_profile.dart';

abstract class LesseeProfileGateway {
  Future<LesseeProfile> load();
}
