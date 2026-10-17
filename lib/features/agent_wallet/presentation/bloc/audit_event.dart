import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event_state.dart';

/// One row of the audit timeline.
class AuditEvent extends Equatable {
  const AuditEvent({
    required this.label,
    required this.detail,
    required this.state,
    required this.at,
  });

  /// e.g. `Submitted`.
  final String label;

  /// e.g. `Queued and uploaded`, or why a step failed.
  final String detail;
  final AuditEventState state;

  /// e.g. `13 Oct, 10:42`. Blank while a step has not happened.
  final String at;

  @override
  List<Object?> get props => [label, detail, state, at];
}
