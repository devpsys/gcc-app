import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/vendor/domain/vendor_audit_kind.dart';

/// One line in the arbitration trail for a request accepted by SMS.
class VendorRequestAudit extends Equatable {
  const VendorRequestAudit({
    required this.at,
    required this.kind,
    required this.done,
  });

  final String at;
  final VendorAuditKind kind;
  final bool done;

  @override
  List<Object?> get props => [at, kind, done];
}
