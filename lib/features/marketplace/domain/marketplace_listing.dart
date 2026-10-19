import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_spec.dart';

/// One piece of equipment a lessee can open from browse.
class MarketplaceListing extends Equatable {
  const MarketplaceListing({
    required this.id,
    required this.title,
    required this.yard,
    required this.market,
    required this.place,
    required this.category,
    required this.specification,
    required this.dailyRate,
    required this.deposit,
    required this.availability,
    required this.withOperator,
    this.unavailableUntil,
    this.verified = false,
    this.distance,
    this.deliveryFee = 0,
    this.photoCount = 1,
    this.videoCaption,
    this.specs = const [],
    this.included = const [],
    this.checkOut,
    this.checkIn,
    this.access,
  });

  final String id;
  final String title;
  final String yard;
  final String market;
  final String place;
  final String category;
  final String specification;
  final int dailyRate;
  final int deposit;
  final MarketplaceAvailability availability;
  final bool withOperator;
  final String? unavailableUntil;
  final bool verified;
  final String? distance;
  final int deliveryFee;
  final int photoCount;
  final String? videoCaption;
  final List<MarketplaceSpec> specs;
  final List<String> included;
  final String? checkOut;
  final String? checkIn;
  final String? access;

  @override
  List<Object?> get props => [
    id,
    title,
    yard,
    market,
    place,
    category,
    specification,
    dailyRate,
    deposit,
    availability,
    withOperator,
    unavailableUntil,
    verified,
    distance,
    deliveryFee,
    photoCount,
    videoCaption,
    specs,
    included,
    checkOut,
    checkIn,
    access,
  ];
}
