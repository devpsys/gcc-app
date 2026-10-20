import 'package:gcc_app/features/marketplace/domain/marketplace_audit_clip.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_catalog.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_spec.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_spec_kind.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/marketplace_gateway.dart';

/// The five browse cards, with the generator's listing filled in.
class MockMarketplaceGateway implements MarketplaceGateway {
  const MockMarketplaceGateway();

  static const catalog = MarketplaceCatalog(
    bookingsWaiting: 2,
    recentSearches: [
      MarketplaceSearch(query: 'generator', place: 'Kugbo'),
      MarketplaceSearch(query: '100 kVA'),
      MarketplaceSearch(query: 'sound system', place: 'Wuse'),
    ],
    listings: [
      MarketplaceListing(
        id: 'mika-100',
        title: 'Mika 100kVA Diesel Generator Set',
        yard: 'Kugbo Generator Yard',
        market: 'Kugbo',
        place: 'Kugbo Market · Zone C, Line 4',
        category: 'Generators',
        specification: '100 kVA · Diesel · 2023',
        thumbBadge: '100 kVA · 23',
        heroMark: 'MIKA 100',
        heroTagline: 'DIESEL SILENT',
        dailyRate: 35000,
        deposit: 50000,
        deliveryFee: 7500,
        operatorDailyFee: 8000,
        availability: MarketplaceAvailability.available,
        withOperator: true,
        verified: true,
        distance: '6.4 km away',
        photoCount: 4,
        videoCaption: 'Condition video · 14 Oct 2026 · 00:30',
        specs: [
          MarketplaceSpec(kind: MarketplaceSpecKind.capacity, value: '100 kVA'),
          MarketplaceSpec(kind: MarketplaceSpecKind.fuel, value: 'Diesel'),
          MarketplaceSpec(kind: MarketplaceSpecKind.year, value: '2023'),
          MarketplaceSpec(
            kind: MarketplaceSpecKind.serial,
            value: 'G100-44213',
          ),
          MarketplaceSpec(kind: MarketplaceSpecKind.condition, value: 'Good'),
          MarketplaceSpec(kind: MarketplaceSpecKind.hours, value: '4,200'),
        ],
        included: [
          '100 kVA diesel generator set',
          '100 m of 35mm copper cable',
          'Fuel for the first 4 hours',
          'Delivery, collection and a certified operator',
        ],
        auditClips: [
          MarketplaceAuditClip(
            time: '14 Oct 08:15',
            title: 'Check-out',
            detail: 'within 120 m of yard',
          ),
          MarketplaceAuditClip(
            time: '17 Oct 16:40',
            title: 'Check-in',
            detail: 'within 120 m of yard',
          ),
        ],
        accessZone: 'ZONE C',
        access: 'Kugbo Market · Zone C · Line 4 · beside Bola Hardware',
        similarIds: ['mika-60', 'silent-20'],
      ),
      MarketplaceListing(
        id: 'mika-60',
        title: 'Mika 60kVA Diesel Generator Set',
        yard: 'Kugbo Generator Yard',
        market: 'Kugbo',
        place: 'Kugbo Market',
        category: 'Generators',
        specification: '60 kVA · Diesel · 2022',
        thumbBadge: '60 kVA',
        heroMark: 'MIKA 60',
        heroTagline: 'DIESEL SILENT',
        dailyRate: 24000,
        deposit: 40000,
        availability: MarketplaceAvailability.available,
        withOperator: true,
        inBrowse: false,
        similarIds: ['mika-100', 'silent-20'],
      ),
      MarketplaceListing(
        id: 'pa-5kw',
        title: '5kW PA Sound System',
        yard: 'Deepwell Sound Rentals',
        market: 'Wuse',
        place: 'Wuse Market',
        category: 'Sound & PA',
        specification: '5 kW · 2 mics · 400 W',
        thumbBadge: 'PA System',
        dailyRate: 18000,
        deposit: 30000,
        availability: MarketplaceAvailability.available,
        withOperator: false,
      ),
      MarketplaceListing(
        id: 'welder-250',
        title: '250A Welding Machine',
        yard: 'Kugbo Generator Yard',
        market: 'Kugbo',
        place: 'Kugbo Market',
        category: 'Welding',
        specification: '250 A · Petrol · 2022',
        thumbBadge: '250A Welder',
        dailyRate: 8500,
        deposit: 20000,
        availability: MarketplaceAvailability.inUse,
        unavailableUntil: '16 Oct',
        withOperator: false,
      ),
      MarketplaceListing(
        id: 'pump-5hp',
        title: '5HP Water Pump',
        yard: 'Utako Water & Pump Depot',
        market: 'Utako',
        place: 'Utako Market',
        category: 'Water pumps',
        specification: '5 HP · Diesel · 2021',
        thumbBadge: '5HP Pump',
        dailyRate: 6000,
        deposit: 15000,
        availability: MarketplaceAvailability.outOfService,
        withOperator: false,
      ),
      MarketplaceListing(
        id: 'silent-20',
        title: '20kVA Silent Generator',
        yard: 'Wuse Event & Power',
        market: 'Wuse',
        place: 'Wuse Market',
        category: 'Generators',
        specification: '20 kVA · Diesel · 2024',
        thumbBadge: '20 kVA · 24',
        dailyRate: 22000,
        deposit: 40000,
        availability: MarketplaceAvailability.available,
        withOperator: true,
      ),
    ],
  );

  @override
  Future<MarketplaceCatalog> load() async => catalog;
}
