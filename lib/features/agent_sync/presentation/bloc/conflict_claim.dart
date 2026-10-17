import 'package:equatable/equatable.dart';

/// A peer agent who already claimed the same shop.
class ConflictClaim extends Equatable {
  const ConflictClaim({
    required this.agentName,
    required this.agentId,
    required this.claimedAt,
    required this.outcome,
  });

  final String agentName;
  final String agentId;
  final String claimedAt;

  /// `Mapped first` or `Verified first`.
  final String outcome;

  @override
  List<Object?> get props => [agentName, agentId, claimedAt, outcome];
}
