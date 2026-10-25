import 'package:equatable/equatable.dart';

/// Seeded GCC virtual account for the payment suite (MOB-VND-06).
class RentalPaymentAccount extends Equatable {
  const RentalPaymentAccount({
    required this.orderReference,
    required this.accountNumber,
    required this.bankName,
  });

  final String orderReference;
  final String accountNumber;
  final String bankName;

  /// `0123 4567 8901`
  String get accountNumberGrouped {
    final digits = accountNumber.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  @override
  List<Object?> get props => [orderReference, accountNumber, bankName];
}

const rentalPaymentSeedAccount = RentalPaymentAccount(
  orderReference: 'BK-24817',
  accountNumber: '012345678901',
  bankName: 'Providus Bank',
);
