import 'package:gcc_app/features/booking/domain/lessee_booking.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';
import 'package:gcc_app/features/booking/presentation/gateway/lessee_bookings_gateway.dart';

class MockLesseeBookingsGateway implements LesseeBookingsGateway {
  const MockLesseeBookingsGateway();

  static final catalog = <LesseeBooking>[
    LesseeBooking(
      id: 'bk-24817',
      reference: 'BK-24817',
      title: 'Mika 100kVA Diesel Generator Set',
      yard: 'Kugbo Generator Yard',
      status: LesseeBookingStatus.actionNeeded,
      tab: LesseeBookingTab.active,
      amount: 164075,
      deposit: 50000,
      from: DateTime(2026, 10, 14, 8),
      to: DateTime(2026, 10, 17, 16, 40),
      mark: 'MIKA 100',
      depositHeld: true,
      statusDetail: 'Return condition recorded',
      listingId: 'mika-100',
    ),
    LesseeBooking(
      id: 'bk-24804',
      reference: 'BK-24804',
      title: '60kVA Diesel Generator Set',
      yard: 'Wuse Event & Power',
      status: LesseeBookingStatus.inUse,
      tab: LesseeBookingTab.active,
      amount: 96500,
      deposit: 25000,
      from: DateTime(2026, 10, 14, 7, 15),
      to: DateTime(2026, 10, 17, 9),
      mark: '60kVA',
      depositHeld: true,
      statusDetail: 'Return due 17 Oct, 09:00',
    ),
    LesseeBooking(
      id: 'bk-24744',
      reference: 'BK-24744',
      title: '5kW PA Sound System',
      yard: 'Deepwell Sound Rentals',
      status: LesseeBookingStatus.completed,
      tab: LesseeBookingTab.completed,
      amount: 42000,
      deposit: 15000,
      from: DateTime(2026, 10, 10),
      to: DateTime(2026, 10, 12),
      category: 'Audio',
      depositReleased: true,
      statusDetail: 'Deposit released 12 Oct, 18:20',
      rating: 5,
    ),
    LesseeBooking(
      id: 'bk-24690',
      reference: 'BK-24690',
      title: '250A Welding Machine',
      yard: 'Kugbo Generator Yard',
      status: LesseeBookingStatus.completed,
      tab: LesseeBookingTab.completed,
      amount: 28500,
      deposit: 20000,
      from: DateTime(2026, 9, 28),
      to: DateTime(2026, 9, 29),
      mark: '250A',
      category: 'Generators',
      depositReleased: true,
      statusDetail: 'Deposit released 29 Sep, 11:05',
      rating: 4,
    ),
    LesseeBooking(
      id: 'bk-24511',
      reference: 'BK-24511',
      title: '5HP Water Pump',
      yard: 'Utako Water & Pump Depot',
      status: LesseeBookingStatus.cancelled,
      tab: LesseeBookingTab.cancelled,
      amount: 18000,
      deposit: 10000,
      from: DateTime(2026, 9, 20),
      to: DateTime(2026, 9, 20),
      depositNeverCharged: true,
    ),
  ];

  @override
  Future<List<LesseeBooking>> load() async => catalog;
}
