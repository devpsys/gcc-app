import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';

/// Arguments for the payment-status route (MOB-VND-07).
class RentalPaymentStatusArgs extends Equatable {
  const RentalPaymentStatusArgs({
    required this.request,
    required this.account,
    required this.method,
    required this.initialPhase,
  });

  final RentalRequest request;
  final RentalPaymentAccount account;
  final RentalPaymentMethod method;
  final RentalPaymentStatusPhase initialPhase;

  String get paymentReference => 'GCC-${account.orderReference}';

  @override
  List<Object?> get props => [request, account, method, initialPhase];
}
