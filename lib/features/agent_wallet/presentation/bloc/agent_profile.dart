import 'package:equatable/equatable.dart';

/// The signed-in field agent.
class AgentProfile extends Equatable {
  const AgentProfile({
    required this.name,
    required this.agentId,
    required this.base,
    required this.coveredMarkets,
    required this.since,
    required this.submissionCount,
    required this.verifiedCount,
    this.supportPhone,
  });

  /// e.g. `Ibrahim Musa`.
  final String name;

  /// e.g. `AG-0142`.
  final String agentId;

  /// Home market, e.g. `Kugbo`.
  final String base;

  /// e.g. `Kugbo, Dei-Dei`.
  final String coveredMarkets;

  /// e.g. `Agent since Mar 2026`.
  final String since;

  final int submissionCount;
  final int verifiedCount;
  final String? supportPhone;

  /// How much of the agent's work verified, as a fraction.
  double get verificationRate =>
      submissionCount == 0 ? 0 : verifiedCount / submissionCount;

  @override
  List<Object?> get props => [
    name,
    agentId,
    base,
    coveredMarkets,
    since,
    submissionCount,
    verifiedCount,
    supportPhone,
  ];
}
