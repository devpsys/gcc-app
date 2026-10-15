import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';

const activeRental = (
  reference: 'BK-8842',
  title: 'Mika 100kVA Diesel Generator',
  location: 'Kugbo Generator Yard',
  released: false,
  returnBy: '17 Oct, 16:40',
  remaining: '2d left',
  depositAmount: '₦50,000',
  releasedDetail: '',
);

const releasedRental = (
  reference: 'BK-8842',
  title: 'Mika 100kVA Diesel Generator',
  location: 'Kugbo Generator Yard',
  released: true,
  returnBy: '',
  remaining: '',
  depositAmount: '₦50,000',
  releasedDetail: 'released 17 Oct',
);

const nearbyEquipment = <DashboardEquipment>[
  (
    title: 'Mika 100kVA Generator',
    place: 'Kugbo Yard · Kugbo',
    specification: '100 kVA · Diesel · 2023',
    available: true,
    availability: '',
    price: '₦35,000',
  ),
  (
    title: '5kW PA Sound System',
    place: 'Deepwell Rentals · Wuse',
    specification: '5 kW · 2 mics · 400 W',
    available: true,
    availability: '',
    price: '₦18,000',
  ),
  (
    title: '250A Welding Machine',
    place: 'Kugbo Yard · Kugbo',
    specification: '250 A · Petrol · 2022',
    available: false,
    availability: 'In use until 16 Oct',
    price: '₦8,500',
  ),
];

const recentOrders = <DashboardOrder>[
  (
    reference: 'OR-5521',
    title: '500 × Dangote 50kg Cement',
    status: 'Dei-Dei Bldg Materials · Out for delivery',
    amount: '₦3,062,500',
    complete: false,
  ),
  (
    reference: 'OR-5498',
    title: '12.5mm Y Rod, 12 lengths',
    status: 'Dei-Dei Bldg Materials · Delivered ✓',
    amount: '₦486,000',
    complete: true,
  ),
];

const vendorEarnings = (
  available: '₦486,200',
  awaitingCheck: '₦92,000',
  cautionDeposits: '₦150,000',
);

const waitingRequests = (
  count: 3,
  countdown: '06:12:40',
  headline: '100kVA Generator · 2 days',
  reference: 'BK-24817',
  customer: 'Mrs. Ngozi Okonkwo · 14 Oct',
  amount: '₦164,075',
);

const vendorFleet = (
  ready: 18,
  rented: 5,
  maintenance: 1,
  listed: 24,
  pendingVerification: 1,
  attention: <DashboardAttention>[],
);

const openDispute = (
  reference: 'DSP-0092',
  bookingReference: 'BK-24817',
  detail: '₦50,000 caution deposit is frozen.',
);

const nextShop = (
  distance: '120 m',
  route: 'Route #1',
  name: 'Bola Hardware',
  address: 'Kugbo Market Zone C, Line 4',
  coordinates: '9.0580° N, 7.4100° E',
);
