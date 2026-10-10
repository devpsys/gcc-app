import 'package:gcc_app/features/auth/presentation/agent_auth_gateway.dart';

/// Presentation stand-in until an agent auth API exists.
///
/// It performs no network or token work. The masked number is the sample from
/// the agent verification design.
final class UnwiredAgentAuthGateway implements AgentAuthGateway {
  static const String sampleMaskedPhone = '+234 •••• 2290';

  @override
  Future<String> requestVerificationCode(String agentIdentifier) async {
    return sampleMaskedPhone;
  }

  @override
  Future<void> verifyCode(String agentIdentifier, String code) async {}
}
