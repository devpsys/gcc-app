import 'package:gcc_app/features/onboarding/presentation/onboarding_gateway.dart';

/// Presentation stand-in until a sign-in API exists.
///
/// It performs no network or token work.
final class UnwiredOnboardingGateway implements OnboardingGateway {
  @override
  Future<void> requestSignInCode(String phoneNumber) async {}

  @override
  Future<void> verifySignInCode(String phoneNumber, String code) async {}
}
