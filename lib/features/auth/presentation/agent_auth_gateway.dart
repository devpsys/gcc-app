abstract interface class AgentAuthGateway {
  Future<String> requestVerificationCode(String agentIdentifier);

  Future<void> verifyCode(String agentIdentifier, String code);
}
