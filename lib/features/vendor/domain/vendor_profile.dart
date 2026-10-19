import 'package:equatable/equatable.dart';

/// The signed-in yard. Names, the payout mask, and the support number are data.
class VendorProfile extends Equatable {
  const VendorProfile({
    required this.initials,
    required this.name,
    required this.yard,
    required this.reference,
    required this.kind,
    required this.place,
    required this.savedAddresses,
    required this.payoutAccount,
    required this.shopLocation,
    required this.notificationSummary,
    required this.supportPhone,
    required this.version,
    required this.ussd,
    required this.requestsWaiting,
  });

  final String initials;
  final String name;
  final String yard;
  final String reference;
  final String kind;
  final String place;
  final int savedAddresses;
  final String payoutAccount;
  final String shopLocation;
  final String notificationSummary;
  final String supportPhone;
  final String version;
  final String ussd;
  final int requestsWaiting;

  @override
  List<Object?> get props => [
    initials,
    name,
    yard,
    reference,
    kind,
    place,
    savedAddresses,
    payoutAccount,
    shopLocation,
    notificationSummary,
    supportPhone,
    version,
    ussd,
    requestsWaiting,
  ];
}
