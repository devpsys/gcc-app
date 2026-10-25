import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/booking/domain/handback_finding.dart';

/// Lessee handback review payload for MOB-VND-10.
class HandbackReview extends Equatable {
  const HandbackReview({
    required this.id,
    required this.reference,
    required this.title,
    required this.yard,
    required this.recordedAtLabel,
    required this.durationSeconds,
    required this.findings,
    required this.deposit,
    required this.vendorPayout,
    required this.vendorName,
    this.listingId,
  });

  final String id;
  final String reference;
  final String title;
  final String yard;
  final String recordedAtLabel;
  final int durationSeconds;
  final List<HandbackFinding> findings;
  final int deposit;
  final int vendorPayout;
  final String vendorName;
  final String? listingId;

  int get chargedTotal => deposit + vendorPayout;

  @override
  List<Object?> get props => [
    id,
    reference,
    title,
    yard,
    recordedAtLabel,
    durationSeconds,
    findings,
    deposit,
    vendorPayout,
    vendorName,
    listingId,
  ];
}
