import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_days.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_rates.dart';

/// Money for the confirm screen. Deposit is charged today and held separately.
class RentalQuote extends Equatable {
  const RentalQuote({
    required this.days,
    required this.dailyRate,
    required this.deliveryFee,
    required this.operatorDaily,
    required this.deposit,
    required this.deliveryMode,
    required this.withOperator,
    required this.withInsurance,
  });

  final int days;
  final int dailyRate;
  final int deliveryFee;
  final int operatorDaily;
  final int deposit;
  final RentalDeliveryMode deliveryMode;
  final bool withOperator;
  final bool withInsurance;

  int get rental => dailyRate * days;

  int get delivery =>
      deliveryMode == RentalDeliveryMode.deliver ? deliveryFee : 0;

  int get insurance =>
      withInsurance && days > 0 ? insurancePerDay(dailyRate) * days : 0;

  int get operator => withOperator ? operatorDaily * days : 0;

  /// Rental, logistics, insurance, and operator — before the caution deposit.
  int get staySubtotal => rental + delivery + insurance + operator;

  /// What the lessee pays today, including the held deposit.
  int get chargedToday => staySubtotal + deposit;

  bool get isValid => days > 0;

  @override
  List<Object?> get props => [
    days,
    dailyRate,
    deliveryFee,
    operatorDaily,
    deposit,
    deliveryMode,
    withOperator,
    withInsurance,
  ];
}

RentalQuote quoteFor({
  required DateTime from,
  required DateTime to,
  required int dailyRate,
  required int deliveryFee,
  required int operatorDaily,
  required int deposit,
  required RentalDeliveryMode deliveryMode,
  required bool withOperator,
  required bool withInsurance,
}) {
  return RentalQuote(
    days: rentalDays(from, to),
    dailyRate: dailyRate,
    deliveryFee: deliveryFee,
    operatorDaily: operatorDaily,
    deposit: deposit,
    deliveryMode: deliveryMode,
    withOperator: withOperator,
    withInsurance: withInsurance,
  );
}
