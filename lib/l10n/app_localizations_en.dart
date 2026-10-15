// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GCC';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeHeadline => 'Ready for the next feature';

  @override
  String get homeBody =>
      'Shared navigation, appearance, and local preferences are in place. Marketplace features will be added on this foundation.';

  @override
  String get themeModeLabel => 'Appearance';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get environmentTitle => 'Environment';

  @override
  String get environmentDevelopment => 'Development';

  @override
  String get environmentStaging => 'Staging';

  @override
  String get environmentProduction => 'Production';

  @override
  String get apiNotConfigured => 'No API base URL is configured.';

  @override
  String get apiConfigured => 'API base URL is configured.';

  @override
  String get homeLoadFailed => 'Preferences could not be loaded.';

  @override
  String get themeSaveFailed => 'Appearance could not be saved.';

  @override
  String get retry => 'Try again';

  @override
  String get loading => 'Loading';

  @override
  String get openNavigationMenu => 'Open navigation menu';

  @override
  String get routeNotFound => 'This page does not exist.';

  @override
  String get goHome => 'Go to home';

  @override
  String get startupFailed => 'GCC could not start.';

  @override
  String get authAgentSignInTitle => 'Field agent sign in';

  @override
  String get authAgentSignInSubtitle =>
      'Enter the agent ID given to you by your coordinator.';

  @override
  String get authAgentIdLabel => 'Agent ID';

  @override
  String get authAgentIdHint => 'AG-0142';

  @override
  String get authScannerDivider => 'OR USE SCANNER';

  @override
  String get authScanQr => 'Scan QR';

  @override
  String get authScanQrHelp => 'Scan the QR code on your ID card.';

  @override
  String get authContinue => 'Continue';

  @override
  String get authContinueNeedsIdentifier => 'Enter your agent ID to continue.';

  @override
  String get authContinueNeedsValidIdentifier =>
      'Enter an ID like AG-0142 to continue.';

  @override
  String get authIdentifierInvalid => 'Enter an ID like AG-0142.';

  @override
  String authUnknownIdentifier(String identifier) {
    return 'We couldn\'t find $identifier. Check the ID, or contact your coordinator.';
  }

  @override
  String get authUnassignedTitle => 'No markets assigned';

  @override
  String get authUnassignedMessage =>
      'Your account is active but no markets are assigned yet. Contact Grace Uche to get your first market.';

  @override
  String get authLanguage => 'Language';

  @override
  String get authNotifications => 'Notifications';

  @override
  String get authNotificationsValue => 'On · SMS only';

  @override
  String get authOfflineSession => 'Offline? Use your last signed-in session.';

  @override
  String get authSupport => 'Support';

  @override
  String get authSupportPhone => '+234 803 441 2290';

  @override
  String get authEnterCodeTitle => 'Enter your code';

  @override
  String authCodeSentTo(String phone) {
    return 'Sent to $phone';
  }

  @override
  String get authSecurityNote => 'Encrypted Two-Factor Verification';

  @override
  String get authVerify => 'Verify';

  @override
  String get authOtpIncompleteReason => 'Enter all 6 digits to continue.';

  @override
  String get authOtpFieldLabel => 'Verification code';

  @override
  String get authOtpIncorrect => 'That code is not correct. Request a new one.';

  @override
  String get authDidntGetCode => 'Didn\'t get it?';

  @override
  String get authResendCode => 'Resend code';

  @override
  String get authUseDifferentNumber => 'Use a different number';

  @override
  String get authGenericFailure => 'Something went wrong. Try again.';

  @override
  String get authClose => 'Close';

  @override
  String get authLanguageCurrent => 'Current';

  @override
  String get authSave => 'Save';

  @override
  String get authSearchLanguages => 'Search languages';

  @override
  String get authSearchLanguagesHint => 'Search';

  @override
  String get authLanguageUnavailable =>
      'This language isn\'t available in the app yet.';

  @override
  String get authBack => 'Back';

  @override
  String get languageEnglishName => 'English';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishSample =>
      'Report equipment damage or return condition';

  @override
  String get languagePidginName => 'Pidgin';

  @override
  String get languagePidginNative => 'Naijá Pidgin';

  @override
  String get languagePidginSample =>
      'Gbe report if machine spoil or condition don change';

  @override
  String get languageHausaName => 'Hausa';

  @override
  String get languageHausaNative => 'Harshen Hausa';

  @override
  String get languageHausaSample => 'Sanya lamarin ciki';

  @override
  String get languageYorubaName => 'Yoruba';

  @override
  String get languageYorubaTitle => 'Yorùbá';

  @override
  String get languageYorubaNative => 'Èdè Yorùbá';

  @override
  String get languageYorubaSample => 'Ṣàlàà nínú rere';

  @override
  String get languageIgboName => 'Igbo';

  @override
  String get languageIgboNative => 'Asụsụ Igbo';

  @override
  String get languageIgboSample => 'Nzọọ ncha ahụ';

  @override
  String get onboardingChooseLanguage => 'Choose your language';

  @override
  String get onboardingChangeAnytime => 'You can change this any time.';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingContinueNeedsLanguage =>
      'Choose a language to continue.';

  @override
  String get onboardingTranslationsReviewed =>
      'Translations are reviewed by our language team.';

  @override
  String onboardingStep(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get onboardingRoleTitle => 'How will you use GCC?';

  @override
  String get onboardingRoleSubtitle =>
      'You can switch later from your profile.';

  @override
  String get onboardingRoleRentTitle => 'Rent or buy equipment';

  @override
  String get onboardingRoleRentBody =>
      'Browse generators, sound systems, pumps and building materials from verified vendors in your market.';

  @override
  String get onboardingRoleListTitle => 'List my equipment or goods';

  @override
  String get onboardingRoleListBody =>
      'Publish rental listings or bulk trade products, respond to booking requests, and get paid into your GCC wallet.';

  @override
  String get onboardingRoleBoth =>
      'Most people use both. Switch any time from Profile → Switch role.';

  @override
  String get onboardingRolePath => 'Profile → Switch role';

  @override
  String get onboardingJustLooking => 'I just want to look';

  @override
  String get onboardingContinueNeedsRole =>
      'Choose how you will use GCC to continue.';

  @override
  String get onboardingSignInTitle => 'Sign in';

  @override
  String get onboardingSignInSubtitle =>
      'Use the number the yard or business uses.';

  @override
  String get onboardingMobileLabel => 'Mobile Number';

  @override
  String get onboardingPhonePrefix => '+234';

  @override
  String get onboardingCodeHelp => 'Enter the 6-digit code we send you';

  @override
  String get onboardingCodePlaceholder => '• • • • • •';

  @override
  String get onboardingNewAccount =>
      'New here? We\'ll create your account when you verify.';

  @override
  String get onboardingSendCode => 'Send code';

  @override
  String get onboardingSendCodeNeedsPhone =>
      'Enter your mobile number to continue.';

  @override
  String get onboardingSendCodeNeedsFullPhone =>
      'Enter all 11 digits to continue.';

  @override
  String get onboardingAlreadyAccount => 'Already have a GCC account?';

  @override
  String get onboardingEmailInstead => 'Sign in with your email instead.';

  @override
  String get onboardingGenericFailure => 'Something went wrong. Try again.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get dashboardActionUnavailable =>
      'This isn\'t available in the app yet.';

  @override
  String get dashboardLoadFailed => 'The dashboard could not be loaded.';

  @override
  String get dashboardSectionFailed => 'This section could not be loaded.';

  @override
  String get dashboardRetry => 'Try again';

  @override
  String get dashboardLanguageShort => 'EN';

  @override
  String get dashboardNoLocation => 'Location not set';

  @override
  String get dashboardNoMarket => 'No market selected';

  @override
  String get dashboardHome => 'Home';

  @override
  String get dashboardBrowse => 'Browse';

  @override
  String get dashboardBookings => 'Bookings';

  @override
  String get dashboardWallet => 'Wallet';

  @override
  String get dashboardProfile => 'Profile';

  @override
  String get dashboardCatalog => 'Catalog';

  @override
  String get dashboardRequests => 'Requests';

  @override
  String get dashboardToday => 'Today';

  @override
  String get dashboardMap => 'Map';

  @override
  String get dashboardCapture => 'Capture';

  @override
  String get dashboardQueue => 'Queue';

  @override
  String get dashboardSearchHint => 'Search equipment or materials';

  @override
  String get dashboardFilters => 'Filters';

  @override
  String dashboardActiveRental(String reference) {
    return 'Active rental · $reference';
  }

  @override
  String dashboardCompletedRental(String reference) {
    return 'Completed · $reference';
  }

  @override
  String get dashboardNoActiveBookings => 'No active bookings';

  @override
  String get dashboardNoActiveBookingsBody =>
      'Rent equipment available around you, or check on a bulk order.';

  @override
  String dashboardNoActiveBookingsPlace(String place) {
    return 'Rent equipment available around $place, or check on a bulk order.';
  }

  @override
  String dashboardLastRental(String detail) {
    return 'Last rental: $detail';
  }

  @override
  String get dashboardBooked => 'Booked';

  @override
  String get dashboardReturned => 'Returned';

  @override
  String dashboardRefundableDeposit(String amount) {
    return '$amount refundable deposit';
  }

  @override
  String dashboardLastRequest(String when) {
    return 'Last request answered $when';
  }

  @override
  String get dashboardBrowseEquipment => 'Browse equipment';

  @override
  String dashboardReturnBy(String when) {
    return 'Return by $when';
  }

  @override
  String get dashboardDepositLabel => 'Refundable deposit held';

  @override
  String get dashboardEscrow => 'Escrow';

  @override
  String get dashboardReviewReturn => 'Review return condition';

  @override
  String get dashboardMessageVendor => 'Message vendor';

  @override
  String get dashboardDepositReleased => 'Deposit released';

  @override
  String dashboardDepositReleasedBody(String amount) {
    return '$amount is back in your wallet.';
  }

  @override
  String get dashboardViewWallet => 'View wallet';

  @override
  String get dashboardRateRental => 'Rate this rental';

  @override
  String get dashboardBrowseByCategory => 'Browse by category';

  @override
  String get dashboardCategoryGenerators => 'Generators';

  @override
  String get dashboardCategorySound => 'Sound & PA';

  @override
  String get dashboardCategoryLighting => 'Lighting';

  @override
  String get dashboardCategoryPumps => 'Pumps';

  @override
  String get dashboardCategoryWelding => 'Welding';

  @override
  String get dashboardCategoryMaterials => 'Materials';

  @override
  String get dashboardAvailableNearYou => 'Available near you';

  @override
  String get dashboardSeeAll => 'See all';

  @override
  String get dashboardAvailable => 'Available';

  @override
  String get dashboardPerDay => '/day';

  @override
  String get dashboardNoResults => 'Nothing is listed near you yet.';

  @override
  String get dashboardRecentOrders => 'Recent orders';

  @override
  String get dashboardNoOrders => 'No recent orders.';

  @override
  String dashboardRequestsWaiting(int count) {
    return '$count booking requests waiting';
  }

  @override
  String get dashboardRespondWithin => 'Respond within';

  @override
  String get dashboardRequestExpiry =>
      'Unanswered requests expire in 6 hours and go to the next vendor.';

  @override
  String get dashboardRespondToRequests => 'Respond to requests';

  @override
  String dashboardAllRequests(int count) {
    return 'All $count requests';
  }

  @override
  String get dashboardNoRequests => 'No requests waiting';

  @override
  String get dashboardNoRequestsBody =>
      'New booking requests arrive by SMS and appear here.';

  @override
  String get dashboardYourEquipment => 'Your equipment';

  @override
  String get dashboardManage => 'Manage';

  @override
  String get dashboardReadyForWork => 'Ready for work';

  @override
  String get dashboardRentedOut => 'Rented out';

  @override
  String get dashboardInMaintenance => 'In maintenance';

  @override
  String dashboardAssetsSummary(int listed, int pending) {
    return '$listed assets listed · $pending pending verification';
  }

  @override
  String dashboardFleetSegment(String label, int count) {
    return '$label: $count';
  }

  @override
  String get dashboardNoFleet => 'No equipment is listed yet.';

  @override
  String get dashboardEarnings => 'Earnings';

  @override
  String get dashboardAvailableToWithdraw => 'Available to withdraw';

  @override
  String get dashboardAwaitingCheck => 'Awaiting condition check';

  @override
  String get dashboardCautionDeposits => 'Held as caution deposits';

  @override
  String get dashboardWithdraw => 'Withdraw to bank';

  @override
  String get dashboardOpenWallet => 'Open wallet';

  @override
  String get dashboardNoEarnings => 'No earnings to show yet.';

  @override
  String get dashboardRecentBookings => 'Recent bookings';

  @override
  String get dashboardNoBookings => 'No recent bookings.';

  @override
  String get dashboardStatusInUse => 'In use';

  @override
  String get dashboardStatusDue => 'Check-in due';

  @override
  String get dashboardStatusCompleted => 'Completed';

  @override
  String get dashboardStatusDisputed => 'Disputed';

  @override
  String dashboardDisputeTitle(String reference) {
    return 'Dispute $reference is open';
  }

  @override
  String dashboardDisputeMessage(
    String dispute,
    String booking,
    String detail,
  ) {
    return 'Dispute $dispute is open on $booking. $detail';
  }

  @override
  String get dashboardViewDispute => 'View dispute';

  @override
  String get dashboardAddToHome => 'Add to home screen';

  @override
  String get dashboardGoodMorning => 'Good morning';

  @override
  String dashboardGoodMorningNamed(String name) {
    return 'Good morning, $name';
  }

  @override
  String get dashboardSyncChecking => 'Checking saved work';

  @override
  String get dashboardSyncEmpty => 'Nothing is waiting to sync.';

  @override
  String get dashboardSyncOffline => 'Offline';

  @override
  String get dashboardSyncSyncing => 'Syncing';

  @override
  String get dashboardSyncFailed => 'Sync failed';

  @override
  String get dashboardSyncSynced => 'Synced';

  @override
  String get dashboardOpenQueue => 'Open queue';

  @override
  String get dashboardTodayAtAGlance => 'Today at a glance';

  @override
  String get dashboardShopsAssigned => 'Shops assigned';

  @override
  String get dashboardCapturedToday => 'Captured today';

  @override
  String get dashboardPendingBounty => 'Pending bounty';

  @override
  String dashboardProgressLabel(int captured, int target) {
    return '$captured of $target shops captured today';
  }

  @override
  String dashboardDailyTarget(int count) {
    return 'Daily target: $count';
  }

  @override
  String get dashboardNoProgress => 'No shops are assigned today.';

  @override
  String get dashboardNextStop => 'Next stop';

  @override
  String dashboardAway(String distance) {
    return '$distance away';
  }

  @override
  String get dashboardStartCapture => 'Start capture';

  @override
  String get dashboardGetDirections => 'Get directions';

  @override
  String get dashboardAllDone => 'All assigned shops are done.';

  @override
  String dashboardSeeAllCount(int count) {
    return 'See all $count';
  }

  @override
  String get dashboardViewAll => 'View all';

  @override
  String get dashboardAssignedShops => 'Assigned shops';

  @override
  String get dashboardNoShops => 'No shops are on this route.';

  @override
  String get dashboardShopQueued => 'Captured · queued';

  @override
  String get dashboardShopSynced => 'Captured · synced';

  @override
  String get dashboardShopNotStarted => 'Not started';

  @override
  String get dashboardRecentSubmissions => 'Recent submissions';

  @override
  String get dashboardNoSubmissions => 'No submissions yet.';

  @override
  String get dashboardSubmissionQueued => 'Queued';

  @override
  String get dashboardSubmissionSynced => 'Synced';

  @override
  String get dashboardSubmissionApproved => 'Approved';

  @override
  String dashboardSubmissionApprovedAmount(String amount) {
    return 'Approved · $amount';
  }

  @override
  String get dashboardBountySnapshot => 'This week';

  @override
  String get dashboardPayoutPending => 'Payout pending';

  @override
  String get dashboardNoBounty => 'No bounty to show yet.';

  @override
  String get captureShopTitle => 'Capture shop';

  @override
  String get captureLocationTitle => 'Capture location';

  @override
  String captureAutosaved(String time) {
    return 'Autosaved $time';
  }

  @override
  String get captureActionNeeded => 'ACTION NEEDED';

  @override
  String captureAutosavedIncomplete(String time, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Autosaved $time · $count fields incomplete',
      one: 'Autosaved $time · 1 field incomplete',
    );
    return '$_temp0';
  }

  @override
  String get captureIncomplete => 'Incomplete';

  @override
  String get captureRequired => 'Required';

  @override
  String get captureOfflineReady => 'OFFLINE READY';

  @override
  String captureWizardSummary(int current, int total, String label) {
    return 'Step $current of $total, $label';
  }

  @override
  String captureStepEyebrow(int current, int total, String detail) {
    return 'Step $current of $total · $detail';
  }

  @override
  String get captureStepStart => 'START';

  @override
  String get captureStepAttention => 'ATTENTION';

  @override
  String captureStepActive(int current, int total) {
    return '$current / $total ACTIVE';
  }

  @override
  String get captureStepShop => 'Shop';

  @override
  String get captureStepLocation => 'Location';

  @override
  String get captureStepAssets => 'Assets';

  @override
  String get captureStepMedia => 'Media';

  @override
  String get captureShopDetails => 'Shop details';

  @override
  String get captureRequiredMark => '* Required';

  @override
  String get captureShopName => 'Shop name *';

  @override
  String get captureShopNameRequired => 'Shop name is required';

  @override
  String get captureShopNameHint => 'e.g. Bola Hardware';

  @override
  String get captureShopType => 'Shop type *';

  @override
  String get captureShopTypeEquipment => 'Equipment yard';

  @override
  String get captureShopTypeBulk => 'Bulk supplier';

  @override
  String get captureShopTypeBoth => 'Both';

  @override
  String get captureShopTypeRequired => 'Choose a shop type';

  @override
  String get captureOwnerName => 'Owner name *';

  @override
  String get captureOwnerNameRequired => 'Enter the owner\'s full name';

  @override
  String get captureOwnerNameHint => 'e.g. Alhaji Musa Ibrahim';

  @override
  String get captureContactHeading => 'Contact & Messaging';

  @override
  String get captureNigeriaPrefix => 'NIGERIA (+234)';

  @override
  String get capturePhonePrefix => '+234';

  @override
  String get capturePhoneNumber => 'Phone number *';

  @override
  String get capturePhoneRequired => 'Enter a phone number';

  @override
  String get captureWhatsApp => 'WhatsApp';

  @override
  String get captureSameAsPhone => 'Same as phone';

  @override
  String get captureUsingPhoneAbove => 'Using phone above';

  @override
  String get captureUsingPhoneAboveBody => 'Using the phone number above';

  @override
  String get captureWhatTheySell => 'What they sell';

  @override
  String get captureCategoriesHint =>
      'Select all that apply. This decides where the shop appears.';

  @override
  String captureCategoriesSelected(int count) {
    return '$count SELECTED';
  }

  @override
  String get captureCategoryRequired => 'Select at least one category';

  @override
  String get captureCategoryGenerators => 'Generators';

  @override
  String get captureCategoryWelding => 'Welding';

  @override
  String get captureCategoryWaterPumps => 'Water pumps';

  @override
  String get captureCategoryBuilding => 'Building materials';

  @override
  String get captureCategoryElectrical => 'Electrical';

  @override
  String get captureCategoryCatering => 'Catering';

  @override
  String get captureCategorySound => 'Sound & PA';

  @override
  String get captureCategoryParts => 'Generators (parts)';

  @override
  String get captureCategoryBeverages => 'Beverages';

  @override
  String get captureCategoryLighting => 'Lighting';

  @override
  String get captureCategoryCompression => 'Compression';

  @override
  String get captureCategoryFertilizer => 'Fertilizer';

  @override
  String get captureSaveDraft => 'Save draft';

  @override
  String get captureContinue => 'Continue';

  @override
  String get captureContinueNeedsIdentity =>
      'Fill in the shop name and owner to continue';

  @override
  String captureValidationBanner(int count) {
    return '$count fields need attention';
  }

  @override
  String get captureLandmark => 'Landmark';

  @override
  String get captureLandmarkHint =>
      'e.g. beside Bola Hardware, near the main gate';

  @override
  String get captureSpatialTagging => 'Spatial tagging';

  @override
  String get captureHierarchyTitle => 'Verified spatial hierarchy';

  @override
  String get captureSelectorsHeading => 'Hierarchical selectors';

  @override
  String get captureHierarchyAssigned => 'ALL ASSIGNED';

  @override
  String get captureHierarchyPending => 'NOT ASSIGNED';

  @override
  String get captureNotSet => 'Not set';

  @override
  String get captureMarket => 'Market';

  @override
  String get captureZone => 'Zone';

  @override
  String get captureLine => 'Line';

  @override
  String get captureLineCurrent => 'Line (current)';

  @override
  String get captureChooseMarket => 'Choose a market';

  @override
  String get captureChooseZone => 'Choose a zone';

  @override
  String get captureChooseLine => 'Choose a line';

  @override
  String get captureHierarchyHint =>
      'Zones and lines come from the market map. If a line isn\'t listed, describe it in the landmark box.';

  @override
  String captureClusterChip(String name) {
    return '$name cluster';
  }

  @override
  String get captureNoSignalBanner =>
      'We can\'t pin this shop. You can still capture it — an admin will verify the location from your landmark description.';

  @override
  String get captureNoSignalTitle => 'No location signal';

  @override
  String get captureNoSignalBody => 'Your device can\'t see a GPS fix';

  @override
  String get captureMapDisabledTitle => 'Map pin disabled';

  @override
  String get captureMapDisabledBody =>
      'GPS satellite signal unavailable indoors or under zinc roofs';

  @override
  String get captureEnterCoordinates => 'Enter coordinates manually';

  @override
  String get capturePinNote =>
      'The pin is a backup. The landmark description is how vendors find each other.';

  @override
  String get captureLandmarkContext =>
      'Landmarks are informal in the markets. Use what vendors and agents call the place — the map pin helps us verify the shop, but it isn\'t how people navigate.';

  @override
  String get capturePickerSearch => 'Search';

  @override
  String get capturePickerUnlisted => 'Unlisted?';

  @override
  String capturePickerCustom(String query) {
    return 'Use \"$query\" as custom text';
  }

  @override
  String get capturePickerEmpty =>
      'Nothing is assigned for this capture yet. Type a name and select it.';

  @override
  String get capturePickerDone => 'Done';

  @override
  String capturePickerSelect(String value) {
    return 'Select $value';
  }

  @override
  String get captureLandmarkRequired => 'Add a landmark to continue';

  @override
  String get captureContinueWithoutPin =>
      'Submitting without a pin — an admin will verify this location';

  @override
  String get captureAssetsTitle => 'Capture assets';

  @override
  String get captureAssetCatalogHeading => 'Equipment Catalog';

  @override
  String get captureAssetSectionA => 'Section A · Equipment type';

  @override
  String get captureAssetSectionB => 'Section B · Details';

  @override
  String get captureAssetSectionC => 'Section C · Availability';

  @override
  String get captureAssetSectionCEyebrow =>
      'Routes this asset to a catalog mode';

  @override
  String get captureAssetCategoryLabel => 'Category *';

  @override
  String get captureAssetMakeLabel => 'Make';

  @override
  String get captureAssetCapacityLabel => 'Capacity / size *';

  @override
  String get captureAssetModelLabel => 'Model';

  @override
  String get captureAssetYearLabel => 'Year';

  @override
  String get captureAssetSerialLabel => 'Serial number';

  @override
  String get captureAssetScan => 'Scan';

  @override
  String get captureAssetChooseCategory => 'Choose a category';

  @override
  String get captureAssetChooseMake => 'Choose a make';

  @override
  String get captureAssetCategoryRequired => 'Choose an equipment category';

  @override
  String get captureAssetCapacityRequired => 'Enter the capacity or size';

  @override
  String get captureAssetCategoryMissing => 'Add a category';

  @override
  String get captureAssetCapacityMissing => 'Add the capacity or size';

  @override
  String get captureAssetCapacityHint => 'e.g. 100 kVA';

  @override
  String get captureAssetModelHint => 'e.g. MG-100';

  @override
  String get captureAssetYearHint => 'e.g. 2021';

  @override
  String get captureAssetSerialHint => 'e.g. MG100-2291';

  @override
  String get captureAssetQuantityLabel => 'Quantity';

  @override
  String get captureAssetConditionLabel => 'Condition grade *';

  @override
  String get captureAssetConditionNew => 'New';

  @override
  String get captureAssetConditionGood => 'Good';

  @override
  String get captureAssetConditionFair => 'Fair';

  @override
  String get captureAssetConditionService => 'Needs svc';

  @override
  String get captureAssetConditionNewHelp =>
      'New — pristine condition, never deployed on-site.';

  @override
  String get captureAssetConditionGoodHelp =>
      'Good — works as intended, normal wear.';

  @override
  String get captureAssetConditionFairHelp =>
      'Fair — works, but shows visible wear.';

  @override
  String get captureAssetConditionServiceHelp =>
      'Needs service — has faults the vendor should fix.';

  @override
  String get captureAssetAvailabilityRental => 'Rental only';

  @override
  String get captureAssetAvailabilityBulk => 'Bulk only';

  @override
  String get captureAssetAvailabilityBoth => 'Both';

  @override
  String get captureAssetRentalHelperTitle => 'Rental catalog flow';

  @override
  String get captureAssetRentalHelperBody =>
      'Rental assets appear in the rentals catalog. They need a daily rate, a refundable caution deposit and micro-insurance — the vendor sets these after verification.';

  @override
  String get captureAssetBulkHelperTitle => 'Bulk catalog flow';

  @override
  String get captureAssetBulkHelperBody =>
      'Bulk assets appear in the wholesale catalog, where buyers request quantities rather than book dates. No daily rate or caution deposit is needed.';

  @override
  String get captureAssetBothHelperTitle => 'Both catalogs';

  @override
  String get captureAssetBothHelperBody =>
      'This asset is listed in the rentals catalog and the wholesale catalog, so it can be booked or bought.';

  @override
  String get captureAssetChangeLater =>
      'You can change this later from the app.';

  @override
  String get captureAssetAddAnother => '+ Add another asset';

  @override
  String get captureAssetAddFirst => '+ Add first asset';

  @override
  String get captureAssetEmptyTitle => 'No assets added yet';

  @override
  String get captureAssetEmptyBody =>
      'Add the shop\'s main equipment, or submit the shop on its own.';

  @override
  String get captureAssetRemove => 'Remove';

  @override
  String captureAssetInProgress(Object reference) {
    return '$reference (in progress)';
  }

  @override
  String captureAssetQuantityValue(Object value) {
    return 'Quantity $value';
  }

  @override
  String get captureAssetDecrease => 'Decrease quantity';

  @override
  String get captureAssetIncrease => 'Increase quantity';

  @override
  String captureAssetReference(Object id) {
    return 'AST-$id';
  }

  @override
  String get captureAssetSubmitWithoutAssets => 'Continue without assets';

  @override
  String get captureAssetPrimaryLabel => 'Continue to media';

  @override
  String get captureAssetConditionRequired => 'Choose a condition grade';

  @override
  String captureAssetCountLabel(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count assets captured.',
      one: '1 asset captured.',
    );
    return '$_temp0';
  }

  @override
  String get captureAssetBountyAmount =>
      'The bounty is ₦5,000 per shop, not per asset.';
}
