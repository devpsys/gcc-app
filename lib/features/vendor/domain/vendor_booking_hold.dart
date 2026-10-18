import 'package:equatable/equatable.dart';

/// A live booking that keeps an asset rented.
class VendorBookingHold extends Equatable {
  const VendorBookingHold({
    required this.reference,
    required this.lessee,
    required this.returnsAt,
    required this.changesAt,
    required this.resumesAt,
    required this.bookableUntil,
  });

  /// e.g. `BK-24804`.
  final String reference;

  /// e.g. `Mrs. Ngozi Okonkwo`.
  final String lessee;

  /// Full return moment, e.g. `17 Oct, 2026, 09:00`.
  final String returnsAt;

  /// When the status would change on its own, e.g. `09:00 on 17 Oct`.
  final String changesAt;

  /// Short return moment for the scheduled strip, e.g. `17 Oct, 09:00`.
  final String resumesAt;

  /// Clock time the machine stays bookable, e.g. `09:00`.
  final String bookableUntil;

  @override
  List<Object?> get props => [
    reference,
    lessee,
    returnsAt,
    changesAt,
    resumesAt,
    bookableUntil,
  ];
}
