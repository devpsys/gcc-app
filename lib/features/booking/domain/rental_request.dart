import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_quote.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';

/// Seeded stay for the Mika listing (matches MOB-VND-05).
final rentalDefaultFrom = DateTime(2026, 10, 14, 8);
final rentalDefaultTo = DateTime(2026, 10, 17, 16, 40);

const rentalDefaultDeliveryPlace = 'Wuse II, Abuja';

/// Lessee choices for one rental request.
class RentalRequest extends Equatable {
  const RentalRequest({
    required this.listing,
    required this.from,
    required this.to,
    required this.deliveryMode,
    required this.deliveryPlace,
    required this.withOperator,
    required this.withInsurance,
  });

  final MarketplaceListing listing;
  final DateTime from;
  final DateTime to;
  final RentalDeliveryMode deliveryMode;
  final String deliveryPlace;
  final bool withOperator;
  final bool withInsurance;

  RentalQuote get quote => quoteFor(
    from: from,
    to: to,
    dailyRate: listing.dailyRate,
    deliveryFee: listing.deliveryFee,
    operatorDaily: listing.operatorDailyFee,
    deposit: listing.deposit,
    deliveryMode: deliveryMode,
    withOperator: withOperator,
    withInsurance: withInsurance,
  );

  bool get datesValid => to.isAfter(from);

  RentalRequest copyWith({
    DateTime? from,
    DateTime? to,
    RentalDeliveryMode? deliveryMode,
    String? deliveryPlace,
    bool? withOperator,
    bool? withInsurance,
  }) {
    return RentalRequest(
      listing: listing,
      from: from ?? this.from,
      to: to ?? this.to,
      deliveryMode: deliveryMode ?? this.deliveryMode,
      deliveryPlace: deliveryPlace ?? this.deliveryPlace,
      withOperator: withOperator ?? this.withOperator,
      withInsurance: withInsurance ?? this.withInsurance,
    );
  }

  @override
  List<Object?> get props => [
    listing,
    from,
    to,
    deliveryMode,
    deliveryPlace,
    withOperator,
    withInsurance,
  ];
}
