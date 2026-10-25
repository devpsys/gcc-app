import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';

/// One lessee booking row on the bookings suite (MOB-VND-08).
class LesseeBooking extends Equatable {
  const LesseeBooking({
    required this.id,
    required this.reference,
    required this.title,
    required this.yard,
    required this.status,
    required this.tab,
    required this.amount,
    required this.deposit,
    required this.from,
    required this.to,
    this.mark,
    this.category = 'Generators',
    this.depositHeld = false,
    this.depositReleased = false,
    this.depositNeverCharged = false,
    this.statusDetail,
    this.rating,
    this.listingId,
  });

  final String id;
  final String reference;
  final String title;
  final String yard;
  final LesseeBookingStatus status;
  final LesseeBookingTab tab;
  final int amount;
  final int deposit;
  final DateTime from;
  final DateTime to;
  final String? mark;
  final String category;
  final bool depositHeld;
  final bool depositReleased;
  final bool depositNeverCharged;
  final String? statusDetail;
  final int? rating;
  final String? listingId;

  bool get needsAction => status == LesseeBookingStatus.actionNeeded;

  LesseeBooking copyWith({
    int? rating,
    bool clearRating = false,
  }) {
    return LesseeBooking(
      id: id,
      reference: reference,
      title: title,
      yard: yard,
      status: status,
      tab: tab,
      amount: amount,
      deposit: deposit,
      from: from,
      to: to,
      mark: mark,
      category: category,
      depositHeld: depositHeld,
      depositReleased: depositReleased,
      depositNeverCharged: depositNeverCharged,
      statusDetail: statusDetail,
      rating: clearRating ? null : (rating ?? this.rating),
      listingId: listingId,
    );
  }

  @override
  List<Object?> get props => [
    id,
    reference,
    title,
    yard,
    status,
    tab,
    amount,
    deposit,
    from,
    to,
    mark,
    category,
    depositHeld,
    depositReleased,
    depositNeverCharged,
    statusDetail,
    rating,
    listingId,
  ];
}
