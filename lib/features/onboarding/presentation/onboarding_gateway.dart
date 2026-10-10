abstract interface class OnboardingGateway {
  Future<void> requestSignInCode(String phoneNumber);

  Future<void> verifySignInCode(String phoneNumber, String code);
}
