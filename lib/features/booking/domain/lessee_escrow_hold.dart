import 'package:equatable/equatable.dart';

/// One booking still locked in escrow or audit (MOB-LSE-14 zero frame).
class LesseeEscrowHold extends Equatable {
  const LesseeEscrowHold({
    required this.title,
    required this.caption,
    required this.reference,
    required this.detail,
  });

  final String title;
  final String caption;
  final String reference;
  final String detail;

  @override
  List<Object?> get props => [title, caption, reference, detail];
}
