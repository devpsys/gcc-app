import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application title shown in the shell and window.
  ///
  /// In en, this message translates to:
  /// **'GCC'**
  String get appTitle;

  /// Navigation label for the home destination.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Heading on the home page.
  ///
  /// In en, this message translates to:
  /// **'Ready for the next feature'**
  String get homeHeadline;

  /// Explanation that the application foundation is ready.
  ///
  /// In en, this message translates to:
  /// **'Shared navigation, appearance, and local preferences are in place. Marketplace features will be added on this foundation.'**
  String get homeBody;

  /// Label for the theme mode control.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeModeLabel;

  /// Theme option that follows the device setting.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// Light theme option.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// Dark theme option.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// Label above the active application environment name.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get environmentTitle;

  /// Name of the development environment.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get environmentDevelopment;

  /// Name of the staging environment.
  ///
  /// In en, this message translates to:
  /// **'Staging'**
  String get environmentStaging;

  /// Name of the production environment.
  ///
  /// In en, this message translates to:
  /// **'Production'**
  String get environmentProduction;

  /// Shown when API_BASE_URL was not provided.
  ///
  /// In en, this message translates to:
  /// **'No API base URL is configured.'**
  String get apiNotConfigured;

  /// Shown when an API base URL is present. The URL itself is not displayed.
  ///
  /// In en, this message translates to:
  /// **'API base URL is configured.'**
  String get apiConfigured;

  /// Shown when saved preferences cannot be read.
  ///
  /// In en, this message translates to:
  /// **'Preferences could not be loaded.'**
  String get homeLoadFailed;

  /// Shown when the selected theme could not be stored.
  ///
  /// In en, this message translates to:
  /// **'Appearance could not be saved.'**
  String get themeSaveFailed;

  /// Retries the failed action.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// Accessibility label for a progress indicator.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// Tooltip for the button that opens the navigation drawer.
  ///
  /// In en, this message translates to:
  /// **'Open navigation menu'**
  String get openNavigationMenu;

  /// Shown for an unknown route.
  ///
  /// In en, this message translates to:
  /// **'This page does not exist.'**
  String get routeNotFound;

  /// Returns to the home page from an unknown route.
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get goHome;

  /// Shown when application startup fails.
  ///
  /// In en, this message translates to:
  /// **'GCC could not start.'**
  String get startupFailed;

  /// Title on the agent identifier screen.
  ///
  /// In en, this message translates to:
  /// **'Field agent sign in'**
  String get authAgentSignInTitle;

  /// Instructions on the agent identifier screen.
  ///
  /// In en, this message translates to:
  /// **'Enter the agent ID given to you by your coordinator.'**
  String get authAgentSignInSubtitle;

  /// Label for the agent identifier field.
  ///
  /// In en, this message translates to:
  /// **'Agent ID'**
  String get authAgentIdLabel;

  /// Example agent identifier shown as placeholder text.
  ///
  /// In en, this message translates to:
  /// **'AG-0142'**
  String get authAgentIdHint;

  /// Divider label between typed sign-in and the QR scanner.
  ///
  /// In en, this message translates to:
  /// **'OR USE SCANNER'**
  String get authScannerDivider;

  /// Button that starts an agent ID card scan.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get authScanQr;

  /// Helper text under the QR scan button.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code on your ID card.'**
  String get authScanQrHelp;

  /// Advances from the agent identifier screen.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get authContinue;

  /// Shown when Continue is disabled because the agent ID is empty.
  ///
  /// In en, this message translates to:
  /// **'Enter your agent ID to continue.'**
  String get authContinueNeedsIdentifier;

  /// Shown when Continue is disabled because the agent ID is not in the expected form.
  ///
  /// In en, this message translates to:
  /// **'Enter an ID like AG-0142 to continue.'**
  String get authContinueNeedsValidIdentifier;

  /// Inline error when an agent ID does not match AG- and four digits.
  ///
  /// In en, this message translates to:
  /// **'Enter an ID like AG-0142.'**
  String get authIdentifierInvalid;

  /// Inline error when an agent ID is well formed but not recognized.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find {identifier}. Check the ID, or contact your coordinator.'**
  String authUnknownIdentifier(String identifier);

  /// Title when an agent account has no markets.
  ///
  /// In en, this message translates to:
  /// **'No markets assigned'**
  String get authUnassignedTitle;

  /// Explanation shown when an agent account has no markets.
  ///
  /// In en, this message translates to:
  /// **'Your account is active but no markets are assigned yet. Contact Grace Uche to get your first market.'**
  String get authUnassignedMessage;

  /// Label for the language row and the language sheet.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get authLanguage;

  /// Label for the notifications preference row.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get authNotifications;

  /// Current notifications value on the agent sign-in screen.
  ///
  /// In en, this message translates to:
  /// **'On · SMS only'**
  String get authNotificationsValue;

  /// Hint that a previous session can be used offline.
  ///
  /// In en, this message translates to:
  /// **'Offline? Use your last signed-in session.'**
  String get authOfflineSession;

  /// Label for the support contact.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get authSupport;

  /// Support phone number shown on agent sign-in.
  ///
  /// In en, this message translates to:
  /// **'+234 803 441 2290'**
  String get authSupportPhone;

  /// Title on the agent verification screen.
  ///
  /// In en, this message translates to:
  /// **'Enter your code'**
  String get authEnterCodeTitle;

  /// Shows the masked phone number that received the code.
  ///
  /// In en, this message translates to:
  /// **'Sent to {phone}'**
  String authCodeSentTo(String phone);

  /// Trust line on the verification screen.
  ///
  /// In en, this message translates to:
  /// **'Encrypted Two-Factor Verification'**
  String get authSecurityNote;

  /// Submits the verification code.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get authVerify;

  /// Shown when Verify is disabled because the code is incomplete.
  ///
  /// In en, this message translates to:
  /// **'Enter all 6 digits to continue.'**
  String get authOtpIncompleteReason;

  /// Accessibility label for the one-time code field.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get authOtpFieldLabel;

  /// Shown when a verification code is rejected.
  ///
  /// In en, this message translates to:
  /// **'That code is not correct. Request a new one.'**
  String get authOtpIncorrect;

  /// Prompt beside the resend action.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get it?'**
  String get authDidntGetCode;

  /// Requests another verification code.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get authResendCode;

  /// Leaves verification to change the phone number or agent ID.
  ///
  /// In en, this message translates to:
  /// **'Use a different number'**
  String get authUseDifferentNumber;

  /// Shown when sign-in fails without a field-specific message.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get authGenericFailure;

  /// Closes the language sheet.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get authClose;

  /// Marks the language currently in use.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get authLanguageCurrent;

  /// Saves the language chosen in the sheet.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get authSave;

  /// Label for the language sheet search field.
  ///
  /// In en, this message translates to:
  /// **'Search languages'**
  String get authSearchLanguages;

  /// Placeholder for the language sheet search field.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get authSearchLanguagesHint;

  /// Shown on languages that do not have a translation yet.
  ///
  /// In en, this message translates to:
  /// **'This language isn\'t available in the app yet.'**
  String get authLanguageUnavailable;

  /// Returns from verification to the identifier screen.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get authBack;

  /// English name of the English language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglishName;

  /// Native name of the English language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglishNative;

  /// Sample sentence shown for English.
  ///
  /// In en, this message translates to:
  /// **'Report equipment damage or return condition'**
  String get languageEnglishSample;

  /// English name of Nigerian Pidgin.
  ///
  /// In en, this message translates to:
  /// **'Pidgin'**
  String get languagePidginName;

  /// Native name of Nigerian Pidgin.
  ///
  /// In en, this message translates to:
  /// **'Naijá Pidgin'**
  String get languagePidginNative;

  /// Sample sentence shown for Nigerian Pidgin.
  ///
  /// In en, this message translates to:
  /// **'Gbe report if machine spoil or condition don change'**
  String get languagePidginSample;

  /// English name of Hausa.
  ///
  /// In en, this message translates to:
  /// **'Hausa'**
  String get languageHausaName;

  /// Native name of Hausa.
  ///
  /// In en, this message translates to:
  /// **'Harshen Hausa'**
  String get languageHausaNative;

  /// Sample sentence shown for Hausa.
  ///
  /// In en, this message translates to:
  /// **'Sanya lamarin ciki'**
  String get languageHausaSample;

  /// English name of Yoruba.
  ///
  /// In en, this message translates to:
  /// **'Yoruba'**
  String get languageYorubaName;

  /// Yoruba name shown as the title of the first-run language row.
  ///
  /// In en, this message translates to:
  /// **'Yorùbá'**
  String get languageYorubaTitle;

  /// Native name of Yoruba, including diacritics.
  ///
  /// In en, this message translates to:
  /// **'Èdè Yorùbá'**
  String get languageYorubaNative;

  /// Sample sentence shown for Yoruba.
  ///
  /// In en, this message translates to:
  /// **'Ṣàlàà nínú rere'**
  String get languageYorubaSample;

  /// English name of Igbo.
  ///
  /// In en, this message translates to:
  /// **'Igbo'**
  String get languageIgboName;

  /// Native name of Igbo, including diacritics.
  ///
  /// In en, this message translates to:
  /// **'Asụsụ Igbo'**
  String get languageIgboNative;

  /// Sample sentence shown for Igbo.
  ///
  /// In en, this message translates to:
  /// **'Nzọọ ncha ahụ'**
  String get languageIgboSample;

  /// Title on the first-run language screen.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get onboardingChooseLanguage;

  /// Subtitle on the first-run language screen.
  ///
  /// In en, this message translates to:
  /// **'You can change this any time.'**
  String get onboardingChangeAnytime;

  /// Advances the first-run flow.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// Shown when Continue is disabled before a language is chosen.
  ///
  /// In en, this message translates to:
  /// **'Choose a language to continue.'**
  String get onboardingContinueNeedsLanguage;

  /// Note under the language list.
  ///
  /// In en, this message translates to:
  /// **'Translations are reviewed by our language team.'**
  String get onboardingTranslationsReviewed;

  /// Announces the current first-run step.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String onboardingStep(int current, int total);

  /// Title on the first-run role screen.
  ///
  /// In en, this message translates to:
  /// **'How will you use GCC?'**
  String get onboardingRoleTitle;

  /// Subtitle on the first-run role screen.
  ///
  /// In en, this message translates to:
  /// **'You can switch later from your profile.'**
  String get onboardingRoleSubtitle;

  /// Title of the lessee role card.
  ///
  /// In en, this message translates to:
  /// **'Rent or buy equipment'**
  String get onboardingRoleRentTitle;

  /// Description of the lessee role.
  ///
  /// In en, this message translates to:
  /// **'Browse generators, sound systems, pumps and building materials from verified vendors in your market.'**
  String get onboardingRoleRentBody;

  /// Title of the vendor role card.
  ///
  /// In en, this message translates to:
  /// **'List my equipment or goods'**
  String get onboardingRoleListTitle;

  /// Description of the vendor role.
  ///
  /// In en, this message translates to:
  /// **'Publish rental listings or bulk trade products, respond to booking requests, and get paid into your GCC wallet.'**
  String get onboardingRoleListBody;

  /// Note that role can be changed later.
  ///
  /// In en, this message translates to:
  /// **'Most people use both. Switch any time from Profile → Switch role.'**
  String get onboardingRoleBoth;

  /// Profile path emphasized inside the role note.
  ///
  /// In en, this message translates to:
  /// **'Profile → Switch role'**
  String get onboardingRolePath;

  /// Skips a firm role choice and continues.
  ///
  /// In en, this message translates to:
  /// **'I just want to look'**
  String get onboardingJustLooking;

  /// Shown when Continue is disabled before a role is chosen.
  ///
  /// In en, this message translates to:
  /// **'Choose how you will use GCC to continue.'**
  String get onboardingContinueNeedsRole;

  /// Title on the first-run phone screen.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get onboardingSignInTitle;

  /// Subtitle on the first-run phone screen.
  ///
  /// In en, this message translates to:
  /// **'Use the number the yard or business uses.'**
  String get onboardingSignInSubtitle;

  /// Label for the mobile number field.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get onboardingMobileLabel;

  /// Locked country calling code for the mobile number field.
  ///
  /// In en, this message translates to:
  /// **'+234'**
  String get onboardingPhonePrefix;

  /// Helper text for the first-run verification code.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code we send you'**
  String get onboardingCodeHelp;

  /// Placeholder shown in the verification-code field before a code is sent.
  ///
  /// In en, this message translates to:
  /// **'• • • • • •'**
  String get onboardingCodePlaceholder;

  /// Explains that verification creates an account.
  ///
  /// In en, this message translates to:
  /// **'New here? We\'ll create your account when you verify.'**
  String get onboardingNewAccount;

  /// Requests a sign-in code for the entered mobile number.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get onboardingSendCode;

  /// Shown when Send code is disabled because the number is empty.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number to continue.'**
  String get onboardingSendCodeNeedsPhone;

  /// Shown when Send code is disabled because the number is incomplete.
  ///
  /// In en, this message translates to:
  /// **'Enter all 11 digits to continue.'**
  String get onboardingSendCodeNeedsFullPhone;

  /// Lead-in to the email sign-in copy.
  ///
  /// In en, this message translates to:
  /// **'Already have a GCC account?'**
  String get onboardingAlreadyAccount;

  /// Copy pointing at email sign-in. No email flow is available yet.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your email instead.'**
  String get onboardingEmailInstead;

  /// Shown when a first-run sign-in request fails.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get onboardingGenericFailure;

  /// Navigation label for appearance and environment settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Shown when a dashboard action points at a feature that has not been built.
  ///
  /// In en, this message translates to:
  /// **'This isn\'t available in the app yet.'**
  String get dashboardActionUnavailable;

  /// Shown when the whole dashboard fails to load.
  ///
  /// In en, this message translates to:
  /// **'The dashboard could not be loaded.'**
  String get dashboardLoadFailed;

  /// Shown inside a dashboard section that failed while the rest stayed visible.
  ///
  /// In en, this message translates to:
  /// **'This section could not be loaded.'**
  String get dashboardSectionFailed;

  /// Retries a failed dashboard load.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get dashboardRetry;

  /// Short label on the dashboard language control. English is the only available language.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get dashboardLanguageShort;

  /// Lessee app bar when no location has been loaded.
  ///
  /// In en, this message translates to:
  /// **'Location not set'**
  String get dashboardNoLocation;

  /// Vendor app bar when no market has been loaded.
  ///
  /// In en, this message translates to:
  /// **'No market selected'**
  String get dashboardNoMarket;

  /// Bottom navigation label for the dashboard.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dashboardHome;

  /// Lessee bottom navigation label for browsing equipment.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get dashboardBrowse;

  /// Lessee bottom navigation label for bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get dashboardBookings;

  /// Bottom navigation label for the wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get dashboardWallet;

  /// Bottom navigation label for the profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get dashboardProfile;

  /// Vendor bottom navigation label for the equipment catalog.
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get dashboardCatalog;

  /// Vendor bottom navigation label for booking requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get dashboardRequests;

  /// Agent bottom navigation label for today's route.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dashboardToday;

  /// Agent bottom navigation label for the route map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get dashboardMap;

  /// Agent centre action for starting a shop capture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get dashboardCapture;

  /// Agent bottom navigation label for the sync queue.
  ///
  /// In en, this message translates to:
  /// **'Queue'**
  String get dashboardQueue;

  /// Hint in the lessee dashboard search field.
  ///
  /// In en, this message translates to:
  /// **'Search equipment or materials'**
  String get dashboardSearchHint;

  /// Opens search filters. The filter sheet is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get dashboardFilters;

  /// Eyebrow on the lessee rental card while a booking is in use.
  ///
  /// In en, this message translates to:
  /// **'Active rental · {reference}'**
  String dashboardActiveRental(String reference);

  /// Eyebrow on the lessee rental card after the deposit is released.
  ///
  /// In en, this message translates to:
  /// **'Completed · {reference}'**
  String dashboardCompletedRental(String reference);

  /// Title when the lessee has no rental in progress.
  ///
  /// In en, this message translates to:
  /// **'No active bookings'**
  String get dashboardNoActiveBookings;

  /// Explanation under the empty active-rental card.
  ///
  /// In en, this message translates to:
  /// **'Rent equipment available around you, or check on a bulk order.'**
  String get dashboardNoActiveBookingsBody;

  /// Empty rental explanation when a place is known.
  ///
  /// In en, this message translates to:
  /// **'Rent equipment available around {place}, or check on a bulk order.'**
  String dashboardNoActiveBookingsPlace(String place);

  /// Caption under the empty rental card.
  ///
  /// In en, this message translates to:
  /// **'Last rental: {detail}'**
  String dashboardLastRental(String detail);

  /// First step on the rental progress bar.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get dashboardBooked;

  /// Last step on the rental progress bar.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get dashboardReturned;

  /// Struck-through deposit line after the deposit is released.
  ///
  /// In en, this message translates to:
  /// **'{amount} refundable deposit'**
  String dashboardRefundableDeposit(String amount);

  /// Caption under the empty requests card.
  ///
  /// In en, this message translates to:
  /// **'Last request answered {when}'**
  String dashboardLastRequest(String when);

  /// Action on the empty rental card. Browsing is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Browse equipment'**
  String get dashboardBrowseEquipment;

  /// Deadline for returning an active rental.
  ///
  /// In en, this message translates to:
  /// **'Return by {when}'**
  String dashboardReturnBy(String when);

  /// Label on the held refundable deposit.
  ///
  /// In en, this message translates to:
  /// **'Refundable deposit held'**
  String get dashboardDepositLabel;

  /// Caption under the held deposit amount.
  ///
  /// In en, this message translates to:
  /// **'Escrow'**
  String get dashboardEscrow;

  /// Action on an active rental. The return flow is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Review return condition'**
  String get dashboardReviewReturn;

  /// Action on an active rental. Messaging is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Message vendor'**
  String get dashboardMessageVendor;

  /// Status after a refundable deposit has been returned.
  ///
  /// In en, this message translates to:
  /// **'Deposit released'**
  String get dashboardDepositReleased;

  /// Tells the lessee a released deposit is in the wallet.
  ///
  /// In en, this message translates to:
  /// **'{amount} is back in your wallet.'**
  String dashboardDepositReleasedBody(String amount);

  /// Action after a deposit is released. The wallet is not available yet.
  ///
  /// In en, this message translates to:
  /// **'View wallet'**
  String get dashboardViewWallet;

  /// Action after a rental is completed. Ratings are not available yet.
  ///
  /// In en, this message translates to:
  /// **'Rate this rental'**
  String get dashboardRateRental;

  /// Heading above the lessee category chips.
  ///
  /// In en, this message translates to:
  /// **'Browse by category'**
  String get dashboardBrowseByCategory;

  /// Equipment category chip.
  ///
  /// In en, this message translates to:
  /// **'Generators'**
  String get dashboardCategoryGenerators;

  /// Equipment category chip.
  ///
  /// In en, this message translates to:
  /// **'Sound & PA'**
  String get dashboardCategorySound;

  /// Equipment category chip.
  ///
  /// In en, this message translates to:
  /// **'Lighting'**
  String get dashboardCategoryLighting;

  /// Equipment category chip.
  ///
  /// In en, this message translates to:
  /// **'Pumps'**
  String get dashboardCategoryPumps;

  /// Equipment category chip.
  ///
  /// In en, this message translates to:
  /// **'Welding'**
  String get dashboardCategoryWelding;

  /// Equipment category chip.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get dashboardCategoryMaterials;

  /// Heading above nearby equipment.
  ///
  /// In en, this message translates to:
  /// **'Available near you'**
  String get dashboardAvailableNearYou;

  /// Opens the full list for a dashboard section. Those lists are not available yet.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get dashboardSeeAll;

  /// Status when a listing can be booked.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get dashboardAvailable;

  /// Unit shown after a daily rental price.
  ///
  /// In en, this message translates to:
  /// **'/day'**
  String get dashboardPerDay;

  /// Shown when the nearby equipment list is empty.
  ///
  /// In en, this message translates to:
  /// **'Nothing is listed near you yet.'**
  String get dashboardNoResults;

  /// Heading above the lessee's recent bulk orders.
  ///
  /// In en, this message translates to:
  /// **'Recent orders'**
  String get dashboardRecentOrders;

  /// Shown when the lessee has no recent orders.
  ///
  /// In en, this message translates to:
  /// **'No recent orders.'**
  String get dashboardNoOrders;

  /// Vendor heading when booking requests need a response.
  ///
  /// In en, this message translates to:
  /// **'{count} booking requests waiting'**
  String dashboardRequestsWaiting(int count);

  /// Label beside the request countdown.
  ///
  /// In en, this message translates to:
  /// **'Respond within'**
  String get dashboardRespondWithin;

  /// Explains the vendor response window.
  ///
  /// In en, this message translates to:
  /// **'Unanswered requests expire in 6 hours and go to the next vendor.'**
  String get dashboardRequestExpiry;

  /// Primary action on waiting requests. The requests screen is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Respond to requests'**
  String get dashboardRespondToRequests;

  /// Secondary action for the full request list.
  ///
  /// In en, this message translates to:
  /// **'All {count} requests'**
  String dashboardAllRequests(int count);

  /// Title when the vendor has no booking requests.
  ///
  /// In en, this message translates to:
  /// **'No requests waiting'**
  String get dashboardNoRequests;

  /// Explanation under the empty requests card.
  ///
  /// In en, this message translates to:
  /// **'New booking requests arrive by SMS and appear here.'**
  String get dashboardNoRequestsBody;

  /// Heading above the vendor fleet summary.
  ///
  /// In en, this message translates to:
  /// **'Your equipment'**
  String get dashboardYourEquipment;

  /// Action for the equipment catalog. The catalog is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get dashboardManage;

  /// Fleet count for equipment that can be booked.
  ///
  /// In en, this message translates to:
  /// **'Ready for work'**
  String get dashboardReadyForWork;

  /// Fleet count for equipment that is currently rented.
  ///
  /// In en, this message translates to:
  /// **'Rented out'**
  String get dashboardRentedOut;

  /// Fleet count for equipment that is being repaired.
  ///
  /// In en, this message translates to:
  /// **'In maintenance'**
  String get dashboardInMaintenance;

  /// Summary under the fleet counts.
  ///
  /// In en, this message translates to:
  /// **'{listed} assets listed · {pending} pending verification'**
  String dashboardAssetsSummary(int listed, int pending);

  /// Accessible name for one segment of the fleet bar.
  ///
  /// In en, this message translates to:
  /// **'{label}: {count}'**
  String dashboardFleetSegment(String label, int count);

  /// Shown when the vendor fleet summary is empty.
  ///
  /// In en, this message translates to:
  /// **'No equipment is listed yet.'**
  String get dashboardNoFleet;

  /// Heading above the vendor earnings figures.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get dashboardEarnings;

  /// Spendable vendor balance. This figure is not held money.
  ///
  /// In en, this message translates to:
  /// **'Available to withdraw'**
  String get dashboardAvailableToWithdraw;

  /// Vendor earnings held until a condition check finishes.
  ///
  /// In en, this message translates to:
  /// **'Awaiting condition check'**
  String get dashboardAwaitingCheck;

  /// Vendor earnings held as refundable caution deposits.
  ///
  /// In en, this message translates to:
  /// **'Held as caution deposits'**
  String get dashboardCautionDeposits;

  /// Primary earnings action. The wallet is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Withdraw to bank'**
  String get dashboardWithdraw;

  /// Secondary earnings action. The wallet is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Open wallet'**
  String get dashboardOpenWallet;

  /// Shown when the vendor earnings summary is empty.
  ///
  /// In en, this message translates to:
  /// **'No earnings to show yet.'**
  String get dashboardNoEarnings;

  /// Heading above the vendor's recent bookings.
  ///
  /// In en, this message translates to:
  /// **'Recent bookings'**
  String get dashboardRecentBookings;

  /// Shown when the vendor has no recent bookings.
  ///
  /// In en, this message translates to:
  /// **'No recent bookings.'**
  String get dashboardNoBookings;

  /// Booking status while equipment is with the customer.
  ///
  /// In en, this message translates to:
  /// **'In use'**
  String get dashboardStatusInUse;

  /// Booking status when check-in is still due.
  ///
  /// In en, this message translates to:
  /// **'Check-in due'**
  String get dashboardStatusDue;

  /// Booking status after return.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get dashboardStatusCompleted;

  /// Booking status while a dispute is open.
  ///
  /// In en, this message translates to:
  /// **'Disputed'**
  String get dashboardStatusDisputed;

  /// Title of the vendor dispute banner.
  ///
  /// In en, this message translates to:
  /// **'Dispute {reference} is open'**
  String dashboardDisputeTitle(String reference);

  /// Body of the vendor dispute banner.
  ///
  /// In en, this message translates to:
  /// **'Dispute {dispute} is open on {booking}. {detail}'**
  String dashboardDisputeMessage(String dispute, String booking, String detail);

  /// Action on the dispute banner. Dispute details are not available yet.
  ///
  /// In en, this message translates to:
  /// **'View dispute'**
  String get dashboardViewDispute;

  /// Agent prompt to install the app. Installation is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Add to home screen'**
  String get dashboardAddToHome;

  /// Agent greeting when no name has been loaded.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get dashboardGoodMorning;

  /// Agent greeting that includes the loaded name.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String dashboardGoodMorningNamed(String name);

  /// Sync strip message while the agent dashboard is loading.
  ///
  /// In en, this message translates to:
  /// **'Checking saved work'**
  String get dashboardSyncChecking;

  /// Sync strip message when there is no sync status to report.
  ///
  /// In en, this message translates to:
  /// **'Nothing is waiting to sync.'**
  String get dashboardSyncEmpty;

  /// Sync strip message when the agent is offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get dashboardSyncOffline;

  /// Sync strip message while saved work is uploading.
  ///
  /// In en, this message translates to:
  /// **'Syncing'**
  String get dashboardSyncSyncing;

  /// Sync strip message when saved work could not upload.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get dashboardSyncFailed;

  /// Sync strip message when saved work has uploaded.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get dashboardSyncSynced;

  /// Action on the sync strip. The queue is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Open queue'**
  String get dashboardOpenQueue;

  /// Heading above the agent's daily progress.
  ///
  /// In en, this message translates to:
  /// **'Today at a glance'**
  String get dashboardTodayAtAGlance;

  /// Label for the number of shops on today's route.
  ///
  /// In en, this message translates to:
  /// **'Shops assigned'**
  String get dashboardShopsAssigned;

  /// Label for shops captured today.
  ///
  /// In en, this message translates to:
  /// **'Captured today'**
  String get dashboardCapturedToday;

  /// Label for bounty that is not yet paid.
  ///
  /// In en, this message translates to:
  /// **'Pending bounty'**
  String get dashboardPendingBounty;

  /// Accessible name for the daily progress ring.
  ///
  /// In en, this message translates to:
  /// **'{captured} of {target} shops captured today'**
  String dashboardProgressLabel(int captured, int target);

  /// Caption beside the agent's daily progress heading.
  ///
  /// In en, this message translates to:
  /// **'Daily target: {count}'**
  String dashboardDailyTarget(int count);

  /// Shown when the agent has no daily target.
  ///
  /// In en, this message translates to:
  /// **'No shops are assigned today.'**
  String get dashboardNoProgress;

  /// Heading above the agent's next shop.
  ///
  /// In en, this message translates to:
  /// **'Next stop'**
  String get dashboardNextStop;

  /// Distance from the agent to the next shop.
  ///
  /// In en, this message translates to:
  /// **'{distance} away'**
  String dashboardAway(String distance);

  /// Primary action on the next shop. Capture is not available yet.
  ///
  /// In en, this message translates to:
  /// **'Start capture'**
  String get dashboardStartCapture;

  /// Secondary action on the next shop. Maps are not available yet.
  ///
  /// In en, this message translates to:
  /// **'Get directions'**
  String get dashboardGetDirections;

  /// Shown when the agent has no remaining stop.
  ///
  /// In en, this message translates to:
  /// **'All assigned shops are done.'**
  String get dashboardAllDone;

  /// Link above the assigned shop list.
  ///
  /// In en, this message translates to:
  /// **'See all {count}'**
  String dashboardSeeAllCount(int count);

  /// Link above the recent submissions list.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get dashboardViewAll;

  /// Heading above the agent's route.
  ///
  /// In en, this message translates to:
  /// **'Assigned shops'**
  String get dashboardAssignedShops;

  /// Shown when the assigned-shop list is empty.
  ///
  /// In en, this message translates to:
  /// **'No shops are on this route.'**
  String get dashboardNoShops;

  /// Shop status when a capture is waiting to sync.
  ///
  /// In en, this message translates to:
  /// **'Captured · queued'**
  String get dashboardShopQueued;

  /// Shop status when a capture has synced.
  ///
  /// In en, this message translates to:
  /// **'Captured · synced'**
  String get dashboardShopSynced;

  /// Shop status when capture has not started.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get dashboardShopNotStarted;

  /// Heading above the agent's recent captures.
  ///
  /// In en, this message translates to:
  /// **'Recent submissions'**
  String get dashboardRecentSubmissions;

  /// Shown when the agent has no recent submissions.
  ///
  /// In en, this message translates to:
  /// **'No submissions yet.'**
  String get dashboardNoSubmissions;

  /// Submission status while a capture waits to upload.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get dashboardSubmissionQueued;

  /// Submission status after a capture uploads.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get dashboardSubmissionSynced;

  /// Submission status after a capture is approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get dashboardSubmissionApproved;

  /// Approved submission chip that includes the bounty.
  ///
  /// In en, this message translates to:
  /// **'Approved · {amount}'**
  String dashboardSubmissionApprovedAmount(String amount);

  /// Heading above the agent bounty summary.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get dashboardBountySnapshot;

  /// Label for bounty that is waiting for the next payout.
  ///
  /// In en, this message translates to:
  /// **'Payout pending'**
  String get dashboardPayoutPending;

  /// Shown when the agent bounty summary is empty.
  ///
  /// In en, this message translates to:
  /// **'No bounty to show yet.'**
  String get dashboardNoBounty;

  /// Title of the first capture step.
  ///
  /// In en, this message translates to:
  /// **'Capture shop'**
  String get captureShopTitle;

  /// Title of the second capture step.
  ///
  /// In en, this message translates to:
  /// **'Capture location'**
  String get captureLocationTitle;

  /// Shown after the capture draft changes on this device.
  ///
  /// In en, this message translates to:
  /// **'Autosaved {time}'**
  String captureAutosaved(String time);

  /// Autosave status when the shop form still has errors.
  ///
  /// In en, this message translates to:
  /// **'ACTION NEEDED'**
  String get captureActionNeeded;

  /// Autosave line when the shop form was submitted incomplete.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Autosaved {time} · 1 field incomplete} other{Autosaved {time} · {count} fields incomplete}}'**
  String captureAutosavedIncomplete(String time, int count);

  /// Shop details status while required fields are still missing.
  ///
  /// In en, this message translates to:
  /// **'Incomplete'**
  String get captureIncomplete;

  /// Hint beside shop type before a type is chosen.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get captureRequired;

  /// Status on the capture autosave strip.
  ///
  /// In en, this message translates to:
  /// **'OFFLINE READY'**
  String get captureOfflineReady;

  /// Accessible name for the capture progress bar.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}, {label}'**
  String captureWizardSummary(int current, int total, String label);

  /// Eyebrow on the capture shop step card.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total} · {detail}'**
  String captureStepEyebrow(int current, int total, String detail);

  /// Step chip before the shop form has been filled.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get captureStepStart;

  /// Step chip when the shop form still has errors.
  ///
  /// In en, this message translates to:
  /// **'ATTENTION'**
  String get captureStepAttention;

  /// Position chip on the capture progress bar.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total} ACTIVE'**
  String captureStepActive(int current, int total);

  /// First capture step.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get captureStepShop;

  /// Second capture step.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get captureStepLocation;

  /// Third capture step.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get captureStepAssets;

  /// Fourth capture step.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get captureStepMedia;

  /// Heading for the shop identity section.
  ///
  /// In en, this message translates to:
  /// **'Shop details'**
  String get captureShopDetails;

  /// Marks the shop identity section as required.
  ///
  /// In en, this message translates to:
  /// **'* Required'**
  String get captureRequiredMark;

  /// Label for the shop name field.
  ///
  /// In en, this message translates to:
  /// **'Shop name *'**
  String get captureShopName;

  /// Error when the shop name is blank.
  ///
  /// In en, this message translates to:
  /// **'Shop name is required'**
  String get captureShopNameRequired;

  /// Placeholder shown in an empty shop name field.
  ///
  /// In en, this message translates to:
  /// **'e.g. Bola Hardware'**
  String get captureShopNameHint;

  /// Label for the shop type selector.
  ///
  /// In en, this message translates to:
  /// **'Shop type *'**
  String get captureShopType;

  /// Shop type for an equipment yard.
  ///
  /// In en, this message translates to:
  /// **'Equipment yard'**
  String get captureShopTypeEquipment;

  /// Shop type for a bulk supplier.
  ///
  /// In en, this message translates to:
  /// **'Bulk supplier'**
  String get captureShopTypeBulk;

  /// Shop type for a yard that is also a bulk supplier.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get captureShopTypeBoth;

  /// Error when no shop type is selected.
  ///
  /// In en, this message translates to:
  /// **'Choose a shop type'**
  String get captureShopTypeRequired;

  /// Label for the shop owner field.
  ///
  /// In en, this message translates to:
  /// **'Owner name *'**
  String get captureOwnerName;

  /// Error when the owner name is blank.
  ///
  /// In en, this message translates to:
  /// **'Enter the owner\'s full name'**
  String get captureOwnerNameRequired;

  /// Placeholder shown in an empty owner name field.
  ///
  /// In en, this message translates to:
  /// **'e.g. Alhaji Musa Ibrahim'**
  String get captureOwnerNameHint;

  /// Heading for the shop phone section.
  ///
  /// In en, this message translates to:
  /// **'Contact & Messaging'**
  String get captureContactHeading;

  /// Country note beside the shop contact heading.
  ///
  /// In en, this message translates to:
  /// **'NIGERIA (+234)'**
  String get captureNigeriaPrefix;

  /// Country code shown beside a shop phone number.
  ///
  /// In en, this message translates to:
  /// **'+234'**
  String get capturePhonePrefix;

  /// Label for the shop phone field.
  ///
  /// In en, this message translates to:
  /// **'Phone number *'**
  String get capturePhoneNumber;

  /// Error when the shop phone is incomplete.
  ///
  /// In en, this message translates to:
  /// **'Enter a phone number'**
  String get capturePhoneRequired;

  /// Label for the shop WhatsApp field.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get captureWhatsApp;

  /// Switch that copies the shop phone into WhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Same as phone'**
  String get captureSameAsPhone;

  /// Note inside the WhatsApp field when it copies the phone.
  ///
  /// In en, this message translates to:
  /// **'Using phone above'**
  String get captureUsingPhoneAbove;

  /// Caption under the WhatsApp field when it copies the phone.
  ///
  /// In en, this message translates to:
  /// **'Using the phone number above'**
  String get captureUsingPhoneAboveBody;

  /// Heading for the shop category chips.
  ///
  /// In en, this message translates to:
  /// **'What they sell'**
  String get captureWhatTheySell;

  /// Help under the shop category heading.
  ///
  /// In en, this message translates to:
  /// **'Select all that apply. This decides where the shop appears.'**
  String get captureCategoriesHint;

  /// Count of selected shop categories.
  ///
  /// In en, this message translates to:
  /// **'{count} SELECTED'**
  String captureCategoriesSelected(int count);

  /// Error when no shop category is selected.
  ///
  /// In en, this message translates to:
  /// **'Select at least one category'**
  String get captureCategoryRequired;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Generators'**
  String get captureCategoryGenerators;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Welding'**
  String get captureCategoryWelding;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Water pumps'**
  String get captureCategoryWaterPumps;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Building materials'**
  String get captureCategoryBuilding;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Electrical'**
  String get captureCategoryElectrical;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Catering'**
  String get captureCategoryCatering;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Sound & PA'**
  String get captureCategorySound;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Generators (parts)'**
  String get captureCategoryParts;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Beverages'**
  String get captureCategoryBeverages;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Lighting'**
  String get captureCategoryLighting;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Compression'**
  String get captureCategoryCompression;

  /// Shop category.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer'**
  String get captureCategoryFertilizer;

  /// Secondary action on the capture wizard bar.
  ///
  /// In en, this message translates to:
  /// **'Save draft'**
  String get captureSaveDraft;

  /// Primary action on the first capture step.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get captureContinue;

  /// Shown under the wizard bar until the shop name and owner are filled.
  ///
  /// In en, this message translates to:
  /// **'Fill in the shop name and owner to continue'**
  String get captureContinueNeedsIdentity;

  /// Banner shown when the shop step is submitted incomplete.
  ///
  /// In en, this message translates to:
  /// **'{count} fields need attention'**
  String captureValidationBanner(int count);

  /// Label for the shop landmark field.
  ///
  /// In en, this message translates to:
  /// **'Landmark'**
  String get captureLandmark;

  /// Placeholder for the shop landmark field.
  ///
  /// In en, this message translates to:
  /// **'e.g. beside Bola Hardware, near the main gate'**
  String get captureLandmarkHint;

  /// Detail in the location step eyebrow.
  ///
  /// In en, this message translates to:
  /// **'Spatial tagging'**
  String get captureSpatialTagging;

  /// Heading on the market, zone, and line path.
  ///
  /// In en, this message translates to:
  /// **'Verified spatial hierarchy'**
  String get captureHierarchyTitle;

  /// Heading above the market, zone, and line selectors.
  ///
  /// In en, this message translates to:
  /// **'Hierarchical selectors'**
  String get captureSelectorsHeading;

  /// Shown when market, zone, and line are all chosen.
  ///
  /// In en, this message translates to:
  /// **'ALL ASSIGNED'**
  String get captureHierarchyAssigned;

  /// Shown until market, zone, and line are all chosen.
  ///
  /// In en, this message translates to:
  /// **'NOT ASSIGNED'**
  String get captureHierarchyPending;

  /// Path value before a market, zone, or line is chosen.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get captureNotSet;

  /// Label for the market selector.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get captureMarket;

  /// Label for the zone selector.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get captureZone;

  /// Label for the line selector.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get captureLine;

  /// Path label while the line is the active level.
  ///
  /// In en, this message translates to:
  /// **'Line (current)'**
  String get captureLineCurrent;

  /// Empty market selector.
  ///
  /// In en, this message translates to:
  /// **'Choose a market'**
  String get captureChooseMarket;

  /// Empty zone selector.
  ///
  /// In en, this message translates to:
  /// **'Choose a zone'**
  String get captureChooseZone;

  /// Empty line selector.
  ///
  /// In en, this message translates to:
  /// **'Choose a line'**
  String get captureChooseLine;

  /// Help under the market, zone, and line selectors.
  ///
  /// In en, this message translates to:
  /// **'Zones and lines come from the market map. If a line isn\'t listed, describe it in the landmark box.'**
  String get captureHierarchyHint;

  /// Chip naming the market cluster on the location path.
  ///
  /// In en, this message translates to:
  /// **'{name} cluster'**
  String captureClusterChip(String name);

  /// Banner shown when the location step has no GPS fix.
  ///
  /// In en, this message translates to:
  /// **'We can\'t pin this shop. You can still capture it — an admin will verify the location from your landmark description.'**
  String get captureNoSignalBanner;

  /// Title of the GPS status row when there is no fix.
  ///
  /// In en, this message translates to:
  /// **'No location signal'**
  String get captureNoSignalTitle;

  /// Caption under the no-signal GPS title.
  ///
  /// In en, this message translates to:
  /// **'Your device can\'t see a GPS fix'**
  String get captureNoSignalBody;

  /// Title of the map preview when GPS is unavailable.
  ///
  /// In en, this message translates to:
  /// **'Map pin disabled'**
  String get captureMapDisabledTitle;

  /// Caption under the disabled map pin.
  ///
  /// In en, this message translates to:
  /// **'GPS satellite signal unavailable indoors or under zinc roofs'**
  String get captureMapDisabledBody;

  /// Link under the map preview. Manual entry is not built yet.
  ///
  /// In en, this message translates to:
  /// **'Enter coordinates manually'**
  String get captureEnterCoordinates;

  /// Line under the map preview.
  ///
  /// In en, this message translates to:
  /// **'The pin is a backup. The landmark description is how vendors find each other.'**
  String get capturePinNote;

  /// Note explaining why the landmark description matters.
  ///
  /// In en, this message translates to:
  /// **'Landmarks are informal in the markets. Use what vendors and agents call the place — the map pin helps us verify the shop, but it isn\'t how people navigate.'**
  String get captureLandmarkContext;

  /// Placeholder in the market, zone, or line search field.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get capturePickerSearch;

  /// Prompt above a custom market, zone, or line name.
  ///
  /// In en, this message translates to:
  /// **'Unlisted?'**
  String get capturePickerUnlisted;

  /// Action that saves a typed market, zone, or line.
  ///
  /// In en, this message translates to:
  /// **'Use \"{query}\" as custom text'**
  String capturePickerCustom(String query);

  /// Empty state in the market, zone, or line picker.
  ///
  /// In en, this message translates to:
  /// **'Nothing is assigned for this capture yet. Type a name and select it.'**
  String get capturePickerEmpty;

  /// Closes the market, zone, or line picker.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get capturePickerDone;

  /// Confirms the typed market, zone, or line.
  ///
  /// In en, this message translates to:
  /// **'Select {value}'**
  String capturePickerSelect(String value);

  /// Shown under the location step until a landmark is entered.
  ///
  /// In en, this message translates to:
  /// **'Add a landmark to continue'**
  String get captureLandmarkRequired;

  /// No description provided for @captureContinueWithoutPin.
  ///
  /// In en, this message translates to:
  /// **'Submitting without a pin — an admin will verify this location'**
  String get captureContinueWithoutPin;

  /// No description provided for @captureAssetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture assets'**
  String get captureAssetsTitle;

  /// No description provided for @captureAssetCatalogHeading.
  ///
  /// In en, this message translates to:
  /// **'Equipment Catalog'**
  String get captureAssetCatalogHeading;

  /// No description provided for @captureAssetSectionA.
  ///
  /// In en, this message translates to:
  /// **'Section A · Equipment type'**
  String get captureAssetSectionA;

  /// No description provided for @captureAssetSectionB.
  ///
  /// In en, this message translates to:
  /// **'Section B · Details'**
  String get captureAssetSectionB;

  /// No description provided for @captureAssetSectionC.
  ///
  /// In en, this message translates to:
  /// **'Section C · Availability'**
  String get captureAssetSectionC;

  /// No description provided for @captureAssetSectionCEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Routes this asset to a catalog mode'**
  String get captureAssetSectionCEyebrow;

  /// No description provided for @captureAssetCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get captureAssetCategoryLabel;

  /// No description provided for @captureAssetMakeLabel.
  ///
  /// In en, this message translates to:
  /// **'Make'**
  String get captureAssetMakeLabel;

  /// No description provided for @captureAssetCapacityLabel.
  ///
  /// In en, this message translates to:
  /// **'Capacity / size *'**
  String get captureAssetCapacityLabel;

  /// No description provided for @captureAssetModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get captureAssetModelLabel;

  /// No description provided for @captureAssetYearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get captureAssetYearLabel;

  /// No description provided for @captureAssetSerialLabel.
  ///
  /// In en, this message translates to:
  /// **'Serial number'**
  String get captureAssetSerialLabel;

  /// No description provided for @captureAssetScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get captureAssetScan;

  /// No description provided for @captureAssetChooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose a category'**
  String get captureAssetChooseCategory;

  /// No description provided for @captureAssetChooseMake.
  ///
  /// In en, this message translates to:
  /// **'Choose a make'**
  String get captureAssetChooseMake;

  /// No description provided for @captureAssetCategoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose an equipment category'**
  String get captureAssetCategoryRequired;

  /// No description provided for @captureAssetCapacityRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter the capacity or size'**
  String get captureAssetCapacityRequired;

  /// No description provided for @captureAssetCategoryMissing.
  ///
  /// In en, this message translates to:
  /// **'Add a category'**
  String get captureAssetCategoryMissing;

  /// No description provided for @captureAssetCapacityMissing.
  ///
  /// In en, this message translates to:
  /// **'Add the capacity or size'**
  String get captureAssetCapacityMissing;

  /// No description provided for @captureAssetCapacityHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 100 kVA'**
  String get captureAssetCapacityHint;

  /// No description provided for @captureAssetModelHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. MG-100'**
  String get captureAssetModelHint;

  /// No description provided for @captureAssetYearHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 2021'**
  String get captureAssetYearHint;

  /// No description provided for @captureAssetSerialHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. MG100-2291'**
  String get captureAssetSerialHint;

  /// No description provided for @captureAssetQuantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get captureAssetQuantityLabel;

  /// No description provided for @captureAssetConditionLabel.
  ///
  /// In en, this message translates to:
  /// **'Condition grade *'**
  String get captureAssetConditionLabel;

  /// No description provided for @captureAssetConditionNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get captureAssetConditionNew;

  /// No description provided for @captureAssetConditionGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get captureAssetConditionGood;

  /// No description provided for @captureAssetConditionFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get captureAssetConditionFair;

  /// No description provided for @captureAssetConditionService.
  ///
  /// In en, this message translates to:
  /// **'Needs svc'**
  String get captureAssetConditionService;

  /// No description provided for @captureAssetConditionNewHelp.
  ///
  /// In en, this message translates to:
  /// **'New — pristine condition, never deployed on-site.'**
  String get captureAssetConditionNewHelp;

  /// No description provided for @captureAssetConditionGoodHelp.
  ///
  /// In en, this message translates to:
  /// **'Good — works as intended, normal wear.'**
  String get captureAssetConditionGoodHelp;

  /// No description provided for @captureAssetConditionFairHelp.
  ///
  /// In en, this message translates to:
  /// **'Fair — works, but shows visible wear.'**
  String get captureAssetConditionFairHelp;

  /// No description provided for @captureAssetConditionServiceHelp.
  ///
  /// In en, this message translates to:
  /// **'Needs service — has faults the vendor should fix.'**
  String get captureAssetConditionServiceHelp;

  /// No description provided for @captureAssetAvailabilityRental.
  ///
  /// In en, this message translates to:
  /// **'Rental only'**
  String get captureAssetAvailabilityRental;

  /// No description provided for @captureAssetAvailabilityBulk.
  ///
  /// In en, this message translates to:
  /// **'Bulk only'**
  String get captureAssetAvailabilityBulk;

  /// No description provided for @captureAssetAvailabilityBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get captureAssetAvailabilityBoth;

  /// No description provided for @captureAssetRentalHelperTitle.
  ///
  /// In en, this message translates to:
  /// **'Rental catalog flow'**
  String get captureAssetRentalHelperTitle;

  /// No description provided for @captureAssetRentalHelperBody.
  ///
  /// In en, this message translates to:
  /// **'Rental assets appear in the rentals catalog. They need a daily rate, a refundable caution deposit and micro-insurance — the vendor sets these after verification.'**
  String get captureAssetRentalHelperBody;

  /// No description provided for @captureAssetBulkHelperTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk catalog flow'**
  String get captureAssetBulkHelperTitle;

  /// No description provided for @captureAssetBulkHelperBody.
  ///
  /// In en, this message translates to:
  /// **'Bulk assets appear in the wholesale catalog, where buyers request quantities rather than book dates. No daily rate or caution deposit is needed.'**
  String get captureAssetBulkHelperBody;

  /// No description provided for @captureAssetBothHelperTitle.
  ///
  /// In en, this message translates to:
  /// **'Both catalogs'**
  String get captureAssetBothHelperTitle;

  /// No description provided for @captureAssetBothHelperBody.
  ///
  /// In en, this message translates to:
  /// **'This asset is listed in the rentals catalog and the wholesale catalog, so it can be booked or bought.'**
  String get captureAssetBothHelperBody;

  /// No description provided for @captureAssetChangeLater.
  ///
  /// In en, this message translates to:
  /// **'You can change this later from the app.'**
  String get captureAssetChangeLater;

  /// No description provided for @captureAssetAddAnother.
  ///
  /// In en, this message translates to:
  /// **'+ Add another asset'**
  String get captureAssetAddAnother;

  /// No description provided for @captureAssetAddFirst.
  ///
  /// In en, this message translates to:
  /// **'+ Add first asset'**
  String get captureAssetAddFirst;

  /// No description provided for @captureAssetEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No assets added yet'**
  String get captureAssetEmptyTitle;

  /// No description provided for @captureAssetEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add the shop\'s main equipment, or submit the shop on its own.'**
  String get captureAssetEmptyBody;

  /// No description provided for @captureAssetRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get captureAssetRemove;

  /// No description provided for @captureAssetInProgress.
  ///
  /// In en, this message translates to:
  /// **'{reference} (in progress)'**
  String captureAssetInProgress(Object reference);

  /// No description provided for @captureAssetQuantityValue.
  ///
  /// In en, this message translates to:
  /// **'Quantity {value}'**
  String captureAssetQuantityValue(Object value);

  /// No description provided for @captureAssetDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity'**
  String get captureAssetDecrease;

  /// No description provided for @captureAssetIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase quantity'**
  String get captureAssetIncrease;

  /// No description provided for @captureAssetReference.
  ///
  /// In en, this message translates to:
  /// **'AST-{id}'**
  String captureAssetReference(Object id);

  /// No description provided for @captureAssetSubmitWithoutAssets.
  ///
  /// In en, this message translates to:
  /// **'Continue without assets'**
  String get captureAssetSubmitWithoutAssets;

  /// No description provided for @captureAssetPrimaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue to media'**
  String get captureAssetPrimaryLabel;

  /// No description provided for @captureAssetConditionRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose a condition grade'**
  String get captureAssetConditionRequired;

  /// No description provided for @captureAssetCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 asset captured.} other{{count} assets captured.}}'**
  String captureAssetCountLabel(num count);

  /// No description provided for @captureAssetBountyAmount.
  ///
  /// In en, this message translates to:
  /// **'The bounty is ₦5,000 per shop, not per asset.'**
  String get captureAssetBountyAmount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
