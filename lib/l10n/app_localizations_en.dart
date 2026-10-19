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
  String get onboardingEmailInstead => 'Sign in with your agent ID instead.';

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

  @override
  String get gpsHelperTitle => 'Improve accuracy';

  @override
  String get gpsHelperClose => 'Close';

  @override
  String get gpsSignalWeak => 'Signal weak';

  @override
  String get gpsSignalGood => 'Signal good';

  @override
  String gpsAccuracyValue(Object value) {
    return '±$value m';
  }

  @override
  String get gpsAccuracyTarget => 'Target ±25 m or better';

  @override
  String get gpsStepOpenSky => 'Step into the open sky';

  @override
  String get gpsStepHoldStill => 'Hold still for 5 seconds';

  @override
  String get gpsStepAwayFromMetal => 'Move away from metal roofs and walls';

  @override
  String get gpsAcquiring => 'Acquiring fix…';

  @override
  String gpsSecondsShort(Object count) {
    return '$count s';
  }

  @override
  String get gpsTryAgain => 'Try again';

  @override
  String get gpsUseLastKnown => 'Use last known location';

  @override
  String get gpsEnterCoordinates => 'Enter coordinates manually';

  @override
  String get gpsPermissionTitle => 'Location access is off';

  @override
  String get gpsPermissionBody =>
      'GCC uses your location to verify shops you map. Without it, bounties may take longer to approve.';

  @override
  String get gpsHowToAllow => 'How to allow location';

  @override
  String get gpsAllowStep1 => 'Open Settings';

  @override
  String get gpsAllowStep2 => 'Permissions';

  @override
  String get gpsAllowStep3 => 'Location';

  @override
  String get gpsAllowFootnote =>
      'GPS coordinates required for rapid automated bounty payout.';

  @override
  String get gpsTurnOnLocation => 'Turn on location';

  @override
  String get gpsOpenSettings => 'Open Settings';

  @override
  String get gpsCoordinatesTitle => 'Enter coordinates';

  @override
  String get gpsCoordinatesHeading => 'Enter coordinates manually';

  @override
  String get gpsCoordinatesHelper =>
      'Read them off any map app. Use decimal degrees.';

  @override
  String get gpsLatitude => 'Latitude';

  @override
  String get gpsLongitude => 'Longitude';

  @override
  String get gpsDirectionNorth => '° N';

  @override
  String get gpsDirectionEast => '° E';

  @override
  String get gpsLatitudeRange => 'Latitude must be between -90 and 90';

  @override
  String get gpsLongitudeRange => 'Longitude must be between -180 and 180';

  @override
  String get gpsSaveCoordinates => 'Save coordinates';

  @override
  String get gpsDiscardCoordinates => 'Discard';

  @override
  String get gpsLatitudeExample => '9.0580';

  @override
  String get gpsLongitudeExample => '7.3986';

  @override
  String get gpsContinueWithFix => 'Use this location';

  @override
  String get gpsContinueWithoutFix => 'Continue without a verified fix';

  @override
  String get captureMediaTitle => 'Capture media';

  @override
  String captureMediaStep(Object current, Object total) {
    return 'Step $current of $total · Photo & video';
  }

  @override
  String get captureWhatToFilm => 'What to film';

  @override
  String captureWhatToFilmReady(Object done, Object total) {
    return '$done/$total ready';
  }

  @override
  String captureWhatToFilmComplete(Object done, Object total) {
    return '$done/$total complete';
  }

  @override
  String captureWhatToFilmExpand(Object count) {
    return 'View all $count';
  }

  @override
  String get captureWhatToFilmCollapse => 'Collapse';

  @override
  String get captureFilmWholeMachine => 'Whole machine from all four sides';

  @override
  String get captureFilmExistingDamage => 'Existing damage and wear';

  @override
  String get captureFilmSerialPlate => 'Serial number plate';

  @override
  String get captureFilmFluidLevels => 'Fuel and fluid levels';

  @override
  String get captureFilmAccessories => 'Accessories and attachments';

  @override
  String get captureKeepInFrame => 'Keep the whole machine in frame';

  @override
  String get captureClipLengthLabel => '30s CLIP';

  @override
  String get captureRetake => 'Retake';

  @override
  String get captureUsePhoto => 'Use photo';

  @override
  String get captureRecordClip => 'Record 30s';

  @override
  String get captureRecordingTitle => 'Recording condition clip';

  @override
  String get captureRecordingBadge => '● RECORDING';

  @override
  String captureRecordingElapsed(Object elapsed) {
    return 'REC: ${elapsed}s / 30s MINIMUM';
  }

  @override
  String get captureRecordingHint => 'Tap square to finish early (≥30s)';

  @override
  String get captureAlmostDone => 'Almost done — keep it steady';

  @override
  String captureTimerValue(Object seconds) {
    return '00:$seconds';
  }

  @override
  String get capturePermissionBadge => 'CAMERA BLOCKED';

  @override
  String get capturePermissionTitle => 'Camera access is off';

  @override
  String get capturePermissionHowTo => 'How to allow camera access';

  @override
  String get capturePermissionStep3 => 'Camera → Allow while using app';

  @override
  String get captureTurnOnCamera => 'Turn on camera';

  @override
  String get captureContinueWithoutVideo => 'Continue without video';

  @override
  String get captureIncompleteClipBadge => 'INCOMPLETE CLIP';

  @override
  String captureClipTooShort(Object seconds) {
    return 'Recording stopped after $seconds s — the minimum is 30 seconds.';
  }

  @override
  String get captureClipTooShortWhy =>
      'Clip too short for warranty dispute audit';

  @override
  String get captureRerecord => 'Re-record 30s video';

  @override
  String captureUseWhatWeHave(Object seconds) {
    return 'Use what we have ($seconds s)';
  }

  @override
  String captureGalleryCount(Object count) {
    return '$count';
  }

  @override
  String get captureStartRecording => 'Start recording';

  @override
  String get captureStopRecording => 'Stop recording';

  @override
  String captureGalleryThumbnail(Object count) {
    return 'Open gallery, $count items';
  }

  @override
  String get captureSignalVerified => 'Location pinned';

  @override
  String get captureUnverifiedPlace => 'Unverified';

  @override
  String captureAccuracyValue(Object value) {
    return '±$value m';
  }

  @override
  String get capturePermissionBody =>
      'A condition clip protects the vendor if a rental is disputed. Without it, disputes are harder to settle.';

  @override
  String get compressTitle => 'Preparing video';

  @override
  String get compressTitleUploading => 'Uploading clip';

  @override
  String get compressDuration => '00:30';

  @override
  String get compressFormat => '1080p · MP4';

  @override
  String get compressStepOptimised => 'Compressed 1080p → optimised';

  @override
  String compressStepCompressing(Object seconds) {
    return 'Compressing in $seconds s…';
  }

  @override
  String get compressStepSaved => 'File saved to this phone';

  @override
  String get compressStepQueued => 'Queued — uploads automatically';

  @override
  String get compressStepUploading => 'Uploading when you\'re on data';

  @override
  String get compressStepPaused => 'Paused — waiting for power';

  @override
  String compressProgress(Object percent) {
    return '$percent%';
  }

  @override
  String compressUploadingDetail(Object done, Object total) {
    return 'Uploading · $done of $total';
  }

  @override
  String compressTransferRate(Object rate, Object seconds) {
    return '≈ $rate · about $seconds left';
  }

  @override
  String get compressNote =>
      'Compression happens on this phone. Your video never leaves uncompressed — GCC uploads a small file so your data lasts.';

  @override
  String get compressQualityHeading => 'Quality options';

  @override
  String get compressQualitySmallest => 'Smallest';

  @override
  String get compressQualityBalanced => 'Balanced';

  @override
  String get compressQualityOriginal => 'Original 1080p';

  @override
  String get compressQualitySmallestHint => 'Best quality for reviews';

  @override
  String get compressQualityBalancedHint => 'Sharper, larger file';

  @override
  String get compressQualityOriginalHint => 'Not recommended on 3G';

  @override
  String get compressRecommended => 'Recommended';

  @override
  String compressApproxOn3g(Object duration) {
    return '≈$duration on 3G';
  }

  @override
  String get compressChooseQuality => 'Choose a different quality';

  @override
  String get compressContinue => 'Continue';

  @override
  String get compressQueuedBadge => 'Pending 3G';

  @override
  String get compressDoneBadge => 'Done';

  @override
  String get compressSelectedProfile => 'Selected profile';

  @override
  String compressDraftSynced(Object reference) {
    return 'Your submission draft is synced with offline queue item $reference';
  }

  @override
  String get compressUploadOnWifi => 'Upload now if you\'re on Wi-Fi';

  @override
  String get compressWaitForUpload => 'Wait for the upload to finish';

  @override
  String get compressContinueBackground => 'Continue in background';

  @override
  String compressNetworkWarning(Object network) {
    return 'Connected to $network. Do not close this app until complete.';
  }

  @override
  String get compressStorageBadge => 'Space Low';

  @override
  String get compressStorageTitle => 'Not enough storage on this phone';

  @override
  String compressStorageReason(Object cache, Object free, Object required) {
    return '$required required to upload, $free free. Cached upload history takes $cache';
  }

  @override
  String get compressStorageHeading => 'What\'s taking space';

  @override
  String get compressSpaceHistory => 'Cached upload history';

  @override
  String get compressSpacePhotos => 'Shop photos';

  @override
  String get compressSpaceMaps => 'Downloaded maps';

  @override
  String get compressClear => 'Clear';

  @override
  String get compressFreeUpSpace => 'Free up space';

  @override
  String get compressUploadLater => 'Upload later';

  @override
  String get compressBatteryBadge => 'Safe';

  @override
  String compressBatteryReason(Object percent) {
    return 'Low battery — $percent% remaining';
  }

  @override
  String compressSavedTo(Object destination) {
    return 'Saved to $destination';
  }

  @override
  String get reviewTitle => 'Review & submit';

  @override
  String get reviewSectionShop => 'Shop';

  @override
  String get reviewSectionLocation => 'Location';

  @override
  String get reviewSectionAssets => 'Assets';

  @override
  String get reviewSectionMedia => 'Media';

  @override
  String get reviewLabelShopName => 'Shop name';

  @override
  String get reviewLabelShopType => 'Shop type';

  @override
  String get reviewLabelOwner => 'Owner';

  @override
  String get reviewLabelPhone => 'Phone';

  @override
  String get reviewLabelSells => 'Sells';

  @override
  String get reviewLabelMarket => 'Market';

  @override
  String get reviewLabelZone => 'Zone';

  @override
  String get reviewLabelLine => 'Line';

  @override
  String get reviewLabelLandmark => 'Landmark';

  @override
  String reviewCoordinates(Object accuracy, Object latitude, Object longitude) {
    return '$latitude° N, $longitude° E · $accuracy';
  }

  @override
  String get reviewLandmarkMissing => '[Missing description]';

  @override
  String get reviewLandmarkMissingWhy =>
      'Add a landmark description — shops without one can\'t be verified';

  @override
  String get reviewGpsOnly => 'GPS only';

  @override
  String get reviewLandmarkMissingBadge => 'Landmark missing';

  @override
  String get reviewEdit => 'Edit';

  @override
  String get reviewFixNow => 'Fix now →';

  @override
  String reviewAssetsCaptured(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count assets captured',
      one: '1 asset captured',
    );
    return '$_temp0';
  }

  @override
  String get reviewRetake => 'Retake';

  @override
  String get reviewMediaPhoto => 'Shopfront';

  @override
  String get reviewMediaPhotoHint => 'Exterior facade & sign';

  @override
  String reviewMediaClip(Object duration) {
    return 'Condition clip · $duration';
  }

  @override
  String get reviewMediaWalkaround => '360° walkaround proof';

  @override
  String reviewMediaCompressed(Object original) {
    return 'Compressed from $original on this phone';
  }

  @override
  String get reviewBountyEyebrow => 'BOUNTY IF VERIFIED';

  @override
  String reviewBountyNote(Object count, Object earned) {
    return '$earned earned from $count verified shops this week.';
  }

  @override
  String get reviewSubmit => 'Submit';

  @override
  String get reviewSaveDraft => 'Save draft';

  @override
  String get reviewOfflineBadge => 'Offline · this will be queued';

  @override
  String get reviewOfflineReason =>
      'Offline. Submit will save to this phone and upload automatically.';

  @override
  String reviewNeedsAttention(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fields need attention',
      one: '1 field needs attention',
    );
    return '$_temp0';
  }

  @override
  String get reviewBlockedReason => 'Add a landmark description to submit';

  @override
  String get queuedTitle => 'Shop captured';

  @override
  String queuedShopLine(Object market, Object shop) {
    return '$shop · $market';
  }

  @override
  String get queuedUploadedHeadline => 'Uploaded and sent to review';

  @override
  String get queuedOfflineHeadline => 'Saved on this phone';

  @override
  String get queuedVerificationNote =>
      'An admin checks every shop before the bounty is paid. Usually within 24 hours.';

  @override
  String get queuedLabelReference => 'Reference';

  @override
  String get queuedLabelCaptured => 'Captured';

  @override
  String get queuedLabelAssets => 'Assets';

  @override
  String get queuedLabelMedia => 'Media';

  @override
  String get queuedLabelBounty => 'Bounty';

  @override
  String get queuedPendingVerification => 'Pending verification';

  @override
  String get queuedWhatNext => 'What happens next';

  @override
  String get queuedStepReview => 'An admin reviews the shop and photos';

  @override
  String get queuedStepApproved => 'If it\'s approved,';

  @override
  String get queuedStepPayout => 'goes into your next payout run';

  @override
  String get queuedStepSms =>
      'You\'ll get an SMS when the verdict comes through';

  @override
  String get queuedStepQueued =>
      'Your shop is queued and uploads when you\'re online';

  @override
  String get queuedCaptureAnother => 'Capture another';

  @override
  String get queuedBackToToday => 'Back to today';

  @override
  String get queuedViewQueue => 'View my queue';

  @override
  String queuedDailyMilestone(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shops captured today',
      one: '1 shop captured today',
    );
    return '$_temp0';
  }

  @override
  String queuedDailyPending(Object amount) {
    return '$amount pending';
  }

  @override
  String compressSizePair(Object after, Object before) {
    return '$before → $after';
  }

  @override
  String get compressNetworkName => 'Kugbo_Fast_WiFi';

  @override
  String get compressQueueReference => 'SUB-2204';

  @override
  String get syncItemMissing => 'This submission is not in the queue.';

  @override
  String get syncQueueTitle => 'Sync queue';

  @override
  String get syncStripOffline => 'Offline';

  @override
  String get syncStripDataLimit => 'DATA LIMIT';

  @override
  String syncStripLastSynced(Object time) {
    return 'Last synced $time';
  }

  @override
  String syncStripSyncing(Object done, Object total) {
    return '◐ Syncing · $done of $total';
  }

  @override
  String get syncLabelConnection => 'Connection';

  @override
  String get syncLabelLastSync => 'Last sync';

  @override
  String get syncLabelStorage => 'Storage';

  @override
  String get syncLabelQueued => 'Queued';

  @override
  String get syncConnectionOffline => 'Offline';

  @override
  String get syncConnectionOnline => '4G LTE · Online';

  @override
  String get syncConnectionCapped => 'Limit capped';

  @override
  String get syncConnectionWeak => '3G · weak';

  @override
  String get syncLastInProgress => 'In progress…';

  @override
  String get syncJustNow => 'Just now';

  @override
  String syncStorageFree(Object free, Object total) {
    return '$free free of $total';
  }

  @override
  String syncQueuedCount(Object count, Object size) {
    return '$count items · $size';
  }

  @override
  String get syncQueuedNothing => 'Nothing waiting';

  @override
  String syncStorageCaption(Object free, Object total) {
    return '$free free of $total';
  }

  @override
  String get syncNow => 'Sync now';

  @override
  String get syncUploadWifiOnly => 'Upload on Wi-Fi only';

  @override
  String get syncProcessingBatch => 'Processing Batch';

  @override
  String get syncPause => 'Pause';

  @override
  String syncWaitingToUpload(Object count) {
    return 'Waiting to upload ($count)';
  }

  @override
  String get syncFilter => 'Filter';

  @override
  String get syncDiscardFailed => 'Discard failed items';

  @override
  String syncProgressPercent(Object percent) {
    return '$percent% completed';
  }

  @override
  String syncBatchProgress(
    Object done,
    Object doneSize,
    Object total,
    Object totalSize,
  ) {
    return 'Syncing $done of $total · $doneSize of $totalSize';
  }

  @override
  String get syncCloseHint => 'You can close this screen. Syncing continues.';

  @override
  String syncUploadBlocked(Object date) {
    return 'Upload blocked — daily data limit reached (2 GB). Resets $date.';
  }

  @override
  String get syncAllSyncedHeadline => 'Everything is synced';

  @override
  String syncAllSyncedDetail(num count, Object time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count submissions',
      one: '1 submission',
    );
    return 'Last sync $time · $_temp0 this week';
  }

  @override
  String get syncViewSubmitted => 'View submitted shops';

  @override
  String get syncBountyHeadline => 'Your bounty is';

  @override
  String syncBountyAmount(Object amount, num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count verified shops',
      one: '1 verified shop',
    );
    return '$amount for $_temp0 in this run.';
  }

  @override
  String get syncItemQueued => 'Queued';

  @override
  String get syncItemSyncing => '◐ Uploading';

  @override
  String get syncItemSynced => '✓ Synced';

  @override
  String get syncItemFailed => '✕ Failed';

  @override
  String syncItemCaptured(num count, Object time) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return 'Captured $time · $_temp0';
  }

  @override
  String syncItemSizes(Object photos, Object videos) {
    return '$photos photo + $videos video';
  }

  @override
  String syncItemTotal(Object size) {
    return '$size total payload';
  }

  @override
  String syncItemUploading(Object done, Object percent, Object total) {
    return '$percent % · $done of $total';
  }

  @override
  String syncItemSyncedAt(Object time) {
    return 'Synced $time';
  }

  @override
  String syncItemFailedReason(Object seconds) {
    return 'Network timeout after $seconds s';
  }

  @override
  String get syncItemFailedData =>
      'Upload blocked — daily data limit reached (2 GB).';

  @override
  String syncOpensQueueItem(Object shop) {
    return 'Open $shop queue item';
  }

  @override
  String get itemTitle => 'Queue item';

  @override
  String get itemFailedBadge => 'Network timeout';

  @override
  String itemFailedHeadline(Object reason) {
    return '✕ Upload failed · $reason';
  }

  @override
  String get itemRetry => 'Retry';

  @override
  String itemSyncedBadge(Object time) {
    return '✓ Synced $time';
  }

  @override
  String itemSyncedHeadline(Object time) {
    return 'Synced $time';
  }

  @override
  String get itemVerifiedHeadline => '100% verified';

  @override
  String itemProgressLabel(Object done, Object total) {
    return '$done / $total';
  }

  @override
  String get itemCaptureData => 'Capture data';

  @override
  String get itemLabelShop => 'Shop';

  @override
  String get itemLabelOwner => 'Owner';

  @override
  String get itemLabelLocation => 'Location';

  @override
  String get itemLabelGps => 'GPS';

  @override
  String get itemLabelCaptured => 'Captured';

  @override
  String get itemLabelDevice => 'Device';

  @override
  String get itemFiles => 'Files';

  @override
  String itemGpsAtCapture(Object accuracy) {
    return '$accuracy at capture';
  }

  @override
  String get itemWhyFailed => 'Why did this fail?';

  @override
  String get itemRetryUpload => 'Retry upload';

  @override
  String get itemEditOnDevice => 'Edit on device';

  @override
  String get itemDiscard => 'Discard this submission';

  @override
  String get itemDelivered => 'Delivered safely to central ingest servers.';

  @override
  String get itemSentToReview => 'Uploaded and sent to review';

  @override
  String itemSentToReviewBody(Object amount) {
    return 'An admin will verify this shop, usually within 24 hours. Your bounty of $amount will unlock upon approval.';
  }

  @override
  String get itemViewSubmission => 'View submission';

  @override
  String get itemEditLocked => 'Submissions can\'t be edited after upload.';

  @override
  String get itemConflictHeadline => 'Someone else mapped this shop first';

  @override
  String itemConflictAgent(Object name) {
    return '$name';
  }

  @override
  String itemConflictAgentId(Object id) {
    return '$id';
  }

  @override
  String get itemConflictMapped => 'Mapped first';

  @override
  String get itemConflictVerified => 'Verified first';

  @override
  String get itemFileNotUploaded => 'Not uploaded';

  @override
  String itemFileSyncedAt(Object time) {
    return '✓ Synced $time';
  }

  @override
  String get itemConflictRetained =>
      'Local media retained safely in offline storage.';

  @override
  String get itemDiscardMyCopy => 'Discard my copy';

  @override
  String get itemKeepForReference => 'Keep for reference';

  @override
  String get itemDiscardConfirm =>
      'Discarding requires 2-step confirmation. No data lost.';

  @override
  String get itemDiscardedHeadline => 'Submission discarded';

  @override
  String itemDiscardedBody(Object amount, Object shop) {
    return '$shop was removed from this phone. The $amount bounty is no longer claimable for this shop.';
  }

  @override
  String itemStorageReclaimed(Object device, Object size) {
    return '$size storage reclaimed on $device';
  }

  @override
  String get itemBackToQueue => 'Back to sync queue';

  @override
  String get itemCaptureAnother => 'Capture another';

  @override
  String get itemItemFailedShort => '✕ Failed';

  @override
  String get itemKeep => 'Keep';

  @override
  String get syncNothingYetTitle => 'Nothing in the queue yet';

  @override
  String get syncNothingYetBody =>
      'Captures you make in the field will wait here until they upload.';

  @override
  String get syncNothingYetNote =>
      'Queuing is working offline-first: nothing is lost if you lose signal.';

  @override
  String get shopsTitle => 'Assigned shops';

  @override
  String get shopsScopeToday => 'Today';

  @override
  String get shopsScopeAll => 'All 24';

  @override
  String get shopsSummaryDone => 'done';

  @override
  String get shopsSummaryCaptured => 'Captured';

  @override
  String get shopsSummaryRoute => 'Route total';

  @override
  String get shopsFilterAllMarkets => 'All markets';

  @override
  String get shopsFilterAllStatus => 'All status';

  @override
  String shopsFilterNeedsAttention(Object count) {
    return 'Needs attention ($count)';
  }

  @override
  String get shopsFilterTotal => 'Total';

  @override
  String get shopsFilterMarkets => 'Markets';

  @override
  String get shopsSortedByDistance => 'Sorted by distance';

  @override
  String get shopsClearSort => 'Clear sort';

  @override
  String get shopsStatusQueued => 'Queued';

  @override
  String get shopsStatusSynced => 'Synced';

  @override
  String get shopsStatusNeedsAttention => 'Needs attention';

  @override
  String get shopsStatusNotStarted => 'Not started';

  @override
  String get shopsStatusVerified => 'Verified';

  @override
  String shopsVerifiedBy(Object agent, Object date) {
    return 'Verified $date by $agent';
  }

  @override
  String shopsCoords(Object coords, Object distance) {
    return '$coords · $distance';
  }

  @override
  String shopsStartNextStop(Object distance) {
    return 'Start next stop — $distance';
  }

  @override
  String shopsAllDoneTitle(Object count) {
    return 'All $count shops captured';
  }

  @override
  String shopsAllDoneBody(
    Object distance,
    Object elapsed,
    num pending,
    Object uploaded,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      pending,
      locale: localeName,
      other: '$pending pending',
      one: '1 pending',
    );
    return 'Uploaded $uploaded · $_temp0. Your route is $distance and took $elapsed.';
  }

  @override
  String get shopsLoadNextRoute => 'Load next route';

  @override
  String get shopsViewSubmissions => 'View submissions';

  @override
  String get shopsEmptyTitle => 'No shops on this route yet';

  @override
  String get shopsEmptyDesc =>
      'Your supervisor assigns shops here. Pull down to check again.';

  @override
  String shopsStatusAt(Object shop, Object status) {
    return '$shop is $status';
  }

  @override
  String get shopsNoMoneyNotice =>
      'Work list only. No bounty is shown here — see your Wallet.';

  @override
  String get mapTitle => 'Map';

  @override
  String mapStripOffline(Object date) {
    return 'Offline map · cached $date';
  }

  @override
  String get mapStripOnline => 'Map';

  @override
  String get mapRefresh => 'Refresh';

  @override
  String mapRefreshOnline(Object percent) {
    return 'Downloading map areas · $percent%';
  }

  @override
  String mapRefreshTile(Object done, Object total) {
    return 'Tile $done of $total';
  }

  @override
  String get mapRefreshVector => 'Fetching vectors…';

  @override
  String get mapRefreshBoundary => 'Dei-Dei boundary…';

  @override
  String get mapRefreshSync => 'Syncing tile vectors…';

  @override
  String mapCachedPercent(Object percent) {
    return '$percent% cached';
  }

  @override
  String mapNearbyCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shops near you',
      one: '1 shop near you',
    );
    return '$_temp0';
  }

  @override
  String mapRadiusActive(Object radius) {
    return '$radius active';
  }

  @override
  String get mapFilterVerified => 'Verified';

  @override
  String get mapFilterMine => 'Mine';

  @override
  String get mapFilterLeads => 'Leads';

  @override
  String get mapFilterRadius => 'Filter radius';

  @override
  String mapCachedOnly(Object shown, Object total) {
    return 'Cached areas only. Showing $shown of $total shops in the cached region.';
  }

  @override
  String get mapStartCaptureHere => 'Start capture from here';

  @override
  String get mapOutsideCachedTitle => 'You\'re outside the cached map area';

  @override
  String mapOutsideCachedBody(Object areas) {
    return 'Shops here won\'t load until you\'re back in $areas.';
  }

  @override
  String mapOutsideCachedEdge(Object area) {
    return '$area cache edge';
  }

  @override
  String get mapOutsideCachedNoVectors => 'No cached vector data';

  @override
  String mapDownloadedAreas(Object areas, Object size) {
    return 'Downloaded areas: $areas · $size';
  }

  @override
  String get mapDownloadThisArea => 'Download this area';

  @override
  String get mapNeedsConnection => 'Needs an active data connection.';

  @override
  String get mapMyLocation => 'My location';

  @override
  String get mapZoomIn => 'Zoom in';

  @override
  String get mapZoomOut => 'Zoom out';

  @override
  String get mapCentre => 'Centre on my location';

  @override
  String mapShopMeta(Object distance, Object line, Object zone) {
    return '$zone · Line $line · $distance';
  }

  @override
  String get mapAtYourLocation => 'at your location';

  @override
  String mapCapturedAt(Object date, Object reference) {
    return 'Captured $date · $reference';
  }

  @override
  String get mapLeadStatus => 'Lead';

  @override
  String mapOpensShop(Object shop) {
    return 'Open $shop on the map';
  }

  @override
  String get mapLegend => 'Map legend';

  @override
  String get mapRadius500m => '500 m';

  @override
  String get mapRadius1km => '1 km';

  @override
  String get mapRadius2km => '2 km';

  @override
  String get mapRadius5km => '5 km';

  @override
  String get mapLegendVerified => 'Verified';

  @override
  String get mapLegendMine => 'Mine';

  @override
  String get mapLegendLeads => 'Leads';

  @override
  String syncDiscardFailedConfirm(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count failed submissions',
      one: '1 failed submission',
    );
    return 'Discarding $_temp0. This cannot be undone.';
  }

  @override
  String get syncDiscardFailedAction => 'Discard them';

  @override
  String get bountyLabel => 'BOUNTY';

  @override
  String get bountyStatePending => 'Pending';

  @override
  String get bountyStateVerified => 'Verified';

  @override
  String get bountyStateRejected => 'Rejected';

  @override
  String get bountyAwaitingHeadline => 'Pending verification';

  @override
  String get bountyVerifiedHeadline => 'Verified';

  @override
  String get bountyRejectedHeadline => 'Rejected';

  @override
  String get bountyNotePending => 'Pending';

  @override
  String bountyNoteApproved(Object date) {
    return 'Approved $date';
  }

  @override
  String get bountyNoteNotPayable => 'Not payable';

  @override
  String bountyVerifiedNote(Object run) {
    return 'Verified and included in the $run payout run';
  }

  @override
  String bountySmsNote(Object amount, Object bank) {
    return 'You\'ll get an SMS when $amount is sent to $bank.';
  }

  @override
  String get bountyReviewerFeedback => 'REVIEWER FEEDBACK';

  @override
  String bountyReviewerLine(Object date, Object reviewer) {
    return 'Rejected by $reviewer · $date';
  }

  @override
  String get bountyReshootCta => 'Reshoot to claim your bounty';

  @override
  String get bountyAuditTimeline => 'Audit timeline';

  @override
  String get bountyLabelAssets => 'Assets';

  @override
  String get bountyLabelMedia => 'Media';

  @override
  String get bountyLabelSubmittedBy => 'Submitted by';

  @override
  String get bountyViewSubmission => 'View submission';

  @override
  String get bountyViewInQueue => 'View in queue';

  @override
  String bountyResubmitNote(Object reference) {
    return 'Resubmitting creates a new submission ($reference). Your original stays on record.';
  }

  @override
  String get bountyReshootResubmit => 'Reshoot & resubmit';

  @override
  String get bountyDiscardSubmission => 'Discard submission';

  @override
  String get bountyTimelineSubmitted => 'Submitted';

  @override
  String get bountyTimelineQueued => 'Queued and uploaded';

  @override
  String get bountyTimelineReview => 'Under review';

  @override
  String get bountyTimelineVerified => 'Verified';

  @override
  String get bountyTimelinePaid => 'Paid';

  @override
  String get bountyTimelineRejected => 'Rejected';

  @override
  String get bountyTimelineNotApplicable => 'Not applicable';

  @override
  String get bountyTimelineForfeited => 'Bounty forfeited';

  @override
  String get bountyTimelineWaiting => 'Waiting on a decision';

  @override
  String get walletTitle => 'Bounty wallet';

  @override
  String get walletLoadFailed => 'This could not be loaded.';

  @override
  String get walletAvailableLabel => 'Available to withdraw';

  @override
  String get walletPendingLabel => 'Pending verification';

  @override
  String get walletPaidThisYear => 'Paid this year';

  @override
  String get walletWithdrawToBank => 'Withdraw to bank';

  @override
  String get walletLastSixWeeks => 'Last 6 weeks';

  @override
  String get walletPreviousPeriod => 'Last 6 weeks';

  @override
  String walletEarnedOver(Object period, Object total) {
    return '$total earned over $period';
  }

  @override
  String walletAverage(Object amount) {
    return 'Avg $amount';
  }

  @override
  String get walletActivePace => 'Active pace';

  @override
  String get walletPayoutHistory => 'Payout history';

  @override
  String get walletPayoutSchedule => 'Mondays @ 09:00';

  @override
  String walletNextRun(Object run) {
    return 'Next payout schedule: $run';
  }

  @override
  String get walletRunOpen => 'Open';

  @override
  String get walletRunPaid => 'Paid';

  @override
  String walletExpected(Object amount, Object count) {
    return '$amount expected if all $count are verified.';
  }

  @override
  String get walletZeroTitle => 'No verified bounties to withdraw yet';

  @override
  String get walletZeroSubtitle => 'No bounties yet';

  @override
  String walletZeroBody(Object amount) {
    return 'Earn $amount each time a shop you map is verified.';
  }

  @override
  String get walletZeroCta => 'Start capturing';

  @override
  String walletZeroBenchmark(Object amount) {
    return 'Average agent earns $amount in their first 6 weeks.';
  }

  @override
  String get walletNoRunsYet => 'No payout runs yet';

  @override
  String walletMinimumWarning(Object amount) {
    return 'Minimum withdrawal is $amount. Enter an amount to continue.';
  }

  @override
  String get walletAmountLabel => 'WITHDRAWAL AMOUNT';

  @override
  String walletMaxAmount(Object amount) {
    return 'MAX $amount';
  }

  @override
  String get walletVerificationTakesADay =>
      'Verification usually takes 24 hours. Pending bounties can\'t be withdrawn early.';

  @override
  String get walletMinimumAmount => '₦10,000';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileVerifiedBadge => 'Verified';

  @override
  String get profileAgentKind => 'Field agent';

  @override
  String get profileSectionAccount => 'Account';

  @override
  String profileAgentRole(Object id) {
    return 'Field Agent · $id';
  }

  @override
  String profileTenure(Object submissions, Object tenure, Object verified) {
    return '$tenure · $submissions submissions · $verified verified';
  }

  @override
  String get profileTenureYears => 'Agent since Mar 2026';

  @override
  String get profileSubmissions => '61 submissions';

  @override
  String get profileVerified => '54 verified';

  @override
  String get profileSectionPreferences => 'Preferences';

  @override
  String get profileSectionWork => 'Work';

  @override
  String get profileSectionSupport => 'Support';

  @override
  String get profileSectionThisDevice => 'This device';

  @override
  String get profileSectionOffline => 'Offline';

  @override
  String get profileAssignedMarkets => 'Assigned markets';

  @override
  String get profileRowLanguage => 'Language';

  @override
  String get profileRowNotifications => 'Notifications';

  @override
  String get profileRowSmsOnly => 'SMS only';

  @override
  String get profileNotificationsSmsAndPush => 'SMS and push';

  @override
  String get profileNotificationsOff => 'Off';

  @override
  String get profileRowSupportPhone => '+234 803 441 2290';

  @override
  String get profileRowStorage => 'Storage';

  @override
  String get profileStorageFree => '2.1 GB free';

  @override
  String get profileRowModel => 'Model';

  @override
  String get profileRowAndroidVersion => 'Android version';

  @override
  String get profileRowAppVersion => 'App version';

  @override
  String get profileAppVersion => '2.4.1 (build 118)';

  @override
  String get profileRowOfflineCapture => 'Offline capture';

  @override
  String get profileRowAllowAlways => 'Always allow';

  @override
  String get profileInstallTitle => 'Add GCC to your home screen';

  @override
  String get profileInstallBody =>
      'So it opens without data and keeps working in the market.';

  @override
  String get profileInstallCta => 'Add to home screen';

  @override
  String get profileSignOut => 'Sign out';

  @override
  String get profileClearAction => 'Clear';

  @override
  String get profileDeviceModelValue => 'Samsung Galaxy A12';

  @override
  String get profileAndroidVersionValue => 'Android 12';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsChannelSms => 'SMS';

  @override
  String get notificationsChannelPush => 'Push';

  @override
  String get notificationsChannelEmail => 'Email';

  @override
  String get notificationsLastSent => 'Last SMS sent';

  @override
  String get notificationsDelivered => 'delivered';

  @override
  String get notificationsNotDelivered => 'not delivered';

  @override
  String get bountyNotFoundTitle => 'Submission not found';

  @override
  String bountyNotFoundBody(Object reference) {
    return 'This app has no record of $reference. It may have been submitted from another device, or discarded.';
  }

  @override
  String get bountyTitle => 'Bounty status';

  @override
  String get profileUnavailableTitle => 'No profile on this device';

  @override
  String get profileUnavailableBody =>
      'Sign in to see your agent details, markets and preferences.';

  @override
  String get biometricUnlockTitleFace => 'Unlock with Face ID';

  @override
  String get biometricUnlockTitleFingerprint => 'Unlock with your fingerprint';

  @override
  String get biometricUnlockTitleGeneric => 'Unlock this device';

  @override
  String get biometricUnlockAction => 'Unlock';

  @override
  String get biometricUseCode => 'Use verification code instead';

  @override
  String get biometricEnrollTitleFace =>
      'Unlock GCC with Face ID on this device?';

  @override
  String get biometricEnrollTitleFingerprint =>
      'Unlock GCC with your fingerprint on this device?';

  @override
  String get biometricEnrollBody =>
      'Your sign-in stays on this device. GCC asks for the biometric when you open the app again.';

  @override
  String get biometricEnable => 'Enable';

  @override
  String get biometricNotNow => 'Not now';

  @override
  String get biometricProfileLabel => 'Unlock with biometrics';

  @override
  String get biometricMethodFace => 'Face ID';

  @override
  String get biometricMethodFingerprint => 'Fingerprint';

  @override
  String get biometricMethodIris => 'Iris';

  @override
  String get biometricMethodGeneric => 'Biometrics';

  @override
  String get biometricUnavailableWeb =>
      'Biometric unlock is not available in the browser.';

  @override
  String get biometricUnavailableHardware =>
      'This device has no biometric sensor.';

  @override
  String get biometricUnavailableNoneEnrolled =>
      'Set up a fingerprint or Face ID in the device settings first.';

  @override
  String get biometricUnavailableLockout =>
      'Too many attempts. Use a verification code, or try again later.';

  @override
  String get biometricEnrollmentLostTitle => 'Biometric unlock was reset';

  @override
  String get biometricEnrollmentLost =>
      'The device biometric changed. Sign in with a verification code to turn it back on.';

  @override
  String get biometricGenericFailure =>
      'Biometric unlock failed. Try again, or use a verification code.';

  @override
  String get biometricSignInFirst => 'Use a verification code to sign in.';

  @override
  String get catalogTitle => 'My catalog';

  @override
  String get catalogAddAsset => 'Add asset';

  @override
  String catalogKindEquipment(int count) {
    return 'Equipment ($count)';
  }

  @override
  String catalogKindBulk(int count) {
    return 'Bulk goods ($count)';
  }

  @override
  String catalogFilterAll(int count) {
    return 'All ($count)';
  }

  @override
  String catalogFilterReady(int count) {
    return 'Ready ($count)';
  }

  @override
  String catalogFilterRented(int count) {
    return 'Rented out ($count)';
  }

  @override
  String catalogFilterMaintenance(int count) {
    return 'Maintenance ($count)';
  }

  @override
  String catalogFilterPending(int count) {
    return 'Pending verification ($count)';
  }

  @override
  String get catalogPerDay => 'per day';

  @override
  String get catalogCautionDeposit => 'caution deposit';

  @override
  String get catalogStatusReady => 'Ready for work';

  @override
  String get catalogStatusRented => 'Rented out';

  @override
  String get catalogStatusMaintenance => 'Maintenance';

  @override
  String get catalogStatusPending => 'Pending';

  @override
  String get catalogPendingReview =>
      'Awaiting GCC review — not visible to buyers';

  @override
  String get catalogPendingNote =>
      'You can set availability once this is verified.';

  @override
  String catalogReturns(String when) {
    return 'Returns $when';
  }

  @override
  String catalogLocked(String reference) {
    return 'Locked while $reference is active.';
  }

  @override
  String get catalogBlockedTitle => 'Set to In maintenance?';

  @override
  String catalogBlockedAffected(int count) {
    return '$count active booking is affected';
  }

  @override
  String get catalogBlockedActive => 'ACTIVE';

  @override
  String get catalogSetAfterReturn => 'Set after return';

  @override
  String get catalogRecommended => 'Recommended';

  @override
  String catalogSetAfterReturnDetail(String when) {
    return 'Status changes automatically at $when.';
  }

  @override
  String get catalogSetNow => 'Set now anyway';

  @override
  String catalogSetNowDetail(String until) {
    return 'The machine stays bookable until $until. Buyers may request it.';
  }

  @override
  String get catalogBuyersNotTold =>
      'Buyers are not told why a machine is unavailable.';

  @override
  String get catalogCancel => 'Cancel';

  @override
  String get catalogUndo => 'Undo';

  @override
  String catalogUndoToast(String reference) {
    return '$reference set to In maintenance';
  }

  @override
  String get catalogUndoHint => 'Reversible within 10 seconds';

  @override
  String catalogScheduled(String when) {
    return 'Set to In maintenance · changes again on $when';
  }

  @override
  String get catalogEmptyBulk => 'No bulk goods in this catalog.';

  @override
  String get catalogEmptyFilter => 'Nothing in this view.';

  @override
  String get requestTitle => 'Booking request';

  @override
  String get requestReceivedSms => 'You received this by SMS';

  @override
  String get requestSmsParity =>
      'Reply 1 to accept or 2 to reject — same effect.';

  @override
  String get requestViewSms => 'View the SMS';

  @override
  String get requestSmsTitle => 'SMS';

  @override
  String get requestReadyInYard => 'Ready in yard';

  @override
  String get requestCall => 'Call';

  @override
  String get requestMessage => 'Message';

  @override
  String get requestDates => 'Dates';

  @override
  String get requestDuration => 'Duration';

  @override
  String get requestRentalFee => 'Rental fee';

  @override
  String get requestDelivery => 'Delivery';

  @override
  String get requestYoullReceive => 'You\'ll receive';

  @override
  String get requestNetEarning => 'Net vendor earning';

  @override
  String get requestEarningNote =>
      'After GCC\'s 12% commission and delivery. Released to your wallet once you record the check-in condition.';

  @override
  String requestHoldDeposit(String amount) {
    return 'You\'ll hold their $amount deposit until the return is approved';
  }

  @override
  String get requestExpiresIn => 'Expires in';

  @override
  String get requestAutoReassigns => 'Auto-reassigns';

  @override
  String get requestUrgent => 'Urgent';

  @override
  String get requestExpiresDetail =>
      'After this, we offer the booking to the next vendor.';

  @override
  String get requestReject => 'Reject';

  @override
  String get requestAccept => 'Accept booking';

  @override
  String requestAcceptTitle(String reference) {
    return 'Accept $reference?';
  }

  @override
  String requestAcceptBody(String window, String place) {
    return 'This confirms collection on $window from $place. The lessee is notified by SMS immediately.';
  }

  @override
  String get requestAcceptChangeWindow =>
      'You can change the collection window after accepting.';

  @override
  String get requestCollectionWindow => 'Collection window';

  @override
  String get requestDeclineTitle => 'Decline this request';

  @override
  String get requestDeclineReason => 'Select a reason';

  @override
  String get requestReasonUnavailable => 'Asset unavailable';

  @override
  String get requestReasonRate => 'Rate needs review';

  @override
  String get requestReasonArea => 'Outside my delivery area';

  @override
  String get requestReasonMaintenance => 'Needs maintenance';

  @override
  String get requestReasonOther => 'Other';

  @override
  String get requestReasonNote => 'Reason note';

  @override
  String get requestReasonNoteHint =>
      'The vendor sees this. Keep it short and factual.';

  @override
  String get requestDeclineNotice =>
      'Declining offers the booking to the next vendor. The lessee isn\'t told who declined.';

  @override
  String get requestDecline => 'Decline request';

  @override
  String get requestChooseReason => 'Choose a reason to decline';

  @override
  String get requestAcceptedSms => 'Accepted by SMS';

  @override
  String get requestAcceptedSmsBody =>
      'You accepted this from your feature phone. Nothing else to do.';

  @override
  String get requestAccepted => 'Accepted';

  @override
  String requestAcceptedAt(String when) {
    return 'Accepted $when';
  }

  @override
  String requestCollectionConfirmed(String window) {
    return 'Collection confirmed for $window';
  }

  @override
  String get requestAuditTitle => 'Arbitration audit trail';

  @override
  String get requestAuditReceived => 'Request received';

  @override
  String get requestAuditBySms => 'By SMS';

  @override
  String get requestAuditAcceptedSms => 'Accepted by SMS';

  @override
  String get requestAuditReply => 'Reply \"1\"';

  @override
  String get requestAuditCollection => 'Collection at yard';

  @override
  String get requestAuditPending => 'Pending';

  @override
  String get requestEquipment => 'Equipment';

  @override
  String get requestNetPayout => 'Net payout';

  @override
  String get requestHeldDeposit => 'Held deposit';

  @override
  String get requestRecordCondition => 'Record collection condition';

  @override
  String get requestDeclineAnyway => 'Decline anyway';

  @override
  String get requestSmsReverse =>
      'Accepting by SMS can be reversed up to 1 hour before collection.';

  @override
  String get requestDeclinedTitle => 'Request declined';

  @override
  String get requestEmpty => 'No booking requests are waiting.';

  @override
  String editAutosaved(String when) {
    return 'Autosaved $when';
  }

  @override
  String editAutosavedOneIncomplete(String when) {
    return 'Autosaved $when · 1 field incomplete';
  }

  @override
  String editAutosavedIncomplete(String when, int count) {
    return 'Autosaved $when · $count fields incomplete';
  }

  @override
  String get editOneFieldNeedsAttention => '1 field needs attention';

  @override
  String editFieldsNeedAttention(int count) {
    return '$count fields need attention';
  }

  @override
  String get editHowYouCharge => 'How do you charge?';

  @override
  String get editHourly => 'Hourly';

  @override
  String get editDaily => 'Daily';

  @override
  String get editWeekly => 'Weekly';

  @override
  String get editProject => 'Project';

  @override
  String get editRatePerDay => 'Rate per day';

  @override
  String get editPerDay => 'per day';

  @override
  String get editRequired => 'Required';

  @override
  String get editRateError => 'Enter a rate per day';

  @override
  String get editProjectRate => 'Project price';

  @override
  String get editProjectError => 'Enter a project price';

  @override
  String get editProjectHelper =>
      'A project price replaces the daily rate for this booking.';

  @override
  String get editCommission => 'Buyer pays this plus 12% GCC commission.';

  @override
  String editWeeklySet(String amount) {
    return 'Weekly rate is set for you at 5.6 × daily ($amount).';
  }

  @override
  String editHourlySet(String amount) {
    return 'Hourly rate is set for you at daily ÷ 8 ($amount).';
  }

  @override
  String get editDeposit => 'Caution deposit';

  @override
  String get editDepositSuffix => 'Deposit';

  @override
  String get editDepositHeld =>
      'Held by GCC as a locked deposit. Refunded to the buyer after the return condition is approved.';

  @override
  String get editDepositError =>
      'Enter a refundable deposit — buyers see this and it must be accurate';

  @override
  String get editAssignOperator => 'Assign operator by default';

  @override
  String get editOperatorFee => 'Operator fee';

  @override
  String editExampleTitle(int days) {
    return 'Example · $days-day booking';
  }

  @override
  String get editProjectExample => 'Example · project booking';

  @override
  String get editRentalFee => 'Rental fee';

  @override
  String editRentalDetail(int days, String rate) {
    return '($days days × $rate)';
  }

  @override
  String get editDelivery => 'Delivery';

  @override
  String get editInsurance => 'Micro-insurance';

  @override
  String get editInsuranceDetail => '(1.5%/day)';

  @override
  String get editBuyerPays => 'Buyer pays';

  @override
  String get editBeforeRefund => 'Before the refund';

  @override
  String editWalletLanding(String amount) {
    return 'After you approve the return, the deposit goes back to them and $amount lands in your wallet.';
  }

  @override
  String get editPausedTitle =>
      'Add a rate and deposit to see what buyers will pay.';

  @override
  String get editPausedBody =>
      'Live calculation is paused while required fields are empty.';

  @override
  String get editPhotos => 'Photos & video';

  @override
  String editVideo(String when) {
    return 'Condition video · $when';
  }

  @override
  String get editReplace => 'Replace';

  @override
  String get editVideoNote =>
      'Buyers see the condition video before they book. It is how disputes get settled fairly.';

  @override
  String get editDiscard => 'Discard';

  @override
  String get editSave => 'Save changes';

  @override
  String get editSaveBlockedOne => 'Fix the highlighted field';

  @override
  String editSaveBlocked(int count) {
    return 'Fix the $count highlighted fields';
  }

  @override
  String get editMissing => 'This asset is not in the catalog.';

  @override
  String get vendorWalletAvailable => 'Available to withdraw';

  @override
  String get vendorWalletAwaiting => 'Awaiting condition check';

  @override
  String get vendorWalletAwaitingCaption =>
      'Released after you approve a return';

  @override
  String get vendorWalletHeld => 'Held as caution deposits';

  @override
  String get vendorWalletHeldCaption =>
      'Other buyers\' money. Never yours to touch.';

  @override
  String get vendorWalletWithdraw => 'Withdraw to bank';

  @override
  String get vendorWalletNothingToWithdraw =>
      'Nothing available to withdraw yet';

  @override
  String get vendorWalletCondition => 'Condition recorded';

  @override
  String get vendorWalletCheckIn => 'Check-in recorded';

  @override
  String get vendorWalletMoney => 'Money to wallet';

  @override
  String get vendorWalletPending => 'Pending';

  @override
  String vendorWalletReleases(String amount) {
    return '$amount releases when you record the check-in and the buyer approves it.';
  }

  @override
  String get vendorWalletThisWeek => 'This week';

  @override
  String get vendorWalletThisMonth => 'This month';

  @override
  String get vendorWalletThisYear => 'This year';

  @override
  String vendorWalletBookingReleased(String reference) {
    return 'Booking $reference released';
  }

  @override
  String vendorWalletDepositHeld(String reference) {
    return 'Caution deposit held · $reference';
  }

  @override
  String vendorWalletPayoutSent(String reference) {
    return 'Payout $reference sent';
  }

  @override
  String vendorWalletPayoutFailed(String reference) {
    return 'Payout $reference failed';
  }

  @override
  String vendorWalletPayoutFailedBanner(String reference, String amount) {
    return 'Payout $reference failed · $amount returned to your balance';
  }

  @override
  String vendorWalletPayoutFailedBody(String bank) {
    return '$bank did not respond within 30 seconds. Nothing was lost.';
  }

  @override
  String get vendorWalletRetry => 'Retry payout';

  @override
  String get vendorWalletRetryNote =>
      'Failed payouts are retried automatically after 6 hours.';

  @override
  String get vendorWalletEmptyTitle => 'No transactions yet';

  @override
  String get vendorWalletEmptyBody =>
      'Release a booking to move money into your wallet. Releases happen after the buyer approves a return condition.';

  @override
  String get vendorWalletViewBookings => 'View my bookings';

  @override
  String get vendorWithdrawTitle => 'Withdraw';

  @override
  String get vendorWithdrawStatus => 'Withdrawal status';

  @override
  String get vendorWithdrawVerified => 'Verified';

  @override
  String get vendorWithdrawChange => 'Change';

  @override
  String get vendorWithdrawAccountNote =>
      'Payouts go to the account name on your verified bank record.';

  @override
  String get vendorWithdrawHowMuch => 'How much?';

  @override
  String vendorWithdrawAvailableOf(String amount) {
    return 'Available $amount';
  }

  @override
  String get vendorWithdrawEnterAmount => 'Enter an amount to withdraw';

  @override
  String vendorWithdrawRange(String minimum, String available) {
    return 'Enter an amount between $minimum and $available';
  }

  @override
  String get vendorWithdrawAll => 'All';

  @override
  String get vendorWithdrawAmount => 'Withdrawal Amount';

  @override
  String get vendorWithdrawFee => 'Transfer processing fee';

  @override
  String get vendorWithdrawFree => 'Free';

  @override
  String get vendorWithdrawNet => 'Net account credit';

  @override
  String vendorWithdrawArrives(String bank) {
    return 'Arrives in $bank';
  }

  @override
  String get vendorWithdrawArrivesBody =>
      'Usually within 2 hours on weekdays. Some clearing runs take longer.';

  @override
  String get vendorWithdrawOnly => 'Withdrawing available funds only';

  @override
  String get vendorWithdrawAuditAnd => 'in condition audit and';

  @override
  String get vendorWithdrawQuarantine =>
      'caution deposits remain quarantined for other bookings.';

  @override
  String get vendorWithdrawNeedAmount =>
      'Add an amount to see fees and arrival time.';

  @override
  String get vendorWithdrawHeldStay =>
      'Held funds remain quarantined until contract milestones complete.';

  @override
  String get vendorWithdrawCancel => 'Cancel';

  @override
  String get vendorWithdrawAction => 'Withdraw';

  @override
  String vendorWithdrawSubmit(String amount) {
    return 'Withdraw $amount';
  }

  @override
  String get vendorWithdrawContinue => 'Enter an amount to continue';

  @override
  String vendorWithdrawOnTheWay(String amount) {
    return '$amount is on its way';
  }

  @override
  String get vendorWithdrawReference => 'Payout Reference';

  @override
  String get vendorWithdrawDebited => 'Amount debited';

  @override
  String get vendorWithdrawDispatched => 'Dispatched timestamp';

  @override
  String get vendorWithdrawEstimated => 'Estimated bank arrival';

  @override
  String vendorWithdrawAccountMatches(String name) {
    return 'Account matches $name';
  }

  @override
  String vendorWithdrawChannelClear(String bank) {
    return '$bank settlement channel clear';
  }

  @override
  String get vendorWithdrawLedgerUpdated => 'Vendor balance ledger updated';

  @override
  String get vendorWithdrawRemaining => 'Remaining Balance';

  @override
  String get vendorWithdrawSms =>
      'You\'ll get an SMS confirmation once clearing settles. Usually within 2 hours.';

  @override
  String get vendorWithdrawTrack => 'Track Settlement';

  @override
  String get vendorWithdrawBack => 'Back to Wallet Overview';

  @override
  String get vendorProfileVerified => 'Verified';

  @override
  String get vendorProfileBoth => 'You\'re signed in as both';

  @override
  String get vendorProfileLessee => 'Lessee';

  @override
  String get vendorProfileVendor => 'Vendor';

  @override
  String get vendorProfileModeExplanation =>
      'Switch mode to see bookings you\'re renting, or to manage your yard.';

  @override
  String get vendorProfileKeepCatalog => 'Your catalog and availability';

  @override
  String get vendorProfileKeepRequests =>
      'Booking requests to accept or decline';

  @override
  String get vendorProfileKeepVideos => 'Condition videos to record';

  @override
  String get vendorProfileWhatChanges => 'What changes?';

  @override
  String get vendorProfileBusiness => 'Business';

  @override
  String get vendorProfileAddresses => 'Saved addresses';

  @override
  String get vendorProfilePayout => 'Payout account';

  @override
  String get vendorProfileShop => 'Shop profile & location';

  @override
  String get vendorProfileHelp => 'Help';

  @override
  String get vendorProfileAbout => 'About GCC';

  @override
  String vendorProfileVersion(String version) {
    return 'Version $version';
  }

  @override
  String get vendorProfileUssdEyebrow => 'No data? Use your basic phone';

  @override
  String get vendorProfileUssdBefore => 'Dial ';

  @override
  String get vendorProfileUssdAfter =>
      ' to check your balance or withdraw to your bank.';

  @override
  String get vendorProfileUssdDetail =>
      'Works on any phone. No internet needed.';

  @override
  String vendorProfileCopyCode(String code) {
    return 'Copy $code';
  }

  @override
  String vendorProfileCopied(String code) {
    return 'Copied $code';
  }

  @override
  String get vendorProfileSwitchTitle => 'Switch to Lessee mode?';

  @override
  String get vendorProfileSwitchBody =>
      'You\'ll see bookings you\'re renting instead of your yard. Your catalog stays exactly as it is — nothing changes.';

  @override
  String get vendorProfileSwitchHidden => 'In Lessee mode you won\'t see:';

  @override
  String get vendorProfileSwitchStill =>
      'You\'ll still see your wallet and payouts.';

  @override
  String get vendorProfileSwitchConfirm => 'Switch to Lessee';

  @override
  String get vendorProfileSwitchStay => 'Stay in Vendor mode';

  @override
  String get vendorNoticeTitle => 'Notifications';

  @override
  String get vendorNoticeMarkRead => 'Mark all read';

  @override
  String get vendorNoticeAll => 'All';

  @override
  String get vendorNoticeRequests => 'Requests';

  @override
  String get vendorNoticeMoney => 'Money';

  @override
  String vendorNoticeTab(String label, int count) {
    return '$label ($count)';
  }

  @override
  String get vendorNoticeSms => 'SMS';

  @override
  String get vendorNoticeUnread => 'Unread';

  @override
  String get vendorNoticeActiveRequests => 'Active requests';

  @override
  String get vendorNoticeAudit => 'Financial audit trail';

  @override
  String get vendorNoticeDecision => '1 item needs a decision';

  @override
  String vendorNoticeWindow(String deadline) {
    return 'The damage claim window closes $deadline.';
  }

  @override
  String get vendorNoticeSmsBefore => 'You can also respond by SMS. Reply ';

  @override
  String get vendorNoticeSmsAccept => '1';

  @override
  String get vendorNoticeSmsMiddle => ' to accept a booking, ';

  @override
  String get vendorNoticeSmsReject => '2';

  @override
  String get vendorNoticeSmsAfter => ' to reject. Damage claims need the app.';

  @override
  String get vendorNoticeReply => 'Reply 1 · accept booking';

  @override
  String get vendorNoticeWalletNote =>
      'Everything about money is also in your wallet statement.';

  @override
  String get vendorNoticeOpenWallet => 'Open Wallet ledger';
}
