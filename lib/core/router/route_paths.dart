abstract final class RoutePaths {
  static const String home = '/';
  static const String settings = '/settings';
  static const String agentToday = '/agent';
  static const String captureShop = '/agent/capture/shop';
  static const String captureLocation = '/agent/capture/location';
  static const String captureGps = '/agent/capture/gps';
  static const String captureAssets = '/agent/capture/assets';
  static const String captureMedia = '/agent/capture/media';
  static const String captureCompress = '/agent/capture/compress';
  static const String captureReview = '/agent/capture/review';
  static const String captureDone = '/agent/capture/done';
  static const String agentQueue = '/agent/queue';
  static const String agentQueueItem = '/agent/queue/:reference';
  static const String agentShops = '/agent/shops';
  static const String agentMap = '/agent/map';
  static const String agentWallet = '/agent/wallet';
  static const String agentProfile = '/agent/profile';
  static const String agentNotifications = '/agent/profile/notifications';
  static const String agentBountyStatus = '/agent/bounty/:reference';
  static const String onboardingLanguage = '/onboarding/language';
  static const String onboardingRole = '/onboarding/role';
  static const String onboardingSignIn = '/onboarding/sign-in';
  static const String agentSignIn = '/auth/agent/sign-in';
  static const String agentVerify = '/auth/agent/verify';
  static const String biometricUnlock = '/auth/unlock';
  static const String vendorCatalog = '/vendor/catalog';
  static const String vendorAssetEdit = '/vendor/catalog/edit/:reference';
  static const String vendorRequests = '/vendor/requests';
  static const String vendorWallet = '/vendor/wallet';
  static const String vendorWithdraw = '/vendor/wallet/withdraw';
  static const String vendorProfile = '/vendor/profile';
  static const String vendorNotifications = '/vendor/profile/notifications';
  static const String wallet = '/wallet';
  static const String walletWithdraw = '/wallet/withdraw';
  static const String profile = '/profile';
  static const String browse = '/browse';
  static const String marketplaceListing = '/browse/:id';
  static const String rentalRequest = '/browse/:id/request';
  static const String rentalPayment = '/browse/:id/payment';
  static const String rentalPaymentStatus = '/browse/:id/payment/status';
  static const String bookings = '/bookings';
  static const String bookingDetail = '/bookings/:id';
  static const String handback = '/bookings/:id/handback';

  static String bookingDetailOf(String id) => '/bookings/$id';

  static String handbackOf(String id) => '/bookings/$id/handback';

  static String vendorAssetEditOf(String reference) =>
      '/vendor/catalog/edit/$reference';

  static String marketplaceListingOf(String id) => '/browse/$id';

  static String rentalRequestOf(String id) => '/browse/$id/request';

  static String rentalPaymentOf(String id) => '/browse/$id/payment';

  static String rentalPaymentStatusOf(String id) =>
      '/browse/$id/payment/status';
}
