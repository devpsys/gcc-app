/// Requests and verifies SMS codes for unified ID sign-in.
abstract interface class AuthGateway {
  Future<String> requestVerificationCode(String identifier);

  Future<void> verifyCode(String identifier, String code);
}
