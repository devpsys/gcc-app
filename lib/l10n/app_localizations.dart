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

  /// Lead-in to the agent sign-in copy.
  ///
  /// In en, this message translates to:
  /// **'Already have a GCC account?'**
  String get onboardingAlreadyAccount;

  /// Link on the phone step that opens agent sign-in. There is no email sign-in.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your agent ID instead.'**
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

  /// Secondary action on the next shop. Opens the field map.
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

  /// No description provided for @gpsHelperTitle.
  ///
  /// In en, this message translates to:
  /// **'Improve accuracy'**
  String get gpsHelperTitle;

  /// No description provided for @gpsHelperClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get gpsHelperClose;

  /// No description provided for @gpsSignalWeak.
  ///
  /// In en, this message translates to:
  /// **'Signal weak'**
  String get gpsSignalWeak;

  /// No description provided for @gpsSignalGood.
  ///
  /// In en, this message translates to:
  /// **'Signal good'**
  String get gpsSignalGood;

  /// No description provided for @gpsAccuracyValue.
  ///
  /// In en, this message translates to:
  /// **'±{value} m'**
  String gpsAccuracyValue(Object value);

  /// No description provided for @gpsAccuracyTarget.
  ///
  /// In en, this message translates to:
  /// **'Target ±25 m or better'**
  String get gpsAccuracyTarget;

  /// No description provided for @gpsStepOpenSky.
  ///
  /// In en, this message translates to:
  /// **'Step into the open sky'**
  String get gpsStepOpenSky;

  /// No description provided for @gpsStepHoldStill.
  ///
  /// In en, this message translates to:
  /// **'Hold still for 5 seconds'**
  String get gpsStepHoldStill;

  /// No description provided for @gpsStepAwayFromMetal.
  ///
  /// In en, this message translates to:
  /// **'Move away from metal roofs and walls'**
  String get gpsStepAwayFromMetal;

  /// No description provided for @gpsAcquiring.
  ///
  /// In en, this message translates to:
  /// **'Acquiring fix…'**
  String get gpsAcquiring;

  /// No description provided for @gpsSecondsShort.
  ///
  /// In en, this message translates to:
  /// **'{count} s'**
  String gpsSecondsShort(Object count);

  /// No description provided for @gpsTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get gpsTryAgain;

  /// No description provided for @gpsUseLastKnown.
  ///
  /// In en, this message translates to:
  /// **'Use last known location'**
  String get gpsUseLastKnown;

  /// No description provided for @gpsEnterCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Enter coordinates manually'**
  String get gpsEnterCoordinates;

  /// No description provided for @gpsPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Location access is off'**
  String get gpsPermissionTitle;

  /// No description provided for @gpsPermissionBody.
  ///
  /// In en, this message translates to:
  /// **'GCC uses your location to verify shops you map. Without it, bounties may take longer to approve.'**
  String get gpsPermissionBody;

  /// No description provided for @gpsHowToAllow.
  ///
  /// In en, this message translates to:
  /// **'How to allow location'**
  String get gpsHowToAllow;

  /// No description provided for @gpsAllowStep1.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get gpsAllowStep1;

  /// No description provided for @gpsAllowStep2.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get gpsAllowStep2;

  /// No description provided for @gpsAllowStep3.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get gpsAllowStep3;

  /// No description provided for @gpsAllowFootnote.
  ///
  /// In en, this message translates to:
  /// **'GPS coordinates required for rapid automated bounty payout.'**
  String get gpsAllowFootnote;

  /// No description provided for @gpsTurnOnLocation.
  ///
  /// In en, this message translates to:
  /// **'Turn on location'**
  String get gpsTurnOnLocation;

  /// No description provided for @gpsOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get gpsOpenSettings;

  /// No description provided for @gpsCoordinatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter coordinates'**
  String get gpsCoordinatesTitle;

  /// No description provided for @gpsCoordinatesHeading.
  ///
  /// In en, this message translates to:
  /// **'Enter coordinates manually'**
  String get gpsCoordinatesHeading;

  /// No description provided for @gpsCoordinatesHelper.
  ///
  /// In en, this message translates to:
  /// **'Read them off any map app. Use decimal degrees.'**
  String get gpsCoordinatesHelper;

  /// No description provided for @gpsLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get gpsLatitude;

  /// No description provided for @gpsLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get gpsLongitude;

  /// No description provided for @gpsDirectionNorth.
  ///
  /// In en, this message translates to:
  /// **'° N'**
  String get gpsDirectionNorth;

  /// No description provided for @gpsDirectionEast.
  ///
  /// In en, this message translates to:
  /// **'° E'**
  String get gpsDirectionEast;

  /// No description provided for @gpsLatitudeRange.
  ///
  /// In en, this message translates to:
  /// **'Latitude must be between -90 and 90'**
  String get gpsLatitudeRange;

  /// No description provided for @gpsLongitudeRange.
  ///
  /// In en, this message translates to:
  /// **'Longitude must be between -180 and 180'**
  String get gpsLongitudeRange;

  /// No description provided for @gpsSaveCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Save coordinates'**
  String get gpsSaveCoordinates;

  /// No description provided for @gpsDiscardCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get gpsDiscardCoordinates;

  /// No description provided for @gpsLatitudeExample.
  ///
  /// In en, this message translates to:
  /// **'9.0580'**
  String get gpsLatitudeExample;

  /// No description provided for @gpsLongitudeExample.
  ///
  /// In en, this message translates to:
  /// **'7.3986'**
  String get gpsLongitudeExample;

  /// No description provided for @gpsContinueWithFix.
  ///
  /// In en, this message translates to:
  /// **'Use this location'**
  String get gpsContinueWithFix;

  /// No description provided for @gpsContinueWithoutFix.
  ///
  /// In en, this message translates to:
  /// **'Continue without a verified fix'**
  String get gpsContinueWithoutFix;

  /// No description provided for @captureMediaTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture media'**
  String get captureMediaTitle;

  /// No description provided for @captureMediaStep.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total} · Photo & video'**
  String captureMediaStep(Object current, Object total);

  /// No description provided for @captureWhatToFilm.
  ///
  /// In en, this message translates to:
  /// **'What to film'**
  String get captureWhatToFilm;

  /// No description provided for @captureWhatToFilmReady.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} ready'**
  String captureWhatToFilmReady(Object done, Object total);

  /// No description provided for @captureWhatToFilmComplete.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} complete'**
  String captureWhatToFilmComplete(Object done, Object total);

  /// No description provided for @captureWhatToFilmExpand.
  ///
  /// In en, this message translates to:
  /// **'View all {count}'**
  String captureWhatToFilmExpand(Object count);

  /// No description provided for @captureWhatToFilmCollapse.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get captureWhatToFilmCollapse;

  /// No description provided for @captureFilmWholeMachine.
  ///
  /// In en, this message translates to:
  /// **'Whole machine from all four sides'**
  String get captureFilmWholeMachine;

  /// No description provided for @captureFilmExistingDamage.
  ///
  /// In en, this message translates to:
  /// **'Existing damage and wear'**
  String get captureFilmExistingDamage;

  /// No description provided for @captureFilmSerialPlate.
  ///
  /// In en, this message translates to:
  /// **'Serial number plate'**
  String get captureFilmSerialPlate;

  /// No description provided for @captureFilmFluidLevels.
  ///
  /// In en, this message translates to:
  /// **'Fuel and fluid levels'**
  String get captureFilmFluidLevels;

  /// No description provided for @captureFilmAccessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories and attachments'**
  String get captureFilmAccessories;

  /// No description provided for @captureKeepInFrame.
  ///
  /// In en, this message translates to:
  /// **'Keep the whole machine in frame'**
  String get captureKeepInFrame;

  /// No description provided for @captureClipLengthLabel.
  ///
  /// In en, this message translates to:
  /// **'30s CLIP'**
  String get captureClipLengthLabel;

  /// No description provided for @captureRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get captureRetake;

  /// No description provided for @captureUsePhoto.
  ///
  /// In en, this message translates to:
  /// **'Use photo'**
  String get captureUsePhoto;

  /// No description provided for @captureRecordClip.
  ///
  /// In en, this message translates to:
  /// **'Record 30s'**
  String get captureRecordClip;

  /// No description provided for @captureRecordingTitle.
  ///
  /// In en, this message translates to:
  /// **'Recording condition clip'**
  String get captureRecordingTitle;

  /// No description provided for @captureRecordingBadge.
  ///
  /// In en, this message translates to:
  /// **'● RECORDING'**
  String get captureRecordingBadge;

  /// No description provided for @captureRecordingElapsed.
  ///
  /// In en, this message translates to:
  /// **'REC: {elapsed}s / 30s MINIMUM'**
  String captureRecordingElapsed(Object elapsed);

  /// No description provided for @captureRecordingHint.
  ///
  /// In en, this message translates to:
  /// **'Tap square to finish early (≥30s)'**
  String get captureRecordingHint;

  /// No description provided for @captureAlmostDone.
  ///
  /// In en, this message translates to:
  /// **'Almost done — keep it steady'**
  String get captureAlmostDone;

  /// No description provided for @captureTimerValue.
  ///
  /// In en, this message translates to:
  /// **'00:{seconds}'**
  String captureTimerValue(Object seconds);

  /// No description provided for @capturePermissionBadge.
  ///
  /// In en, this message translates to:
  /// **'CAMERA BLOCKED'**
  String get capturePermissionBadge;

  /// No description provided for @capturePermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera access is off'**
  String get capturePermissionTitle;

  /// No description provided for @capturePermissionHowTo.
  ///
  /// In en, this message translates to:
  /// **'How to allow camera access'**
  String get capturePermissionHowTo;

  /// No description provided for @capturePermissionStep3.
  ///
  /// In en, this message translates to:
  /// **'Camera → Allow while using app'**
  String get capturePermissionStep3;

  /// No description provided for @captureTurnOnCamera.
  ///
  /// In en, this message translates to:
  /// **'Turn on camera'**
  String get captureTurnOnCamera;

  /// No description provided for @captureContinueWithoutVideo.
  ///
  /// In en, this message translates to:
  /// **'Continue without video'**
  String get captureContinueWithoutVideo;

  /// No description provided for @captureIncompleteClipBadge.
  ///
  /// In en, this message translates to:
  /// **'INCOMPLETE CLIP'**
  String get captureIncompleteClipBadge;

  /// No description provided for @captureClipTooShort.
  ///
  /// In en, this message translates to:
  /// **'Recording stopped after {seconds} s — the minimum is 30 seconds.'**
  String captureClipTooShort(Object seconds);

  /// No description provided for @captureClipTooShortWhy.
  ///
  /// In en, this message translates to:
  /// **'Clip too short for warranty dispute audit'**
  String get captureClipTooShortWhy;

  /// No description provided for @captureRerecord.
  ///
  /// In en, this message translates to:
  /// **'Re-record 30s video'**
  String get captureRerecord;

  /// No description provided for @captureUseWhatWeHave.
  ///
  /// In en, this message translates to:
  /// **'Use what we have ({seconds} s)'**
  String captureUseWhatWeHave(Object seconds);

  /// No description provided for @captureGalleryCount.
  ///
  /// In en, this message translates to:
  /// **'{count}'**
  String captureGalleryCount(Object count);

  /// No description provided for @captureStartRecording.
  ///
  /// In en, this message translates to:
  /// **'Start recording'**
  String get captureStartRecording;

  /// No description provided for @captureStopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop recording'**
  String get captureStopRecording;

  /// No description provided for @captureGalleryThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Open gallery, {count} items'**
  String captureGalleryThumbnail(Object count);

  /// No description provided for @captureSignalVerified.
  ///
  /// In en, this message translates to:
  /// **'Location pinned'**
  String get captureSignalVerified;

  /// No description provided for @captureUnverifiedPlace.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get captureUnverifiedPlace;

  /// No description provided for @captureAccuracyValue.
  ///
  /// In en, this message translates to:
  /// **'±{value} m'**
  String captureAccuracyValue(Object value);

  /// No description provided for @capturePermissionBody.
  ///
  /// In en, this message translates to:
  /// **'A condition clip protects the vendor if a rental is disputed. Without it, disputes are harder to settle.'**
  String get capturePermissionBody;

  /// No description provided for @compressTitle.
  ///
  /// In en, this message translates to:
  /// **'Preparing video'**
  String get compressTitle;

  /// No description provided for @compressTitleUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading clip'**
  String get compressTitleUploading;

  /// No description provided for @compressDuration.
  ///
  /// In en, this message translates to:
  /// **'00:30'**
  String get compressDuration;

  /// No description provided for @compressFormat.
  ///
  /// In en, this message translates to:
  /// **'1080p · MP4'**
  String get compressFormat;

  /// No description provided for @compressStepOptimised.
  ///
  /// In en, this message translates to:
  /// **'Compressed 1080p → optimised'**
  String get compressStepOptimised;

  /// No description provided for @compressStepCompressing.
  ///
  /// In en, this message translates to:
  /// **'Compressing in {seconds} s…'**
  String compressStepCompressing(Object seconds);

  /// No description provided for @compressStepSaved.
  ///
  /// In en, this message translates to:
  /// **'File saved to this phone'**
  String get compressStepSaved;

  /// No description provided for @compressStepQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued — uploads automatically'**
  String get compressStepQueued;

  /// No description provided for @compressStepUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading when you\'re on data'**
  String get compressStepUploading;

  /// No description provided for @compressStepPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused — waiting for power'**
  String get compressStepPaused;

  /// No description provided for @compressProgress.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String compressProgress(Object percent);

  /// No description provided for @compressUploadingDetail.
  ///
  /// In en, this message translates to:
  /// **'Uploading · {done} of {total}'**
  String compressUploadingDetail(Object done, Object total);

  /// No description provided for @compressTransferRate.
  ///
  /// In en, this message translates to:
  /// **'≈ {rate} · about {seconds} left'**
  String compressTransferRate(Object rate, Object seconds);

  /// No description provided for @compressNote.
  ///
  /// In en, this message translates to:
  /// **'Compression happens on this phone. Your video never leaves uncompressed — GCC uploads a small file so your data lasts.'**
  String get compressNote;

  /// No description provided for @compressQualityHeading.
  ///
  /// In en, this message translates to:
  /// **'Quality options'**
  String get compressQualityHeading;

  /// No description provided for @compressQualitySmallest.
  ///
  /// In en, this message translates to:
  /// **'Smallest'**
  String get compressQualitySmallest;

  /// No description provided for @compressQualityBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get compressQualityBalanced;

  /// No description provided for @compressQualityOriginal.
  ///
  /// In en, this message translates to:
  /// **'Original 1080p'**
  String get compressQualityOriginal;

  /// No description provided for @compressQualitySmallestHint.
  ///
  /// In en, this message translates to:
  /// **'Best quality for reviews'**
  String get compressQualitySmallestHint;

  /// No description provided for @compressQualityBalancedHint.
  ///
  /// In en, this message translates to:
  /// **'Sharper, larger file'**
  String get compressQualityBalancedHint;

  /// No description provided for @compressQualityOriginalHint.
  ///
  /// In en, this message translates to:
  /// **'Not recommended on 3G'**
  String get compressQualityOriginalHint;

  /// No description provided for @compressRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get compressRecommended;

  /// No description provided for @compressApproxOn3g.
  ///
  /// In en, this message translates to:
  /// **'≈{duration} on 3G'**
  String compressApproxOn3g(Object duration);

  /// No description provided for @compressChooseQuality.
  ///
  /// In en, this message translates to:
  /// **'Choose a different quality'**
  String get compressChooseQuality;

  /// No description provided for @compressContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get compressContinue;

  /// No description provided for @compressQueuedBadge.
  ///
  /// In en, this message translates to:
  /// **'Pending 3G'**
  String get compressQueuedBadge;

  /// No description provided for @compressDoneBadge.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get compressDoneBadge;

  /// No description provided for @compressSelectedProfile.
  ///
  /// In en, this message translates to:
  /// **'Selected profile'**
  String get compressSelectedProfile;

  /// No description provided for @compressDraftSynced.
  ///
  /// In en, this message translates to:
  /// **'Your submission draft is synced with offline queue item {reference}'**
  String compressDraftSynced(Object reference);

  /// No description provided for @compressUploadOnWifi.
  ///
  /// In en, this message translates to:
  /// **'Upload now if you\'re on Wi-Fi'**
  String get compressUploadOnWifi;

  /// No description provided for @compressWaitForUpload.
  ///
  /// In en, this message translates to:
  /// **'Wait for the upload to finish'**
  String get compressWaitForUpload;

  /// No description provided for @compressContinueBackground.
  ///
  /// In en, this message translates to:
  /// **'Continue in background'**
  String get compressContinueBackground;

  /// No description provided for @compressNetworkWarning.
  ///
  /// In en, this message translates to:
  /// **'Connected to {network}. Do not close this app until complete.'**
  String compressNetworkWarning(Object network);

  /// No description provided for @compressStorageBadge.
  ///
  /// In en, this message translates to:
  /// **'Space Low'**
  String get compressStorageBadge;

  /// No description provided for @compressStorageTitle.
  ///
  /// In en, this message translates to:
  /// **'Not enough storage on this phone'**
  String get compressStorageTitle;

  /// No description provided for @compressStorageReason.
  ///
  /// In en, this message translates to:
  /// **'{required} required to upload, {free} free. Cached upload history takes {cache}'**
  String compressStorageReason(Object cache, Object free, Object required);

  /// No description provided for @compressStorageHeading.
  ///
  /// In en, this message translates to:
  /// **'What\'s taking space'**
  String get compressStorageHeading;

  /// No description provided for @compressSpaceHistory.
  ///
  /// In en, this message translates to:
  /// **'Cached upload history'**
  String get compressSpaceHistory;

  /// No description provided for @compressSpacePhotos.
  ///
  /// In en, this message translates to:
  /// **'Shop photos'**
  String get compressSpacePhotos;

  /// No description provided for @compressSpaceMaps.
  ///
  /// In en, this message translates to:
  /// **'Downloaded maps'**
  String get compressSpaceMaps;

  /// No description provided for @compressClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get compressClear;

  /// No description provided for @compressFreeUpSpace.
  ///
  /// In en, this message translates to:
  /// **'Free up space'**
  String get compressFreeUpSpace;

  /// No description provided for @compressUploadLater.
  ///
  /// In en, this message translates to:
  /// **'Upload later'**
  String get compressUploadLater;

  /// No description provided for @compressBatteryBadge.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get compressBatteryBadge;

  /// No description provided for @compressBatteryReason.
  ///
  /// In en, this message translates to:
  /// **'Low battery — {percent}% remaining'**
  String compressBatteryReason(Object percent);

  /// No description provided for @compressSavedTo.
  ///
  /// In en, this message translates to:
  /// **'Saved to {destination}'**
  String compressSavedTo(Object destination);

  /// No description provided for @reviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review & submit'**
  String get reviewTitle;

  /// No description provided for @reviewSectionShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get reviewSectionShop;

  /// No description provided for @reviewSectionLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get reviewSectionLocation;

  /// No description provided for @reviewSectionAssets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get reviewSectionAssets;

  /// No description provided for @reviewSectionMedia.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get reviewSectionMedia;

  /// No description provided for @reviewLabelShopName.
  ///
  /// In en, this message translates to:
  /// **'Shop name'**
  String get reviewLabelShopName;

  /// No description provided for @reviewLabelShopType.
  ///
  /// In en, this message translates to:
  /// **'Shop type'**
  String get reviewLabelShopType;

  /// No description provided for @reviewLabelOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get reviewLabelOwner;

  /// No description provided for @reviewLabelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get reviewLabelPhone;

  /// No description provided for @reviewLabelSells.
  ///
  /// In en, this message translates to:
  /// **'Sells'**
  String get reviewLabelSells;

  /// No description provided for @reviewLabelMarket.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get reviewLabelMarket;

  /// No description provided for @reviewLabelZone.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get reviewLabelZone;

  /// No description provided for @reviewLabelLine.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get reviewLabelLine;

  /// No description provided for @reviewLabelLandmark.
  ///
  /// In en, this message translates to:
  /// **'Landmark'**
  String get reviewLabelLandmark;

  /// No description provided for @reviewCoordinates.
  ///
  /// In en, this message translates to:
  /// **'{latitude}° N, {longitude}° E · {accuracy}'**
  String reviewCoordinates(Object accuracy, Object latitude, Object longitude);

  /// No description provided for @reviewLandmarkMissing.
  ///
  /// In en, this message translates to:
  /// **'[Missing description]'**
  String get reviewLandmarkMissing;

  /// No description provided for @reviewLandmarkMissingWhy.
  ///
  /// In en, this message translates to:
  /// **'Add a landmark description — shops without one can\'t be verified'**
  String get reviewLandmarkMissingWhy;

  /// No description provided for @reviewGpsOnly.
  ///
  /// In en, this message translates to:
  /// **'GPS only'**
  String get reviewGpsOnly;

  /// No description provided for @reviewLandmarkMissingBadge.
  ///
  /// In en, this message translates to:
  /// **'Landmark missing'**
  String get reviewLandmarkMissingBadge;

  /// No description provided for @reviewEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get reviewEdit;

  /// No description provided for @reviewFixNow.
  ///
  /// In en, this message translates to:
  /// **'Fix now →'**
  String get reviewFixNow;

  /// No description provided for @reviewAssetsCaptured.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 asset captured} other{{count} assets captured}}'**
  String reviewAssetsCaptured(num count);

  /// No description provided for @reviewRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get reviewRetake;

  /// No description provided for @reviewMediaPhoto.
  ///
  /// In en, this message translates to:
  /// **'Shopfront'**
  String get reviewMediaPhoto;

  /// No description provided for @reviewMediaPhotoHint.
  ///
  /// In en, this message translates to:
  /// **'Exterior facade & sign'**
  String get reviewMediaPhotoHint;

  /// No description provided for @reviewMediaClip.
  ///
  /// In en, this message translates to:
  /// **'Condition clip · {duration}'**
  String reviewMediaClip(Object duration);

  /// No description provided for @reviewMediaWalkaround.
  ///
  /// In en, this message translates to:
  /// **'360° walkaround proof'**
  String get reviewMediaWalkaround;

  /// No description provided for @reviewMediaCompressed.
  ///
  /// In en, this message translates to:
  /// **'Compressed from {original} on this phone'**
  String reviewMediaCompressed(Object original);

  /// No description provided for @reviewBountyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'BOUNTY IF VERIFIED'**
  String get reviewBountyEyebrow;

  /// No description provided for @reviewBountyNote.
  ///
  /// In en, this message translates to:
  /// **'{earned} earned from {count} verified shops this week.'**
  String reviewBountyNote(Object count, Object earned);

  /// No description provided for @reviewSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get reviewSubmit;

  /// No description provided for @reviewSaveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save draft'**
  String get reviewSaveDraft;

  /// No description provided for @reviewOfflineBadge.
  ///
  /// In en, this message translates to:
  /// **'Offline · this will be queued'**
  String get reviewOfflineBadge;

  /// No description provided for @reviewOfflineReason.
  ///
  /// In en, this message translates to:
  /// **'Offline. Submit will save to this phone and upload automatically.'**
  String get reviewOfflineReason;

  /// No description provided for @reviewNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 field needs attention} other{{count} fields need attention}}'**
  String reviewNeedsAttention(num count);

  /// No description provided for @reviewBlockedReason.
  ///
  /// In en, this message translates to:
  /// **'Add a landmark description to submit'**
  String get reviewBlockedReason;

  /// No description provided for @queuedTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop captured'**
  String get queuedTitle;

  /// No description provided for @queuedShopLine.
  ///
  /// In en, this message translates to:
  /// **'{shop} · {market}'**
  String queuedShopLine(Object market, Object shop);

  /// No description provided for @queuedUploadedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Uploaded and sent to review'**
  String get queuedUploadedHeadline;

  /// No description provided for @queuedOfflineHeadline.
  ///
  /// In en, this message translates to:
  /// **'Saved on this phone'**
  String get queuedOfflineHeadline;

  /// No description provided for @queuedVerificationNote.
  ///
  /// In en, this message translates to:
  /// **'An admin checks every shop before the bounty is paid. Usually within 24 hours.'**
  String get queuedVerificationNote;

  /// No description provided for @queuedLabelReference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get queuedLabelReference;

  /// No description provided for @queuedLabelCaptured.
  ///
  /// In en, this message translates to:
  /// **'Captured'**
  String get queuedLabelCaptured;

  /// No description provided for @queuedLabelAssets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get queuedLabelAssets;

  /// No description provided for @queuedLabelMedia.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get queuedLabelMedia;

  /// No description provided for @queuedLabelBounty.
  ///
  /// In en, this message translates to:
  /// **'Bounty'**
  String get queuedLabelBounty;

  /// No description provided for @queuedPendingVerification.
  ///
  /// In en, this message translates to:
  /// **'Pending verification'**
  String get queuedPendingVerification;

  /// No description provided for @queuedWhatNext.
  ///
  /// In en, this message translates to:
  /// **'What happens next'**
  String get queuedWhatNext;

  /// No description provided for @queuedStepReview.
  ///
  /// In en, this message translates to:
  /// **'An admin reviews the shop and photos'**
  String get queuedStepReview;

  /// No description provided for @queuedStepApproved.
  ///
  /// In en, this message translates to:
  /// **'If it\'s approved,'**
  String get queuedStepApproved;

  /// No description provided for @queuedStepPayout.
  ///
  /// In en, this message translates to:
  /// **'goes into your next payout run'**
  String get queuedStepPayout;

  /// No description provided for @queuedStepSms.
  ///
  /// In en, this message translates to:
  /// **'You\'ll get an SMS when the verdict comes through'**
  String get queuedStepSms;

  /// No description provided for @queuedStepQueued.
  ///
  /// In en, this message translates to:
  /// **'Your shop is queued and uploads when you\'re online'**
  String get queuedStepQueued;

  /// No description provided for @queuedCaptureAnother.
  ///
  /// In en, this message translates to:
  /// **'Capture another'**
  String get queuedCaptureAnother;

  /// No description provided for @queuedBackToToday.
  ///
  /// In en, this message translates to:
  /// **'Back to today'**
  String get queuedBackToToday;

  /// No description provided for @queuedViewQueue.
  ///
  /// In en, this message translates to:
  /// **'View my queue'**
  String get queuedViewQueue;

  /// No description provided for @queuedDailyMilestone.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 shop captured today} other{{count} shops captured today}}'**
  String queuedDailyMilestone(num count);

  /// No description provided for @queuedDailyPending.
  ///
  /// In en, this message translates to:
  /// **'{amount} pending'**
  String queuedDailyPending(Object amount);

  /// No description provided for @compressSizePair.
  ///
  /// In en, this message translates to:
  /// **'{before} → {after}'**
  String compressSizePair(Object after, Object before);

  /// No description provided for @compressNetworkName.
  ///
  /// In en, this message translates to:
  /// **'Kugbo_Fast_WiFi'**
  String get compressNetworkName;

  /// No description provided for @compressQueueReference.
  ///
  /// In en, this message translates to:
  /// **'SUB-2204'**
  String get compressQueueReference;

  /// Shown when a queue item route has no matching submission.
  ///
  /// In en, this message translates to:
  /// **'This submission is not in the queue.'**
  String get syncItemMissing;

  /// No description provided for @syncQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync queue'**
  String get syncQueueTitle;

  /// No description provided for @syncStripOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get syncStripOffline;

  /// No description provided for @syncStripDataLimit.
  ///
  /// In en, this message translates to:
  /// **'DATA LIMIT'**
  String get syncStripDataLimit;

  /// No description provided for @syncStripLastSynced.
  ///
  /// In en, this message translates to:
  /// **'Last synced {time}'**
  String syncStripLastSynced(Object time);

  /// No description provided for @syncStripSyncing.
  ///
  /// In en, this message translates to:
  /// **'◐ Syncing · {done} of {total}'**
  String syncStripSyncing(Object done, Object total);

  /// No description provided for @syncLabelConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get syncLabelConnection;

  /// No description provided for @syncLabelLastSync.
  ///
  /// In en, this message translates to:
  /// **'Last sync'**
  String get syncLabelLastSync;

  /// No description provided for @syncLabelStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get syncLabelStorage;

  /// No description provided for @syncLabelQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get syncLabelQueued;

  /// No description provided for @syncConnectionOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get syncConnectionOffline;

  /// No description provided for @syncConnectionOnline.
  ///
  /// In en, this message translates to:
  /// **'4G LTE · Online'**
  String get syncConnectionOnline;

  /// No description provided for @syncConnectionCapped.
  ///
  /// In en, this message translates to:
  /// **'Limit capped'**
  String get syncConnectionCapped;

  /// No description provided for @syncConnectionWeak.
  ///
  /// In en, this message translates to:
  /// **'3G · weak'**
  String get syncConnectionWeak;

  /// No description provided for @syncLastInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress…'**
  String get syncLastInProgress;

  /// No description provided for @syncJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get syncJustNow;

  /// No description provided for @syncStorageFree.
  ///
  /// In en, this message translates to:
  /// **'{free} free of {total}'**
  String syncStorageFree(Object free, Object total);

  /// No description provided for @syncQueuedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items · {size}'**
  String syncQueuedCount(Object count, Object size);

  /// No description provided for @syncQueuedNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing waiting'**
  String get syncQueuedNothing;

  /// No description provided for @syncStorageCaption.
  ///
  /// In en, this message translates to:
  /// **'{free} free of {total}'**
  String syncStorageCaption(Object free, Object total);

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync now'**
  String get syncNow;

  /// No description provided for @syncUploadWifiOnly.
  ///
  /// In en, this message translates to:
  /// **'Upload on Wi-Fi only'**
  String get syncUploadWifiOnly;

  /// No description provided for @syncProcessingBatch.
  ///
  /// In en, this message translates to:
  /// **'Processing Batch'**
  String get syncProcessingBatch;

  /// No description provided for @syncPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get syncPause;

  /// No description provided for @syncWaitingToUpload.
  ///
  /// In en, this message translates to:
  /// **'Waiting to upload ({count})'**
  String syncWaitingToUpload(Object count);

  /// No description provided for @syncFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get syncFilter;

  /// No description provided for @syncDiscardFailed.
  ///
  /// In en, this message translates to:
  /// **'Discard failed items'**
  String get syncDiscardFailed;

  /// No description provided for @syncProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% completed'**
  String syncProgressPercent(Object percent);

  /// No description provided for @syncBatchProgress.
  ///
  /// In en, this message translates to:
  /// **'Syncing {done} of {total} · {doneSize} of {totalSize}'**
  String syncBatchProgress(
    Object done,
    Object doneSize,
    Object total,
    Object totalSize,
  );

  /// No description provided for @syncCloseHint.
  ///
  /// In en, this message translates to:
  /// **'You can close this screen. Syncing continues.'**
  String get syncCloseHint;

  /// No description provided for @syncUploadBlocked.
  ///
  /// In en, this message translates to:
  /// **'Upload blocked — daily data limit reached (2 GB). Resets {date}.'**
  String syncUploadBlocked(Object date);

  /// No description provided for @syncAllSyncedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Everything is synced'**
  String get syncAllSyncedHeadline;

  /// No description provided for @syncAllSyncedDetail.
  ///
  /// In en, this message translates to:
  /// **'Last sync {time} · {count, plural, =1{1 submission} other{{count} submissions}} this week'**
  String syncAllSyncedDetail(num count, Object time);

  /// No description provided for @syncViewSubmitted.
  ///
  /// In en, this message translates to:
  /// **'View submitted shops'**
  String get syncViewSubmitted;

  /// No description provided for @syncBountyHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your bounty is'**
  String get syncBountyHeadline;

  /// No description provided for @syncBountyAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} for {count, plural, =1{1 verified shop} other{{count} verified shops}} in this run.'**
  String syncBountyAmount(Object amount, num count);

  /// No description provided for @syncItemQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get syncItemQueued;

  /// No description provided for @syncItemSyncing.
  ///
  /// In en, this message translates to:
  /// **'◐ Uploading'**
  String get syncItemSyncing;

  /// No description provided for @syncItemSynced.
  ///
  /// In en, this message translates to:
  /// **'✓ Synced'**
  String get syncItemSynced;

  /// No description provided for @syncItemFailed.
  ///
  /// In en, this message translates to:
  /// **'✕ Failed'**
  String get syncItemFailed;

  /// No description provided for @syncItemCaptured.
  ///
  /// In en, this message translates to:
  /// **'Captured {time} · {count, plural, =1{1 item} other{{count} items}}'**
  String syncItemCaptured(num count, Object time);

  /// No description provided for @syncItemSizes.
  ///
  /// In en, this message translates to:
  /// **'{photos} photo + {videos} video'**
  String syncItemSizes(Object photos, Object videos);

  /// No description provided for @syncItemTotal.
  ///
  /// In en, this message translates to:
  /// **'{size} total payload'**
  String syncItemTotal(Object size);

  /// No description provided for @syncItemUploading.
  ///
  /// In en, this message translates to:
  /// **'{percent} % · {done} of {total}'**
  String syncItemUploading(Object done, Object percent, Object total);

  /// No description provided for @syncItemSyncedAt.
  ///
  /// In en, this message translates to:
  /// **'Synced {time}'**
  String syncItemSyncedAt(Object time);

  /// No description provided for @syncItemFailedReason.
  ///
  /// In en, this message translates to:
  /// **'Network timeout after {seconds} s'**
  String syncItemFailedReason(Object seconds);

  /// No description provided for @syncItemFailedData.
  ///
  /// In en, this message translates to:
  /// **'Upload blocked — daily data limit reached (2 GB).'**
  String get syncItemFailedData;

  /// No description provided for @syncOpensQueueItem.
  ///
  /// In en, this message translates to:
  /// **'Open {shop} queue item'**
  String syncOpensQueueItem(Object shop);

  /// No description provided for @itemTitle.
  ///
  /// In en, this message translates to:
  /// **'Queue item'**
  String get itemTitle;

  /// No description provided for @itemFailedBadge.
  ///
  /// In en, this message translates to:
  /// **'Network timeout'**
  String get itemFailedBadge;

  /// No description provided for @itemFailedHeadline.
  ///
  /// In en, this message translates to:
  /// **'✕ Upload failed · {reason}'**
  String itemFailedHeadline(Object reason);

  /// No description provided for @itemRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get itemRetry;

  /// No description provided for @itemSyncedBadge.
  ///
  /// In en, this message translates to:
  /// **'✓ Synced {time}'**
  String itemSyncedBadge(Object time);

  /// No description provided for @itemSyncedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Synced {time}'**
  String itemSyncedHeadline(Object time);

  /// No description provided for @itemVerifiedHeadline.
  ///
  /// In en, this message translates to:
  /// **'100% verified'**
  String get itemVerifiedHeadline;

  /// No description provided for @itemProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'{done} / {total}'**
  String itemProgressLabel(Object done, Object total);

  /// No description provided for @itemCaptureData.
  ///
  /// In en, this message translates to:
  /// **'Capture data'**
  String get itemCaptureData;

  /// No description provided for @itemLabelShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get itemLabelShop;

  /// No description provided for @itemLabelOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get itemLabelOwner;

  /// No description provided for @itemLabelLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get itemLabelLocation;

  /// No description provided for @itemLabelGps.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get itemLabelGps;

  /// No description provided for @itemLabelCaptured.
  ///
  /// In en, this message translates to:
  /// **'Captured'**
  String get itemLabelCaptured;

  /// No description provided for @itemLabelDevice.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get itemLabelDevice;

  /// No description provided for @itemFiles.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get itemFiles;

  /// No description provided for @itemGpsAtCapture.
  ///
  /// In en, this message translates to:
  /// **'{accuracy} at capture'**
  String itemGpsAtCapture(Object accuracy);

  /// No description provided for @itemWhyFailed.
  ///
  /// In en, this message translates to:
  /// **'Why did this fail?'**
  String get itemWhyFailed;

  /// No description provided for @itemRetryUpload.
  ///
  /// In en, this message translates to:
  /// **'Retry upload'**
  String get itemRetryUpload;

  /// No description provided for @itemEditOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Edit on device'**
  String get itemEditOnDevice;

  /// No description provided for @itemDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard this submission'**
  String get itemDiscard;

  /// No description provided for @itemDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered safely to central ingest servers.'**
  String get itemDelivered;

  /// No description provided for @itemSentToReview.
  ///
  /// In en, this message translates to:
  /// **'Uploaded and sent to review'**
  String get itemSentToReview;

  /// No description provided for @itemSentToReviewBody.
  ///
  /// In en, this message translates to:
  /// **'An admin will verify this shop, usually within 24 hours. Your bounty of {amount} will unlock upon approval.'**
  String itemSentToReviewBody(Object amount);

  /// No description provided for @itemViewSubmission.
  ///
  /// In en, this message translates to:
  /// **'View submission'**
  String get itemViewSubmission;

  /// No description provided for @itemEditLocked.
  ///
  /// In en, this message translates to:
  /// **'Submissions can\'t be edited after upload.'**
  String get itemEditLocked;

  /// No description provided for @itemConflictHeadline.
  ///
  /// In en, this message translates to:
  /// **'Someone else mapped this shop first'**
  String get itemConflictHeadline;

  /// No description provided for @itemConflictAgent.
  ///
  /// In en, this message translates to:
  /// **'{name}'**
  String itemConflictAgent(Object name);

  /// No description provided for @itemConflictAgentId.
  ///
  /// In en, this message translates to:
  /// **'{id}'**
  String itemConflictAgentId(Object id);

  /// No description provided for @itemConflictMapped.
  ///
  /// In en, this message translates to:
  /// **'Mapped first'**
  String get itemConflictMapped;

  /// No description provided for @itemConflictVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified first'**
  String get itemConflictVerified;

  /// No description provided for @itemFileNotUploaded.
  ///
  /// In en, this message translates to:
  /// **'Not uploaded'**
  String get itemFileNotUploaded;

  /// No description provided for @itemFileSyncedAt.
  ///
  /// In en, this message translates to:
  /// **'✓ Synced {time}'**
  String itemFileSyncedAt(Object time);

  /// No description provided for @itemConflictRetained.
  ///
  /// In en, this message translates to:
  /// **'Local media retained safely in offline storage.'**
  String get itemConflictRetained;

  /// No description provided for @itemDiscardMyCopy.
  ///
  /// In en, this message translates to:
  /// **'Discard my copy'**
  String get itemDiscardMyCopy;

  /// No description provided for @itemKeepForReference.
  ///
  /// In en, this message translates to:
  /// **'Keep for reference'**
  String get itemKeepForReference;

  /// No description provided for @itemDiscardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discarding requires 2-step confirmation. No data lost.'**
  String get itemDiscardConfirm;

  /// No description provided for @itemDiscardedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Submission discarded'**
  String get itemDiscardedHeadline;

  /// No description provided for @itemDiscardedBody.
  ///
  /// In en, this message translates to:
  /// **'{shop} was removed from this phone. The {amount} bounty is no longer claimable for this shop.'**
  String itemDiscardedBody(Object amount, Object shop);

  /// No description provided for @itemStorageReclaimed.
  ///
  /// In en, this message translates to:
  /// **'{size} storage reclaimed on {device}'**
  String itemStorageReclaimed(Object device, Object size);

  /// No description provided for @itemBackToQueue.
  ///
  /// In en, this message translates to:
  /// **'Back to sync queue'**
  String get itemBackToQueue;

  /// No description provided for @itemCaptureAnother.
  ///
  /// In en, this message translates to:
  /// **'Capture another'**
  String get itemCaptureAnother;

  /// No description provided for @itemItemFailedShort.
  ///
  /// In en, this message translates to:
  /// **'✕ Failed'**
  String get itemItemFailedShort;

  /// No description provided for @itemKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get itemKeep;

  /// No description provided for @syncNothingYetTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing in the queue yet'**
  String get syncNothingYetTitle;

  /// No description provided for @syncNothingYetBody.
  ///
  /// In en, this message translates to:
  /// **'Captures you make in the field will wait here until they upload.'**
  String get syncNothingYetBody;

  /// No description provided for @syncNothingYetNote.
  ///
  /// In en, this message translates to:
  /// **'Queuing is working offline-first: nothing is lost if you lose signal.'**
  String get syncNothingYetNote;

  /// No description provided for @shopsTitle.
  ///
  /// In en, this message translates to:
  /// **'Assigned shops'**
  String get shopsTitle;

  /// No description provided for @shopsScopeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get shopsScopeToday;

  /// No description provided for @shopsScopeAll.
  ///
  /// In en, this message translates to:
  /// **'All 24'**
  String get shopsScopeAll;

  /// No description provided for @shopsSummaryDone.
  ///
  /// In en, this message translates to:
  /// **'done'**
  String get shopsSummaryDone;

  /// No description provided for @shopsSummaryCaptured.
  ///
  /// In en, this message translates to:
  /// **'Captured'**
  String get shopsSummaryCaptured;

  /// No description provided for @shopsSummaryRoute.
  ///
  /// In en, this message translates to:
  /// **'Route total'**
  String get shopsSummaryRoute;

  /// No description provided for @shopsFilterAllMarkets.
  ///
  /// In en, this message translates to:
  /// **'All markets'**
  String get shopsFilterAllMarkets;

  /// No description provided for @shopsFilterAllStatus.
  ///
  /// In en, this message translates to:
  /// **'All status'**
  String get shopsFilterAllStatus;

  /// No description provided for @shopsFilterNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention ({count})'**
  String shopsFilterNeedsAttention(Object count);

  /// No description provided for @shopsFilterTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get shopsFilterTotal;

  /// No description provided for @shopsFilterMarkets.
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get shopsFilterMarkets;

  /// No description provided for @shopsSortedByDistance.
  ///
  /// In en, this message translates to:
  /// **'Sorted by distance'**
  String get shopsSortedByDistance;

  /// No description provided for @shopsClearSort.
  ///
  /// In en, this message translates to:
  /// **'Clear sort'**
  String get shopsClearSort;

  /// No description provided for @shopsStatusQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get shopsStatusQueued;

  /// No description provided for @shopsStatusSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get shopsStatusSynced;

  /// No description provided for @shopsStatusNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get shopsStatusNeedsAttention;

  /// No description provided for @shopsStatusNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get shopsStatusNotStarted;

  /// No description provided for @shopsStatusVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get shopsStatusVerified;

  /// No description provided for @shopsVerifiedBy.
  ///
  /// In en, this message translates to:
  /// **'Verified {date} by {agent}'**
  String shopsVerifiedBy(Object agent, Object date);

  /// No description provided for @shopsCoords.
  ///
  /// In en, this message translates to:
  /// **'{coords} · {distance}'**
  String shopsCoords(Object coords, Object distance);

  /// No description provided for @shopsStartNextStop.
  ///
  /// In en, this message translates to:
  /// **'Start next stop — {distance}'**
  String shopsStartNextStop(Object distance);

  /// No description provided for @shopsAllDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'All {count} shops captured'**
  String shopsAllDoneTitle(Object count);

  /// No description provided for @shopsAllDoneBody.
  ///
  /// In en, this message translates to:
  /// **'Uploaded {uploaded} · {pending, plural, =1{1 pending} other{{pending} pending}}. Your route is {distance} and took {elapsed}.'**
  String shopsAllDoneBody(
    Object distance,
    Object elapsed,
    num pending,
    Object uploaded,
  );

  /// No description provided for @shopsLoadNextRoute.
  ///
  /// In en, this message translates to:
  /// **'Load next route'**
  String get shopsLoadNextRoute;

  /// No description provided for @shopsViewSubmissions.
  ///
  /// In en, this message translates to:
  /// **'View submissions'**
  String get shopsViewSubmissions;

  /// No description provided for @shopsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No shops on this route yet'**
  String get shopsEmptyTitle;

  /// No description provided for @shopsEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Your supervisor assigns shops here. Pull down to check again.'**
  String get shopsEmptyDesc;

  /// No description provided for @shopsStatusAt.
  ///
  /// In en, this message translates to:
  /// **'{shop} is {status}'**
  String shopsStatusAt(Object shop, Object status);

  /// No description provided for @shopsNoMoneyNotice.
  ///
  /// In en, this message translates to:
  /// **'Work list only. No bounty is shown here — see your Wallet.'**
  String get shopsNoMoneyNotice;

  /// No description provided for @mapTitle.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapTitle;

  /// No description provided for @mapStripOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline map · cached {date}'**
  String mapStripOffline(Object date);

  /// No description provided for @mapStripOnline.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapStripOnline;

  /// No description provided for @mapRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get mapRefresh;

  /// No description provided for @mapRefreshOnline.
  ///
  /// In en, this message translates to:
  /// **'Downloading map areas · {percent}%'**
  String mapRefreshOnline(Object percent);

  /// No description provided for @mapRefreshTile.
  ///
  /// In en, this message translates to:
  /// **'Tile {done} of {total}'**
  String mapRefreshTile(Object done, Object total);

  /// No description provided for @mapRefreshVector.
  ///
  /// In en, this message translates to:
  /// **'Fetching vectors…'**
  String get mapRefreshVector;

  /// No description provided for @mapRefreshBoundary.
  ///
  /// In en, this message translates to:
  /// **'Dei-Dei boundary…'**
  String get mapRefreshBoundary;

  /// No description provided for @mapRefreshSync.
  ///
  /// In en, this message translates to:
  /// **'Syncing tile vectors…'**
  String get mapRefreshSync;

  /// No description provided for @mapCachedPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% cached'**
  String mapCachedPercent(Object percent);

  /// No description provided for @mapNearbyCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 shop near you} other{{count} shops near you}}'**
  String mapNearbyCount(num count);

  /// No description provided for @mapRadiusActive.
  ///
  /// In en, this message translates to:
  /// **'{radius} active'**
  String mapRadiusActive(Object radius);

  /// No description provided for @mapFilterVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get mapFilterVerified;

  /// No description provided for @mapFilterMine.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get mapFilterMine;

  /// No description provided for @mapFilterLeads.
  ///
  /// In en, this message translates to:
  /// **'Leads'**
  String get mapFilterLeads;

  /// No description provided for @mapFilterRadius.
  ///
  /// In en, this message translates to:
  /// **'Filter radius'**
  String get mapFilterRadius;

  /// No description provided for @mapCachedOnly.
  ///
  /// In en, this message translates to:
  /// **'Cached areas only. Showing {shown} of {total} shops in the cached region.'**
  String mapCachedOnly(Object shown, Object total);

  /// No description provided for @mapStartCaptureHere.
  ///
  /// In en, this message translates to:
  /// **'Start capture from here'**
  String get mapStartCaptureHere;

  /// No description provided for @mapOutsideCachedTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re outside the cached map area'**
  String get mapOutsideCachedTitle;

  /// No description provided for @mapOutsideCachedBody.
  ///
  /// In en, this message translates to:
  /// **'Shops here won\'t load until you\'re back in {areas}.'**
  String mapOutsideCachedBody(Object areas);

  /// No description provided for @mapOutsideCachedEdge.
  ///
  /// In en, this message translates to:
  /// **'{area} cache edge'**
  String mapOutsideCachedEdge(Object area);

  /// No description provided for @mapOutsideCachedNoVectors.
  ///
  /// In en, this message translates to:
  /// **'No cached vector data'**
  String get mapOutsideCachedNoVectors;

  /// No description provided for @mapDownloadedAreas.
  ///
  /// In en, this message translates to:
  /// **'Downloaded areas: {areas} · {size}'**
  String mapDownloadedAreas(Object areas, Object size);

  /// No description provided for @mapDownloadThisArea.
  ///
  /// In en, this message translates to:
  /// **'Download this area'**
  String get mapDownloadThisArea;

  /// No description provided for @mapNeedsConnection.
  ///
  /// In en, this message translates to:
  /// **'Needs an active data connection.'**
  String get mapNeedsConnection;

  /// No description provided for @mapMyLocation.
  ///
  /// In en, this message translates to:
  /// **'My location'**
  String get mapMyLocation;

  /// No description provided for @mapZoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get mapZoomIn;

  /// No description provided for @mapZoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get mapZoomOut;

  /// No description provided for @mapCentre.
  ///
  /// In en, this message translates to:
  /// **'Centre on my location'**
  String get mapCentre;

  /// No description provided for @mapShopMeta.
  ///
  /// In en, this message translates to:
  /// **'{zone} · Line {line} · {distance}'**
  String mapShopMeta(Object distance, Object line, Object zone);

  /// No description provided for @mapAtYourLocation.
  ///
  /// In en, this message translates to:
  /// **'at your location'**
  String get mapAtYourLocation;

  /// No description provided for @mapCapturedAt.
  ///
  /// In en, this message translates to:
  /// **'Captured {date} · {reference}'**
  String mapCapturedAt(Object date, Object reference);

  /// No description provided for @mapLeadStatus.
  ///
  /// In en, this message translates to:
  /// **'Lead'**
  String get mapLeadStatus;

  /// No description provided for @mapOpensShop.
  ///
  /// In en, this message translates to:
  /// **'Open {shop} on the map'**
  String mapOpensShop(Object shop);

  /// No description provided for @mapLegend.
  ///
  /// In en, this message translates to:
  /// **'Map legend'**
  String get mapLegend;

  /// No description provided for @mapRadius500m.
  ///
  /// In en, this message translates to:
  /// **'500 m'**
  String get mapRadius500m;

  /// No description provided for @mapRadius1km.
  ///
  /// In en, this message translates to:
  /// **'1 km'**
  String get mapRadius1km;

  /// No description provided for @mapRadius2km.
  ///
  /// In en, this message translates to:
  /// **'2 km'**
  String get mapRadius2km;

  /// No description provided for @mapRadius5km.
  ///
  /// In en, this message translates to:
  /// **'5 km'**
  String get mapRadius5km;

  /// No description provided for @mapLegendVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get mapLegendVerified;

  /// No description provided for @mapLegendMine.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get mapLegendMine;

  /// No description provided for @mapLegendLeads.
  ///
  /// In en, this message translates to:
  /// **'Leads'**
  String get mapLegendLeads;

  /// No description provided for @syncDiscardFailedConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discarding {count, plural, =1{1 failed submission} other{{count} failed submissions}}. This cannot be undone.'**
  String syncDiscardFailedConfirm(num count);

  /// No description provided for @syncDiscardFailedAction.
  ///
  /// In en, this message translates to:
  /// **'Discard them'**
  String get syncDiscardFailedAction;

  /// No description provided for @bountyLabel.
  ///
  /// In en, this message translates to:
  /// **'BOUNTY'**
  String get bountyLabel;

  /// No description provided for @bountyStatePending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bountyStatePending;

  /// No description provided for @bountyStateVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get bountyStateVerified;

  /// No description provided for @bountyStateRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get bountyStateRejected;

  /// No description provided for @bountyAwaitingHeadline.
  ///
  /// In en, this message translates to:
  /// **'Pending verification'**
  String get bountyAwaitingHeadline;

  /// No description provided for @bountyVerifiedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get bountyVerifiedHeadline;

  /// No description provided for @bountyRejectedHeadline.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get bountyRejectedHeadline;

  /// No description provided for @bountyNotePending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get bountyNotePending;

  /// No description provided for @bountyNoteApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved {date}'**
  String bountyNoteApproved(Object date);

  /// No description provided for @bountyNoteNotPayable.
  ///
  /// In en, this message translates to:
  /// **'Not payable'**
  String get bountyNoteNotPayable;

  /// No description provided for @bountyVerifiedNote.
  ///
  /// In en, this message translates to:
  /// **'Verified and included in the {run} payout run'**
  String bountyVerifiedNote(Object run);

  /// No description provided for @bountySmsNote.
  ///
  /// In en, this message translates to:
  /// **'You\'ll get an SMS when {amount} is sent to {bank}.'**
  String bountySmsNote(Object amount, Object bank);

  /// No description provided for @bountyReviewerFeedback.
  ///
  /// In en, this message translates to:
  /// **'REVIEWER FEEDBACK'**
  String get bountyReviewerFeedback;

  /// No description provided for @bountyReviewerLine.
  ///
  /// In en, this message translates to:
  /// **'Rejected by {reviewer} · {date}'**
  String bountyReviewerLine(Object date, Object reviewer);

  /// No description provided for @bountyReshootCta.
  ///
  /// In en, this message translates to:
  /// **'Reshoot to claim your bounty'**
  String get bountyReshootCta;

  /// No description provided for @bountyAuditTimeline.
  ///
  /// In en, this message translates to:
  /// **'Audit timeline'**
  String get bountyAuditTimeline;

  /// No description provided for @bountyLabelAssets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get bountyLabelAssets;

  /// No description provided for @bountyLabelMedia.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get bountyLabelMedia;

  /// No description provided for @bountyLabelSubmittedBy.
  ///
  /// In en, this message translates to:
  /// **'Submitted by'**
  String get bountyLabelSubmittedBy;

  /// No description provided for @bountyViewSubmission.
  ///
  /// In en, this message translates to:
  /// **'View submission'**
  String get bountyViewSubmission;

  /// No description provided for @bountyViewInQueue.
  ///
  /// In en, this message translates to:
  /// **'View in queue'**
  String get bountyViewInQueue;

  /// No description provided for @bountyResubmitNote.
  ///
  /// In en, this message translates to:
  /// **'Resubmitting creates a new submission ({reference}). Your original stays on record.'**
  String bountyResubmitNote(Object reference);

  /// No description provided for @bountyReshootResubmit.
  ///
  /// In en, this message translates to:
  /// **'Reshoot & resubmit'**
  String get bountyReshootResubmit;

  /// No description provided for @bountyDiscardSubmission.
  ///
  /// In en, this message translates to:
  /// **'Discard submission'**
  String get bountyDiscardSubmission;

  /// No description provided for @bountyTimelineSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get bountyTimelineSubmitted;

  /// No description provided for @bountyTimelineQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued and uploaded'**
  String get bountyTimelineQueued;

  /// No description provided for @bountyTimelineReview.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get bountyTimelineReview;

  /// No description provided for @bountyTimelineVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get bountyTimelineVerified;

  /// No description provided for @bountyTimelinePaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get bountyTimelinePaid;

  /// No description provided for @bountyTimelineRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get bountyTimelineRejected;

  /// No description provided for @bountyTimelineNotApplicable.
  ///
  /// In en, this message translates to:
  /// **'Not applicable'**
  String get bountyTimelineNotApplicable;

  /// No description provided for @bountyTimelineForfeited.
  ///
  /// In en, this message translates to:
  /// **'Bounty forfeited'**
  String get bountyTimelineForfeited;

  /// No description provided for @bountyTimelineWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting on a decision'**
  String get bountyTimelineWaiting;

  /// Title of the agent bounty wallet.
  ///
  /// In en, this message translates to:
  /// **'Bounty wallet'**
  String get walletTitle;

  /// Shown when the wallet, profile, or bounty request fails.
  ///
  /// In en, this message translates to:
  /// **'This could not be loaded.'**
  String get walletLoadFailed;

  /// No description provided for @walletAvailableLabel.
  ///
  /// In en, this message translates to:
  /// **'Available to withdraw'**
  String get walletAvailableLabel;

  /// No description provided for @walletPendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending verification'**
  String get walletPendingLabel;

  /// No description provided for @walletPaidThisYear.
  ///
  /// In en, this message translates to:
  /// **'Paid this year'**
  String get walletPaidThisYear;

  /// No description provided for @walletWithdrawToBank.
  ///
  /// In en, this message translates to:
  /// **'Withdraw to bank'**
  String get walletWithdrawToBank;

  /// No description provided for @walletLastSixWeeks.
  ///
  /// In en, this message translates to:
  /// **'Last 6 weeks'**
  String get walletLastSixWeeks;

  /// No description provided for @walletPreviousPeriod.
  ///
  /// In en, this message translates to:
  /// **'Last 6 weeks'**
  String get walletPreviousPeriod;

  /// No description provided for @walletEarnedOver.
  ///
  /// In en, this message translates to:
  /// **'{total} earned over {period}'**
  String walletEarnedOver(Object period, Object total);

  /// No description provided for @walletAverage.
  ///
  /// In en, this message translates to:
  /// **'Avg {amount}'**
  String walletAverage(Object amount);

  /// No description provided for @walletActivePace.
  ///
  /// In en, this message translates to:
  /// **'Active pace'**
  String get walletActivePace;

  /// No description provided for @walletPayoutHistory.
  ///
  /// In en, this message translates to:
  /// **'Payout history'**
  String get walletPayoutHistory;

  /// No description provided for @walletPayoutSchedule.
  ///
  /// In en, this message translates to:
  /// **'Mondays @ 09:00'**
  String get walletPayoutSchedule;

  /// No description provided for @walletNextRun.
  ///
  /// In en, this message translates to:
  /// **'Next payout schedule: {run}'**
  String walletNextRun(Object run);

  /// No description provided for @walletRunOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get walletRunOpen;

  /// No description provided for @walletRunPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get walletRunPaid;

  /// No description provided for @walletExpected.
  ///
  /// In en, this message translates to:
  /// **'{amount} expected if all {count} are verified.'**
  String walletExpected(Object amount, Object count);

  /// No description provided for @walletZeroTitle.
  ///
  /// In en, this message translates to:
  /// **'No verified bounties to withdraw yet'**
  String get walletZeroTitle;

  /// No description provided for @walletZeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No bounties yet'**
  String get walletZeroSubtitle;

  /// No description provided for @walletZeroBody.
  ///
  /// In en, this message translates to:
  /// **'Earn {amount} each time a shop you map is verified.'**
  String walletZeroBody(Object amount);

  /// No description provided for @walletZeroCta.
  ///
  /// In en, this message translates to:
  /// **'Start capturing'**
  String get walletZeroCta;

  /// No description provided for @walletZeroBenchmark.
  ///
  /// In en, this message translates to:
  /// **'Average agent earns {amount} in their first 6 weeks.'**
  String walletZeroBenchmark(Object amount);

  /// No description provided for @walletNoRunsYet.
  ///
  /// In en, this message translates to:
  /// **'No payout runs yet'**
  String get walletNoRunsYet;

  /// No description provided for @walletMinimumWarning.
  ///
  /// In en, this message translates to:
  /// **'Minimum withdrawal is {amount}. Enter an amount to continue.'**
  String walletMinimumWarning(Object amount);

  /// No description provided for @walletAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'WITHDRAWAL AMOUNT'**
  String get walletAmountLabel;

  /// No description provided for @walletMaxAmount.
  ///
  /// In en, this message translates to:
  /// **'MAX {amount}'**
  String walletMaxAmount(Object amount);

  /// No description provided for @walletVerificationTakesADay.
  ///
  /// In en, this message translates to:
  /// **'Verification usually takes 24 hours. Pending bounties can\'t be withdrawn early.'**
  String get walletVerificationTakesADay;

  /// No description provided for @walletMinimumAmount.
  ///
  /// In en, this message translates to:
  /// **'₦10,000'**
  String get walletMinimumAmount;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileVerifiedBadge.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get profileVerifiedBadge;

  /// No description provided for @profileAgentKind.
  ///
  /// In en, this message translates to:
  /// **'Field agent'**
  String get profileAgentKind;

  /// No description provided for @profileSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileSectionAccount;

  /// No description provided for @profileAgentRole.
  ///
  /// In en, this message translates to:
  /// **'Field Agent · {id}'**
  String profileAgentRole(Object id);

  /// No description provided for @profileTenure.
  ///
  /// In en, this message translates to:
  /// **'{tenure} · {submissions} submissions · {verified} verified'**
  String profileTenure(Object submissions, Object tenure, Object verified);

  /// No description provided for @profileTenureYears.
  ///
  /// In en, this message translates to:
  /// **'Agent since Mar 2026'**
  String get profileTenureYears;

  /// No description provided for @profileSubmissions.
  ///
  /// In en, this message translates to:
  /// **'61 submissions'**
  String get profileSubmissions;

  /// No description provided for @profileVerified.
  ///
  /// In en, this message translates to:
  /// **'54 verified'**
  String get profileVerified;

  /// No description provided for @profileSectionPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profileSectionPreferences;

  /// No description provided for @profileSectionWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get profileSectionWork;

  /// No description provided for @profileSectionSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get profileSectionSupport;

  /// No description provided for @profileSectionThisDevice.
  ///
  /// In en, this message translates to:
  /// **'This device'**
  String get profileSectionThisDevice;

  /// No description provided for @profileSectionOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get profileSectionOffline;

  /// No description provided for @profileAssignedMarkets.
  ///
  /// In en, this message translates to:
  /// **'Assigned markets'**
  String get profileAssignedMarkets;

  /// No description provided for @profileRowLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileRowLanguage;

  /// No description provided for @profileRowNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileRowNotifications;

  /// No description provided for @profileRowSmsOnly.
  ///
  /// In en, this message translates to:
  /// **'SMS only'**
  String get profileRowSmsOnly;

  /// Profile notifications value when SMS and push are both on.
  ///
  /// In en, this message translates to:
  /// **'SMS and push'**
  String get profileNotificationsSmsAndPush;

  /// Profile notifications value when no channel is on.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get profileNotificationsOff;

  /// No description provided for @profileRowSupportPhone.
  ///
  /// In en, this message translates to:
  /// **'+234 803 441 2290'**
  String get profileRowSupportPhone;

  /// No description provided for @profileRowStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get profileRowStorage;

  /// No description provided for @profileStorageFree.
  ///
  /// In en, this message translates to:
  /// **'2.1 GB free'**
  String get profileStorageFree;

  /// No description provided for @profileRowModel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get profileRowModel;

  /// No description provided for @profileRowAndroidVersion.
  ///
  /// In en, this message translates to:
  /// **'Android version'**
  String get profileRowAndroidVersion;

  /// No description provided for @profileRowAppVersion.
  ///
  /// In en, this message translates to:
  /// **'App version'**
  String get profileRowAppVersion;

  /// No description provided for @profileAppVersion.
  ///
  /// In en, this message translates to:
  /// **'2.4.1 (build 118)'**
  String get profileAppVersion;

  /// No description provided for @profileRowOfflineCapture.
  ///
  /// In en, this message translates to:
  /// **'Offline capture'**
  String get profileRowOfflineCapture;

  /// No description provided for @profileRowAllowAlways.
  ///
  /// In en, this message translates to:
  /// **'Always allow'**
  String get profileRowAllowAlways;

  /// No description provided for @profileInstallTitle.
  ///
  /// In en, this message translates to:
  /// **'Add GCC to your home screen'**
  String get profileInstallTitle;

  /// No description provided for @profileInstallBody.
  ///
  /// In en, this message translates to:
  /// **'So it opens without data and keeps working in the market.'**
  String get profileInstallBody;

  /// No description provided for @profileInstallCta.
  ///
  /// In en, this message translates to:
  /// **'Add to home screen'**
  String get profileInstallCta;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileSignOut;

  /// No description provided for @profileClearAction.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get profileClearAction;

  /// No description provided for @profileDeviceModelValue.
  ///
  /// In en, this message translates to:
  /// **'Samsung Galaxy A12'**
  String get profileDeviceModelValue;

  /// No description provided for @profileAndroidVersionValue.
  ///
  /// In en, this message translates to:
  /// **'Android 12'**
  String get profileAndroidVersionValue;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsChannelSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get notificationsChannelSms;

  /// No description provided for @notificationsChannelPush.
  ///
  /// In en, this message translates to:
  /// **'Push'**
  String get notificationsChannelPush;

  /// No description provided for @notificationsChannelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get notificationsChannelEmail;

  /// No description provided for @notificationsLastSent.
  ///
  /// In en, this message translates to:
  /// **'Last SMS sent'**
  String get notificationsLastSent;

  /// No description provided for @notificationsDelivered.
  ///
  /// In en, this message translates to:
  /// **'delivered'**
  String get notificationsDelivered;

  /// No description provided for @notificationsNotDelivered.
  ///
  /// In en, this message translates to:
  /// **'not delivered'**
  String get notificationsNotDelivered;

  /// No description provided for @bountyNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Submission not found'**
  String get bountyNotFoundTitle;

  /// No description provided for @bountyNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'This app has no record of {reference}. It may have been submitted from another device, or discarded.'**
  String bountyNotFoundBody(Object reference);

  /// No description provided for @bountyTitle.
  ///
  /// In en, this message translates to:
  /// **'Bounty status'**
  String get bountyTitle;

  /// No description provided for @profileUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'No profile on this device'**
  String get profileUnavailableTitle;

  /// No description provided for @profileUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in to see your agent details, markets and preferences.'**
  String get profileUnavailableBody;

  /// No description provided for @biometricUnlockTitleFace.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Face ID'**
  String get biometricUnlockTitleFace;

  /// No description provided for @biometricUnlockTitleFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Unlock with your fingerprint'**
  String get biometricUnlockTitleFingerprint;

  /// No description provided for @biometricUnlockTitleGeneric.
  ///
  /// In en, this message translates to:
  /// **'Unlock this device'**
  String get biometricUnlockTitleGeneric;

  /// No description provided for @biometricUnlockAction.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get biometricUnlockAction;

  /// No description provided for @biometricUseCode.
  ///
  /// In en, this message translates to:
  /// **'Use verification code instead'**
  String get biometricUseCode;

  /// No description provided for @biometricEnrollTitleFace.
  ///
  /// In en, this message translates to:
  /// **'Unlock GCC with Face ID on this device?'**
  String get biometricEnrollTitleFace;

  /// No description provided for @biometricEnrollTitleFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Unlock GCC with your fingerprint on this device?'**
  String get biometricEnrollTitleFingerprint;

  /// No description provided for @biometricEnrollBody.
  ///
  /// In en, this message translates to:
  /// **'Your sign-in stays on this device. GCC asks for the biometric when you open the app again.'**
  String get biometricEnrollBody;

  /// No description provided for @biometricEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get biometricEnable;

  /// No description provided for @biometricNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get biometricNotNow;

  /// No description provided for @biometricProfileLabel.
  ///
  /// In en, this message translates to:
  /// **'Unlock with biometrics'**
  String get biometricProfileLabel;

  /// No description provided for @biometricMethodFace.
  ///
  /// In en, this message translates to:
  /// **'Face ID'**
  String get biometricMethodFace;

  /// No description provided for @biometricMethodFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint'**
  String get biometricMethodFingerprint;

  /// No description provided for @biometricMethodIris.
  ///
  /// In en, this message translates to:
  /// **'Iris'**
  String get biometricMethodIris;

  /// No description provided for @biometricMethodGeneric.
  ///
  /// In en, this message translates to:
  /// **'Biometrics'**
  String get biometricMethodGeneric;

  /// No description provided for @biometricUnavailableWeb.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock is not available in the browser.'**
  String get biometricUnavailableWeb;

  /// No description provided for @biometricUnavailableHardware.
  ///
  /// In en, this message translates to:
  /// **'This device has no biometric sensor.'**
  String get biometricUnavailableHardware;

  /// No description provided for @biometricUnavailableNoneEnrolled.
  ///
  /// In en, this message translates to:
  /// **'Set up a fingerprint or Face ID in the device settings first.'**
  String get biometricUnavailableNoneEnrolled;

  /// No description provided for @biometricUnavailableLockout.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Use a verification code, or try again later.'**
  String get biometricUnavailableLockout;

  /// No description provided for @biometricEnrollmentLostTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock was reset'**
  String get biometricEnrollmentLostTitle;

  /// No description provided for @biometricEnrollmentLost.
  ///
  /// In en, this message translates to:
  /// **'The device biometric changed. Sign in with a verification code to turn it back on.'**
  String get biometricEnrollmentLost;

  /// No description provided for @biometricGenericFailure.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock failed. Try again, or use a verification code.'**
  String get biometricGenericFailure;

  /// No description provided for @biometricSignInFirst.
  ///
  /// In en, this message translates to:
  /// **'Use a verification code to sign in.'**
  String get biometricSignInFirst;

  /// No description provided for @catalogTitle.
  ///
  /// In en, this message translates to:
  /// **'My catalog'**
  String get catalogTitle;

  /// No description provided for @catalogAddAsset.
  ///
  /// In en, this message translates to:
  /// **'Add asset'**
  String get catalogAddAsset;

  /// No description provided for @catalogKindEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment ({count})'**
  String catalogKindEquipment(int count);

  /// No description provided for @catalogKindBulk.
  ///
  /// In en, this message translates to:
  /// **'Bulk goods ({count})'**
  String catalogKindBulk(int count);

  /// No description provided for @catalogFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All ({count})'**
  String catalogFilterAll(int count);

  /// No description provided for @catalogFilterReady.
  ///
  /// In en, this message translates to:
  /// **'Ready ({count})'**
  String catalogFilterReady(int count);

  /// No description provided for @catalogFilterRented.
  ///
  /// In en, this message translates to:
  /// **'Rented out ({count})'**
  String catalogFilterRented(int count);

  /// No description provided for @catalogFilterMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance ({count})'**
  String catalogFilterMaintenance(int count);

  /// No description provided for @catalogFilterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending verification ({count})'**
  String catalogFilterPending(int count);

  /// No description provided for @catalogPerDay.
  ///
  /// In en, this message translates to:
  /// **'per day'**
  String get catalogPerDay;

  /// No description provided for @catalogCautionDeposit.
  ///
  /// In en, this message translates to:
  /// **'caution deposit'**
  String get catalogCautionDeposit;

  /// No description provided for @catalogStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for work'**
  String get catalogStatusReady;

  /// No description provided for @catalogStatusRented.
  ///
  /// In en, this message translates to:
  /// **'Rented out'**
  String get catalogStatusRented;

  /// No description provided for @catalogStatusMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get catalogStatusMaintenance;

  /// No description provided for @catalogStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get catalogStatusPending;

  /// No description provided for @catalogPendingReview.
  ///
  /// In en, this message translates to:
  /// **'Awaiting GCC review — not visible to buyers'**
  String get catalogPendingReview;

  /// No description provided for @catalogPendingNote.
  ///
  /// In en, this message translates to:
  /// **'You can set availability once this is verified.'**
  String get catalogPendingNote;

  /// No description provided for @catalogReturns.
  ///
  /// In en, this message translates to:
  /// **'Returns {when}'**
  String catalogReturns(String when);

  /// No description provided for @catalogLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked while {reference} is active.'**
  String catalogLocked(String reference);

  /// No description provided for @catalogBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Set to In maintenance?'**
  String get catalogBlockedTitle;

  /// No description provided for @catalogBlockedAffected.
  ///
  /// In en, this message translates to:
  /// **'{count} active booking is affected'**
  String catalogBlockedAffected(int count);

  /// No description provided for @catalogBlockedActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get catalogBlockedActive;

  /// No description provided for @catalogSetAfterReturn.
  ///
  /// In en, this message translates to:
  /// **'Set after return'**
  String get catalogSetAfterReturn;

  /// No description provided for @catalogRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get catalogRecommended;

  /// No description provided for @catalogSetAfterReturnDetail.
  ///
  /// In en, this message translates to:
  /// **'Status changes automatically at {when}.'**
  String catalogSetAfterReturnDetail(String when);

  /// No description provided for @catalogSetNow.
  ///
  /// In en, this message translates to:
  /// **'Set now anyway'**
  String get catalogSetNow;

  /// No description provided for @catalogSetNowDetail.
  ///
  /// In en, this message translates to:
  /// **'The machine stays bookable until {until}. Buyers may request it.'**
  String catalogSetNowDetail(String until);

  /// No description provided for @catalogBuyersNotTold.
  ///
  /// In en, this message translates to:
  /// **'Buyers are not told why a machine is unavailable.'**
  String get catalogBuyersNotTold;

  /// No description provided for @catalogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get catalogCancel;

  /// No description provided for @catalogUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get catalogUndo;

  /// No description provided for @catalogUndoToast.
  ///
  /// In en, this message translates to:
  /// **'{reference} set to In maintenance'**
  String catalogUndoToast(String reference);

  /// No description provided for @catalogUndoHint.
  ///
  /// In en, this message translates to:
  /// **'Reversible within 10 seconds'**
  String get catalogUndoHint;

  /// No description provided for @catalogScheduled.
  ///
  /// In en, this message translates to:
  /// **'Set to In maintenance · changes again on {when}'**
  String catalogScheduled(String when);

  /// No description provided for @catalogEmptyBulk.
  ///
  /// In en, this message translates to:
  /// **'No bulk goods in this catalog.'**
  String get catalogEmptyBulk;

  /// No description provided for @catalogEmptyFilter.
  ///
  /// In en, this message translates to:
  /// **'Nothing in this view.'**
  String get catalogEmptyFilter;

  /// No description provided for @requestTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking request'**
  String get requestTitle;

  /// No description provided for @requestReceivedSms.
  ///
  /// In en, this message translates to:
  /// **'You received this by SMS'**
  String get requestReceivedSms;

  /// No description provided for @requestSmsParity.
  ///
  /// In en, this message translates to:
  /// **'Reply 1 to accept or 2 to reject — same effect.'**
  String get requestSmsParity;

  /// No description provided for @requestViewSms.
  ///
  /// In en, this message translates to:
  /// **'View the SMS'**
  String get requestViewSms;

  /// No description provided for @requestSmsTitle.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get requestSmsTitle;

  /// No description provided for @requestReadyInYard.
  ///
  /// In en, this message translates to:
  /// **'Ready in yard'**
  String get requestReadyInYard;

  /// No description provided for @requestCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get requestCall;

  /// No description provided for @requestMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get requestMessage;

  /// No description provided for @requestDates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get requestDates;

  /// No description provided for @requestDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get requestDuration;

  /// No description provided for @requestRentalFee.
  ///
  /// In en, this message translates to:
  /// **'Rental fee'**
  String get requestRentalFee;

  /// No description provided for @requestDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get requestDelivery;

  /// No description provided for @requestYoullReceive.
  ///
  /// In en, this message translates to:
  /// **'You\'ll receive'**
  String get requestYoullReceive;

  /// No description provided for @requestNetEarning.
  ///
  /// In en, this message translates to:
  /// **'Net vendor earning'**
  String get requestNetEarning;

  /// No description provided for @requestEarningNote.
  ///
  /// In en, this message translates to:
  /// **'After GCC\'s 12% commission and delivery. Released to your wallet once you record the check-in condition.'**
  String get requestEarningNote;

  /// No description provided for @requestHoldDeposit.
  ///
  /// In en, this message translates to:
  /// **'You\'ll hold their {amount} deposit until the return is approved'**
  String requestHoldDeposit(String amount);

  /// No description provided for @requestExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Expires in'**
  String get requestExpiresIn;

  /// No description provided for @requestAutoReassigns.
  ///
  /// In en, this message translates to:
  /// **'Auto-reassigns'**
  String get requestAutoReassigns;

  /// No description provided for @requestUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get requestUrgent;

  /// No description provided for @requestExpiresDetail.
  ///
  /// In en, this message translates to:
  /// **'After this, we offer the booking to the next vendor.'**
  String get requestExpiresDetail;

  /// No description provided for @requestReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get requestReject;

  /// No description provided for @requestAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept booking'**
  String get requestAccept;

  /// No description provided for @requestAcceptTitle.
  ///
  /// In en, this message translates to:
  /// **'Accept {reference}?'**
  String requestAcceptTitle(String reference);

  /// No description provided for @requestAcceptBody.
  ///
  /// In en, this message translates to:
  /// **'This confirms collection on {window} from {place}. The lessee is notified by SMS immediately.'**
  String requestAcceptBody(String window, String place);

  /// No description provided for @requestAcceptChangeWindow.
  ///
  /// In en, this message translates to:
  /// **'You can change the collection window after accepting.'**
  String get requestAcceptChangeWindow;

  /// No description provided for @requestCollectionWindow.
  ///
  /// In en, this message translates to:
  /// **'Collection window'**
  String get requestCollectionWindow;

  /// No description provided for @requestDeclineTitle.
  ///
  /// In en, this message translates to:
  /// **'Decline this request'**
  String get requestDeclineTitle;

  /// No description provided for @requestDeclineReason.
  ///
  /// In en, this message translates to:
  /// **'Select a reason'**
  String get requestDeclineReason;

  /// No description provided for @requestReasonUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Asset unavailable'**
  String get requestReasonUnavailable;

  /// No description provided for @requestReasonRate.
  ///
  /// In en, this message translates to:
  /// **'Rate needs review'**
  String get requestReasonRate;

  /// No description provided for @requestReasonArea.
  ///
  /// In en, this message translates to:
  /// **'Outside my delivery area'**
  String get requestReasonArea;

  /// No description provided for @requestReasonMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Needs maintenance'**
  String get requestReasonMaintenance;

  /// No description provided for @requestReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get requestReasonOther;

  /// No description provided for @requestReasonNote.
  ///
  /// In en, this message translates to:
  /// **'Reason note'**
  String get requestReasonNote;

  /// No description provided for @requestReasonNoteHint.
  ///
  /// In en, this message translates to:
  /// **'The vendor sees this. Keep it short and factual.'**
  String get requestReasonNoteHint;

  /// No description provided for @requestDeclineNotice.
  ///
  /// In en, this message translates to:
  /// **'Declining offers the booking to the next vendor. The lessee isn\'t told who declined.'**
  String get requestDeclineNotice;

  /// No description provided for @requestDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline request'**
  String get requestDecline;

  /// No description provided for @requestChooseReason.
  ///
  /// In en, this message translates to:
  /// **'Choose a reason to decline'**
  String get requestChooseReason;

  /// No description provided for @requestAcceptedSms.
  ///
  /// In en, this message translates to:
  /// **'Accepted by SMS'**
  String get requestAcceptedSms;

  /// No description provided for @requestAcceptedSmsBody.
  ///
  /// In en, this message translates to:
  /// **'You accepted this from your feature phone. Nothing else to do.'**
  String get requestAcceptedSmsBody;

  /// No description provided for @requestAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get requestAccepted;

  /// No description provided for @requestAcceptedAt.
  ///
  /// In en, this message translates to:
  /// **'Accepted {when}'**
  String requestAcceptedAt(String when);

  /// No description provided for @requestCollectionConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Collection confirmed for {window}'**
  String requestCollectionConfirmed(String window);

  /// No description provided for @requestAuditTitle.
  ///
  /// In en, this message translates to:
  /// **'Arbitration audit trail'**
  String get requestAuditTitle;

  /// No description provided for @requestAuditReceived.
  ///
  /// In en, this message translates to:
  /// **'Request received'**
  String get requestAuditReceived;

  /// No description provided for @requestAuditBySms.
  ///
  /// In en, this message translates to:
  /// **'By SMS'**
  String get requestAuditBySms;

  /// No description provided for @requestAuditAcceptedSms.
  ///
  /// In en, this message translates to:
  /// **'Accepted by SMS'**
  String get requestAuditAcceptedSms;

  /// No description provided for @requestAuditReply.
  ///
  /// In en, this message translates to:
  /// **'Reply \"1\"'**
  String get requestAuditReply;

  /// No description provided for @requestAuditCollection.
  ///
  /// In en, this message translates to:
  /// **'Collection at yard'**
  String get requestAuditCollection;

  /// No description provided for @requestAuditPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get requestAuditPending;

  /// No description provided for @requestEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get requestEquipment;

  /// No description provided for @requestNetPayout.
  ///
  /// In en, this message translates to:
  /// **'Net payout'**
  String get requestNetPayout;

  /// No description provided for @requestHeldDeposit.
  ///
  /// In en, this message translates to:
  /// **'Held deposit'**
  String get requestHeldDeposit;

  /// No description provided for @requestRecordCondition.
  ///
  /// In en, this message translates to:
  /// **'Record collection condition'**
  String get requestRecordCondition;

  /// No description provided for @requestDeclineAnyway.
  ///
  /// In en, this message translates to:
  /// **'Decline anyway'**
  String get requestDeclineAnyway;

  /// No description provided for @requestSmsReverse.
  ///
  /// In en, this message translates to:
  /// **'Accepting by SMS can be reversed up to 1 hour before collection.'**
  String get requestSmsReverse;

  /// No description provided for @requestDeclinedTitle.
  ///
  /// In en, this message translates to:
  /// **'Request declined'**
  String get requestDeclinedTitle;

  /// No description provided for @requestEmpty.
  ///
  /// In en, this message translates to:
  /// **'No booking requests are waiting.'**
  String get requestEmpty;

  /// No description provided for @editAutosaved.
  ///
  /// In en, this message translates to:
  /// **'Autosaved {when}'**
  String editAutosaved(String when);

  /// No description provided for @editAutosavedOneIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Autosaved {when} · 1 field incomplete'**
  String editAutosavedOneIncomplete(String when);

  /// No description provided for @editAutosavedIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Autosaved {when} · {count} fields incomplete'**
  String editAutosavedIncomplete(String when, int count);

  /// No description provided for @editOneFieldNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'1 field needs attention'**
  String get editOneFieldNeedsAttention;

  /// No description provided for @editFieldsNeedAttention.
  ///
  /// In en, this message translates to:
  /// **'{count} fields need attention'**
  String editFieldsNeedAttention(int count);

  /// No description provided for @editHowYouCharge.
  ///
  /// In en, this message translates to:
  /// **'How do you charge?'**
  String get editHowYouCharge;

  /// No description provided for @editHourly.
  ///
  /// In en, this message translates to:
  /// **'Hourly'**
  String get editHourly;

  /// No description provided for @editDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get editDaily;

  /// No description provided for @editWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get editWeekly;

  /// No description provided for @editProject.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get editProject;

  /// No description provided for @editRatePerDay.
  ///
  /// In en, this message translates to:
  /// **'Rate per day'**
  String get editRatePerDay;

  /// No description provided for @editPerDay.
  ///
  /// In en, this message translates to:
  /// **'per day'**
  String get editPerDay;

  /// No description provided for @editRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get editRequired;

  /// No description provided for @editRateError.
  ///
  /// In en, this message translates to:
  /// **'Enter a rate per day'**
  String get editRateError;

  /// No description provided for @editProjectRate.
  ///
  /// In en, this message translates to:
  /// **'Project price'**
  String get editProjectRate;

  /// No description provided for @editProjectError.
  ///
  /// In en, this message translates to:
  /// **'Enter a project price'**
  String get editProjectError;

  /// No description provided for @editProjectHelper.
  ///
  /// In en, this message translates to:
  /// **'A project price replaces the daily rate for this booking.'**
  String get editProjectHelper;

  /// No description provided for @editCommission.
  ///
  /// In en, this message translates to:
  /// **'Buyer pays this plus 12% GCC commission.'**
  String get editCommission;

  /// No description provided for @editWeeklySet.
  ///
  /// In en, this message translates to:
  /// **'Weekly rate is set for you at 5.6 × daily ({amount}).'**
  String editWeeklySet(String amount);

  /// No description provided for @editHourlySet.
  ///
  /// In en, this message translates to:
  /// **'Hourly rate is set for you at daily ÷ 8 ({amount}).'**
  String editHourlySet(String amount);

  /// No description provided for @editDeposit.
  ///
  /// In en, this message translates to:
  /// **'Caution deposit'**
  String get editDeposit;

  /// No description provided for @editDepositSuffix.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get editDepositSuffix;

  /// No description provided for @editDepositHeld.
  ///
  /// In en, this message translates to:
  /// **'Held by GCC as a locked deposit. Refunded to the buyer after the return condition is approved.'**
  String get editDepositHeld;

  /// No description provided for @editDepositError.
  ///
  /// In en, this message translates to:
  /// **'Enter a refundable deposit — buyers see this and it must be accurate'**
  String get editDepositError;

  /// No description provided for @editAssignOperator.
  ///
  /// In en, this message translates to:
  /// **'Assign operator by default'**
  String get editAssignOperator;

  /// No description provided for @editOperatorFee.
  ///
  /// In en, this message translates to:
  /// **'Operator fee'**
  String get editOperatorFee;

  /// No description provided for @editExampleTitle.
  ///
  /// In en, this message translates to:
  /// **'Example · {days}-day booking'**
  String editExampleTitle(int days);

  /// No description provided for @editProjectExample.
  ///
  /// In en, this message translates to:
  /// **'Example · project booking'**
  String get editProjectExample;

  /// No description provided for @editRentalFee.
  ///
  /// In en, this message translates to:
  /// **'Rental fee'**
  String get editRentalFee;

  /// No description provided for @editRentalDetail.
  ///
  /// In en, this message translates to:
  /// **'({days} days × {rate})'**
  String editRentalDetail(int days, String rate);

  /// No description provided for @editDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get editDelivery;

  /// No description provided for @editInsurance.
  ///
  /// In en, this message translates to:
  /// **'Micro-insurance'**
  String get editInsurance;

  /// No description provided for @editInsuranceDetail.
  ///
  /// In en, this message translates to:
  /// **'(1.5%/day)'**
  String get editInsuranceDetail;

  /// No description provided for @editBuyerPays.
  ///
  /// In en, this message translates to:
  /// **'Buyer pays'**
  String get editBuyerPays;

  /// No description provided for @editBeforeRefund.
  ///
  /// In en, this message translates to:
  /// **'Before the refund'**
  String get editBeforeRefund;

  /// No description provided for @editWalletLanding.
  ///
  /// In en, this message translates to:
  /// **'After you approve the return, the deposit goes back to them and {amount} lands in your wallet.'**
  String editWalletLanding(String amount);

  /// No description provided for @editPausedTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a rate and deposit to see what buyers will pay.'**
  String get editPausedTitle;

  /// No description provided for @editPausedBody.
  ///
  /// In en, this message translates to:
  /// **'Live calculation is paused while required fields are empty.'**
  String get editPausedBody;

  /// No description provided for @editPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos & video'**
  String get editPhotos;

  /// No description provided for @editVideo.
  ///
  /// In en, this message translates to:
  /// **'Condition video · {when}'**
  String editVideo(String when);

  /// No description provided for @editReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get editReplace;

  /// No description provided for @editVideoNote.
  ///
  /// In en, this message translates to:
  /// **'Buyers see the condition video before they book. It is how disputes get settled fairly.'**
  String get editVideoNote;

  /// No description provided for @editDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get editDiscard;

  /// No description provided for @editSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get editSave;

  /// No description provided for @editSaveBlockedOne.
  ///
  /// In en, this message translates to:
  /// **'Fix the highlighted field'**
  String get editSaveBlockedOne;

  /// No description provided for @editSaveBlocked.
  ///
  /// In en, this message translates to:
  /// **'Fix the {count} highlighted fields'**
  String editSaveBlocked(int count);

  /// No description provided for @editMissing.
  ///
  /// In en, this message translates to:
  /// **'This asset is not in the catalog.'**
  String get editMissing;

  /// No description provided for @vendorWalletAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available to withdraw'**
  String get vendorWalletAvailable;

  /// No description provided for @vendorWalletAwaiting.
  ///
  /// In en, this message translates to:
  /// **'Awaiting condition check'**
  String get vendorWalletAwaiting;

  /// No description provided for @vendorWalletAwaitingCaption.
  ///
  /// In en, this message translates to:
  /// **'Released after you approve a return'**
  String get vendorWalletAwaitingCaption;

  /// No description provided for @vendorWalletHeld.
  ///
  /// In en, this message translates to:
  /// **'Held as caution deposits'**
  String get vendorWalletHeld;

  /// No description provided for @vendorWalletHeldCaption.
  ///
  /// In en, this message translates to:
  /// **'Other buyers\' money. Never yours to touch.'**
  String get vendorWalletHeldCaption;

  /// No description provided for @vendorWalletWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw to bank'**
  String get vendorWalletWithdraw;

  /// No description provided for @vendorWalletNothingToWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Nothing available to withdraw yet'**
  String get vendorWalletNothingToWithdraw;

  /// No description provided for @vendorWalletCondition.
  ///
  /// In en, this message translates to:
  /// **'Condition recorded'**
  String get vendorWalletCondition;

  /// No description provided for @vendorWalletCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in recorded'**
  String get vendorWalletCheckIn;

  /// No description provided for @vendorWalletMoney.
  ///
  /// In en, this message translates to:
  /// **'Money to wallet'**
  String get vendorWalletMoney;

  /// No description provided for @vendorWalletPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get vendorWalletPending;

  /// No description provided for @vendorWalletReleases.
  ///
  /// In en, this message translates to:
  /// **'{amount} releases when you record the check-in and the buyer approves it.'**
  String vendorWalletReleases(String amount);

  /// No description provided for @vendorWalletThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get vendorWalletThisWeek;

  /// No description provided for @vendorWalletThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get vendorWalletThisMonth;

  /// No description provided for @vendorWalletThisYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get vendorWalletThisYear;

  /// No description provided for @vendorWalletBookingReleased.
  ///
  /// In en, this message translates to:
  /// **'Booking {reference} released'**
  String vendorWalletBookingReleased(String reference);

  /// No description provided for @vendorWalletDepositHeld.
  ///
  /// In en, this message translates to:
  /// **'Caution deposit held · {reference}'**
  String vendorWalletDepositHeld(String reference);

  /// No description provided for @vendorWalletPayoutSent.
  ///
  /// In en, this message translates to:
  /// **'Payout {reference} sent'**
  String vendorWalletPayoutSent(String reference);

  /// No description provided for @vendorWalletPayoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Payout {reference} failed'**
  String vendorWalletPayoutFailed(String reference);

  /// No description provided for @vendorWalletPayoutFailedBanner.
  ///
  /// In en, this message translates to:
  /// **'Payout {reference} failed · {amount} returned to your balance'**
  String vendorWalletPayoutFailedBanner(String reference, String amount);

  /// No description provided for @vendorWalletPayoutFailedBody.
  ///
  /// In en, this message translates to:
  /// **'{bank} did not respond within 30 seconds. Nothing was lost.'**
  String vendorWalletPayoutFailedBody(String bank);

  /// No description provided for @vendorWalletRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry payout'**
  String get vendorWalletRetry;

  /// No description provided for @vendorWalletRetryNote.
  ///
  /// In en, this message translates to:
  /// **'Failed payouts are retried automatically after 6 hours.'**
  String get vendorWalletRetryNote;

  /// No description provided for @vendorWalletEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get vendorWalletEmptyTitle;

  /// No description provided for @vendorWalletEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Release a booking to move money into your wallet. Releases happen after the buyer approves a return condition.'**
  String get vendorWalletEmptyBody;

  /// No description provided for @vendorWalletViewBookings.
  ///
  /// In en, this message translates to:
  /// **'View my bookings'**
  String get vendorWalletViewBookings;

  /// No description provided for @vendorWithdrawTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get vendorWithdrawTitle;

  /// No description provided for @vendorWithdrawStatus.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal status'**
  String get vendorWithdrawStatus;

  /// No description provided for @vendorWithdrawVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get vendorWithdrawVerified;

  /// No description provided for @vendorWithdrawChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get vendorWithdrawChange;

  /// No description provided for @vendorWithdrawAccountNote.
  ///
  /// In en, this message translates to:
  /// **'Payouts go to the account name on your verified bank record.'**
  String get vendorWithdrawAccountNote;

  /// No description provided for @vendorWithdrawHowMuch.
  ///
  /// In en, this message translates to:
  /// **'How much?'**
  String get vendorWithdrawHowMuch;

  /// No description provided for @vendorWithdrawAvailableOf.
  ///
  /// In en, this message translates to:
  /// **'Available {amount}'**
  String vendorWithdrawAvailableOf(String amount);

  /// No description provided for @vendorWithdrawEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount to withdraw'**
  String get vendorWithdrawEnterAmount;

  /// No description provided for @vendorWithdrawRange.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount between {minimum} and {available}'**
  String vendorWithdrawRange(String minimum, String available);

  /// No description provided for @vendorWithdrawAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get vendorWithdrawAll;

  /// No description provided for @vendorWithdrawAmount.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Amount'**
  String get vendorWithdrawAmount;

  /// No description provided for @vendorWithdrawFee.
  ///
  /// In en, this message translates to:
  /// **'Transfer processing fee'**
  String get vendorWithdrawFee;

  /// No description provided for @vendorWithdrawFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get vendorWithdrawFree;

  /// No description provided for @vendorWithdrawNet.
  ///
  /// In en, this message translates to:
  /// **'Net account credit'**
  String get vendorWithdrawNet;

  /// No description provided for @vendorWithdrawArrives.
  ///
  /// In en, this message translates to:
  /// **'Arrives in {bank}'**
  String vendorWithdrawArrives(String bank);

  /// No description provided for @vendorWithdrawArrivesBody.
  ///
  /// In en, this message translates to:
  /// **'Usually within 2 hours on weekdays. Some clearing runs take longer.'**
  String get vendorWithdrawArrivesBody;

  /// No description provided for @vendorWithdrawOnly.
  ///
  /// In en, this message translates to:
  /// **'Withdrawing available funds only'**
  String get vendorWithdrawOnly;

  /// No description provided for @vendorWithdrawAuditAnd.
  ///
  /// In en, this message translates to:
  /// **'in condition audit and'**
  String get vendorWithdrawAuditAnd;

  /// No description provided for @vendorWithdrawQuarantine.
  ///
  /// In en, this message translates to:
  /// **'caution deposits remain quarantined for other bookings.'**
  String get vendorWithdrawQuarantine;

  /// No description provided for @vendorWithdrawNeedAmount.
  ///
  /// In en, this message translates to:
  /// **'Add an amount to see fees and arrival time.'**
  String get vendorWithdrawNeedAmount;

  /// No description provided for @vendorWithdrawHeldStay.
  ///
  /// In en, this message translates to:
  /// **'Held funds remain quarantined until contract milestones complete.'**
  String get vendorWithdrawHeldStay;

  /// No description provided for @vendorWithdrawCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get vendorWithdrawCancel;

  /// No description provided for @vendorWithdrawAction.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get vendorWithdrawAction;

  /// No description provided for @vendorWithdrawSubmit.
  ///
  /// In en, this message translates to:
  /// **'Withdraw {amount}'**
  String vendorWithdrawSubmit(String amount);

  /// No description provided for @vendorWithdrawContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount to continue'**
  String get vendorWithdrawContinue;

  /// No description provided for @vendorWithdrawOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'{amount} is on its way'**
  String vendorWithdrawOnTheWay(String amount);

  /// No description provided for @vendorWithdrawReference.
  ///
  /// In en, this message translates to:
  /// **'Payout Reference'**
  String get vendorWithdrawReference;

  /// No description provided for @vendorWithdrawDebited.
  ///
  /// In en, this message translates to:
  /// **'Amount debited'**
  String get vendorWithdrawDebited;

  /// No description provided for @vendorWithdrawDispatched.
  ///
  /// In en, this message translates to:
  /// **'Dispatched timestamp'**
  String get vendorWithdrawDispatched;

  /// No description provided for @vendorWithdrawEstimated.
  ///
  /// In en, this message translates to:
  /// **'Estimated bank arrival'**
  String get vendorWithdrawEstimated;

  /// No description provided for @vendorWithdrawAccountMatches.
  ///
  /// In en, this message translates to:
  /// **'Account matches {name}'**
  String vendorWithdrawAccountMatches(String name);

  /// No description provided for @vendorWithdrawChannelClear.
  ///
  /// In en, this message translates to:
  /// **'{bank} settlement channel clear'**
  String vendorWithdrawChannelClear(String bank);

  /// No description provided for @vendorWithdrawLedgerUpdated.
  ///
  /// In en, this message translates to:
  /// **'Vendor balance ledger updated'**
  String get vendorWithdrawLedgerUpdated;

  /// No description provided for @vendorWithdrawRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining Balance'**
  String get vendorWithdrawRemaining;

  /// No description provided for @vendorWithdrawSms.
  ///
  /// In en, this message translates to:
  /// **'You\'ll get an SMS confirmation once clearing settles. Usually within 2 hours.'**
  String get vendorWithdrawSms;

  /// No description provided for @vendorWithdrawTrack.
  ///
  /// In en, this message translates to:
  /// **'Track Settlement'**
  String get vendorWithdrawTrack;

  /// No description provided for @vendorWithdrawBack.
  ///
  /// In en, this message translates to:
  /// **'Back to Wallet Overview'**
  String get vendorWithdrawBack;

  /// No description provided for @vendorProfileVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get vendorProfileVerified;

  /// No description provided for @vendorProfileBoth.
  ///
  /// In en, this message translates to:
  /// **'You\'re signed in as both'**
  String get vendorProfileBoth;

  /// No description provided for @vendorProfileLessee.
  ///
  /// In en, this message translates to:
  /// **'Lessee'**
  String get vendorProfileLessee;

  /// No description provided for @vendorProfileVendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendorProfileVendor;

  /// No description provided for @vendorProfileModeExplanation.
  ///
  /// In en, this message translates to:
  /// **'Switch mode to see bookings you\'re renting, or to manage your yard.'**
  String get vendorProfileModeExplanation;

  /// No description provided for @vendorProfileKeepCatalog.
  ///
  /// In en, this message translates to:
  /// **'Your catalog and availability'**
  String get vendorProfileKeepCatalog;

  /// No description provided for @vendorProfileKeepRequests.
  ///
  /// In en, this message translates to:
  /// **'Booking requests to accept or decline'**
  String get vendorProfileKeepRequests;

  /// No description provided for @vendorProfileKeepVideos.
  ///
  /// In en, this message translates to:
  /// **'Condition videos to record'**
  String get vendorProfileKeepVideos;

  /// No description provided for @vendorProfileWhatChanges.
  ///
  /// In en, this message translates to:
  /// **'What changes?'**
  String get vendorProfileWhatChanges;

  /// No description provided for @vendorProfileBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get vendorProfileBusiness;

  /// No description provided for @vendorProfileAddresses.
  ///
  /// In en, this message translates to:
  /// **'Saved addresses'**
  String get vendorProfileAddresses;

  /// No description provided for @vendorProfilePayout.
  ///
  /// In en, this message translates to:
  /// **'Payout account'**
  String get vendorProfilePayout;

  /// No description provided for @vendorProfileShop.
  ///
  /// In en, this message translates to:
  /// **'Shop profile & location'**
  String get vendorProfileShop;

  /// No description provided for @vendorProfileHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get vendorProfileHelp;

  /// No description provided for @vendorProfileAbout.
  ///
  /// In en, this message translates to:
  /// **'About GCC'**
  String get vendorProfileAbout;

  /// No description provided for @vendorProfileVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String vendorProfileVersion(String version);

  /// No description provided for @vendorProfileUssdEyebrow.
  ///
  /// In en, this message translates to:
  /// **'No data? Use your basic phone'**
  String get vendorProfileUssdEyebrow;

  /// No description provided for @vendorProfileUssdBefore.
  ///
  /// In en, this message translates to:
  /// **'Dial '**
  String get vendorProfileUssdBefore;

  /// No description provided for @vendorProfileUssdAfter.
  ///
  /// In en, this message translates to:
  /// **' to check your balance or withdraw to your bank.'**
  String get vendorProfileUssdAfter;

  /// No description provided for @vendorProfileUssdDetail.
  ///
  /// In en, this message translates to:
  /// **'Works on any phone. No internet needed.'**
  String get vendorProfileUssdDetail;

  /// No description provided for @vendorProfileCopyCode.
  ///
  /// In en, this message translates to:
  /// **'Copy {code}'**
  String vendorProfileCopyCode(String code);

  /// No description provided for @vendorProfileCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied {code}'**
  String vendorProfileCopied(String code);

  /// No description provided for @vendorProfileSwitchTitle.
  ///
  /// In en, this message translates to:
  /// **'Switch to Lessee mode?'**
  String get vendorProfileSwitchTitle;

  /// No description provided for @vendorProfileSwitchBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll see bookings you\'re renting instead of your yard. Your catalog stays exactly as it is — nothing changes.'**
  String get vendorProfileSwitchBody;

  /// No description provided for @vendorProfileSwitchHidden.
  ///
  /// In en, this message translates to:
  /// **'In Lessee mode you won\'t see:'**
  String get vendorProfileSwitchHidden;

  /// No description provided for @vendorProfileSwitchStill.
  ///
  /// In en, this message translates to:
  /// **'You\'ll still see your wallet and payouts.'**
  String get vendorProfileSwitchStill;

  /// No description provided for @vendorProfileSwitchConfirm.
  ///
  /// In en, this message translates to:
  /// **'Switch to Lessee'**
  String get vendorProfileSwitchConfirm;

  /// No description provided for @vendorProfileSwitchStay.
  ///
  /// In en, this message translates to:
  /// **'Stay in Vendor mode'**
  String get vendorProfileSwitchStay;

  /// No description provided for @vendorNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get vendorNoticeTitle;

  /// No description provided for @vendorNoticeMarkRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get vendorNoticeMarkRead;

  /// No description provided for @vendorNoticeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get vendorNoticeAll;

  /// No description provided for @vendorNoticeRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get vendorNoticeRequests;

  /// No description provided for @vendorNoticeMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get vendorNoticeMoney;

  /// No description provided for @vendorNoticeTab.
  ///
  /// In en, this message translates to:
  /// **'{label} ({count})'**
  String vendorNoticeTab(String label, int count);

  /// No description provided for @vendorNoticeSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get vendorNoticeSms;

  /// No description provided for @vendorNoticeUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get vendorNoticeUnread;

  /// No description provided for @vendorNoticeActiveRequests.
  ///
  /// In en, this message translates to:
  /// **'Active requests'**
  String get vendorNoticeActiveRequests;

  /// No description provided for @vendorNoticeAudit.
  ///
  /// In en, this message translates to:
  /// **'Financial audit trail'**
  String get vendorNoticeAudit;

  /// No description provided for @vendorNoticeDecision.
  ///
  /// In en, this message translates to:
  /// **'1 item needs a decision'**
  String get vendorNoticeDecision;

  /// No description provided for @vendorNoticeWindow.
  ///
  /// In en, this message translates to:
  /// **'The damage claim window closes {deadline}.'**
  String vendorNoticeWindow(String deadline);

  /// No description provided for @vendorNoticeSmsBefore.
  ///
  /// In en, this message translates to:
  /// **'You can also respond by SMS. Reply '**
  String get vendorNoticeSmsBefore;

  /// No description provided for @vendorNoticeSmsAccept.
  ///
  /// In en, this message translates to:
  /// **'1'**
  String get vendorNoticeSmsAccept;

  /// No description provided for @vendorNoticeSmsMiddle.
  ///
  /// In en, this message translates to:
  /// **' to accept a booking, '**
  String get vendorNoticeSmsMiddle;

  /// No description provided for @vendorNoticeSmsReject.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get vendorNoticeSmsReject;

  /// No description provided for @vendorNoticeSmsAfter.
  ///
  /// In en, this message translates to:
  /// **' to reject. Damage claims need the app.'**
  String get vendorNoticeSmsAfter;

  /// No description provided for @vendorNoticeReply.
  ///
  /// In en, this message translates to:
  /// **'Reply 1 · accept booking'**
  String get vendorNoticeReply;

  /// No description provided for @vendorNoticeWalletNote.
  ///
  /// In en, this message translates to:
  /// **'Everything about money is also in your wallet statement.'**
  String get vendorNoticeWalletNote;

  /// No description provided for @vendorNoticeOpenWallet.
  ///
  /// In en, this message translates to:
  /// **'Open Wallet ledger'**
  String get vendorNoticeOpenWallet;

  /// No description provided for @marketplaceSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search equipment'**
  String get marketplaceSearchHint;

  /// No description provided for @marketplaceClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get marketplaceClearSearch;

  /// No description provided for @marketplaceRentals.
  ///
  /// In en, this message translates to:
  /// **'Rentals'**
  String get marketplaceRentals;

  /// No description provided for @marketplaceBulk.
  ///
  /// In en, this message translates to:
  /// **'Bulk trade'**
  String get marketplaceBulk;

  /// No description provided for @marketplaceBulkEmpty.
  ///
  /// In en, this message translates to:
  /// **'No bulk goods yet'**
  String get marketplaceBulkEmpty;

  /// No description provided for @marketplaceBulkEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Bulk goods will show here when a yard lists them.'**
  String get marketplaceBulkEmptyBody;

  /// No description provided for @marketplaceRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get marketplaceRecent;

  /// No description provided for @marketplaceClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get marketplaceClearAll;

  /// No description provided for @marketplaceFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get marketplaceFilters;

  /// No description provided for @marketplaceFilterCount.
  ///
  /// In en, this message translates to:
  /// **'Filters ({count})'**
  String marketplaceFilterCount(int count);

  /// No description provided for @marketplaceAvailableNow.
  ///
  /// In en, this message translates to:
  /// **'Available now'**
  String get marketplaceAvailableNow;

  /// No description provided for @marketplaceWithOperator.
  ///
  /// In en, this message translates to:
  /// **'With operator'**
  String get marketplaceWithOperator;

  /// No description provided for @marketplaceResults.
  ///
  /// In en, this message translates to:
  /// **'{count} results'**
  String marketplaceResults(int count);

  /// No description provided for @marketplaceSortRelevance.
  ///
  /// In en, this message translates to:
  /// **'Sort: Relevance'**
  String get marketplaceSortRelevance;

  /// No description provided for @marketplaceEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No equipment matches'**
  String get marketplaceEmptyTitle;

  /// No description provided for @marketplaceEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Nothing for {query} in your {count} active filters.'**
  String marketplaceEmptyBody(String query, int count);

  /// No description provided for @marketplacePopular.
  ///
  /// In en, this message translates to:
  /// **'Popular categories'**
  String get marketplacePopular;

  /// No description provided for @marketplaceMarket.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get marketplaceMarket;

  /// No description provided for @marketplaceAllMarkets.
  ///
  /// In en, this message translates to:
  /// **'All markets'**
  String get marketplaceAllMarkets;

  /// No description provided for @marketplaceNearMe.
  ///
  /// In en, this message translates to:
  /// **'Near me'**
  String get marketplaceNearMe;

  /// No description provided for @marketplaceCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get marketplaceCategories;

  /// No description provided for @marketplaceCategoryCount.
  ///
  /// In en, this message translates to:
  /// **'{name} ({count})'**
  String marketplaceCategoryCount(String name, int count);

  /// No description provided for @marketplaceRate.
  ///
  /// In en, this message translates to:
  /// **'Daily rate'**
  String get marketplaceRate;

  /// No description provided for @marketplaceAnyRate.
  ///
  /// In en, this message translates to:
  /// **'Any rate'**
  String get marketplaceAnyRate;

  /// No description provided for @marketplaceDepositUnder.
  ///
  /// In en, this message translates to:
  /// **'Deposit under {amount}'**
  String marketplaceDepositUnder(String amount);

  /// No description provided for @marketplaceRateDepositConflict.
  ///
  /// In en, this message translates to:
  /// **'Deposit range can\'t be combined with a rate filter.'**
  String get marketplaceRateDepositConflict;

  /// No description provided for @marketplaceShowResults.
  ///
  /// In en, this message translates to:
  /// **'Show {count} results'**
  String marketplaceShowResults(int count);

  /// No description provided for @marketplaceReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get marketplaceReset;

  /// No description provided for @marketplacePerDay.
  ///
  /// In en, this message translates to:
  /// **'per day'**
  String get marketplacePerDay;

  /// No description provided for @marketplaceDeposit.
  ///
  /// In en, this message translates to:
  /// **'{amount} deposit'**
  String marketplaceDeposit(String amount);

  /// No description provided for @marketplaceAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get marketplaceAvailable;

  /// No description provided for @marketplaceInUseUntil.
  ///
  /// In en, this message translates to:
  /// **'In use until {date}'**
  String marketplaceInUseUntil(String date);

  /// No description provided for @marketplaceOutOfService.
  ///
  /// In en, this message translates to:
  /// **'Out of service'**
  String get marketplaceOutOfService;

  /// No description provided for @marketplaceVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified vendor'**
  String get marketplaceVerified;

  /// No description provided for @marketplacePhotos.
  ///
  /// In en, this message translates to:
  /// **'{index} / {count}'**
  String marketplacePhotos(int index, int count);

  /// No description provided for @marketplaceSpecs.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get marketplaceSpecs;

  /// No description provided for @marketplaceSpecCapacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get marketplaceSpecCapacity;

  /// No description provided for @marketplaceSpecFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get marketplaceSpecFuel;

  /// No description provided for @marketplaceSpecYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get marketplaceSpecYear;

  /// No description provided for @marketplaceSpecSerial.
  ///
  /// In en, this message translates to:
  /// **'Serial'**
  String get marketplaceSpecSerial;

  /// No description provided for @marketplaceSpecCondition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get marketplaceSpecCondition;

  /// No description provided for @marketplaceSpecHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get marketplaceSpecHours;

  /// No description provided for @marketplaceIncluded.
  ///
  /// In en, this message translates to:
  /// **'What\'s included'**
  String get marketplaceIncluded;

  /// No description provided for @marketplaceRates.
  ///
  /// In en, this message translates to:
  /// **'Rates'**
  String get marketplaceRates;

  /// No description provided for @marketplaceDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get marketplaceDaily;

  /// No description provided for @marketplaceWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get marketplaceWeekly;

  /// No description provided for @marketplaceMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get marketplaceMonthly;

  /// No description provided for @marketplaceRateNote.
  ///
  /// In en, this message translates to:
  /// **'Longer bookings get better rates. Rates apply per calendar day, rounded up.'**
  String get marketplaceRateNote;

  /// No description provided for @marketplaceDepositTitle.
  ///
  /// In en, this message translates to:
  /// **'Refundable deposit'**
  String get marketplaceDepositTitle;

  /// No description provided for @marketplaceDepositBody.
  ///
  /// In en, this message translates to:
  /// **'Held by GCC, not by the vendor. Refunded to your GCC wallet once the yard\'s return condition video is approved. Not part of what you pay for the equipment. You get it back.'**
  String get marketplaceDepositBody;

  /// No description provided for @marketplaceInsurance.
  ///
  /// In en, this message translates to:
  /// **'Micro-insurance'**
  String get marketplaceInsurance;

  /// No description provided for @marketplaceInsurancePerDay.
  ///
  /// In en, this message translates to:
  /// **'{amount} per day'**
  String marketplaceInsurancePerDay(String amount);

  /// No description provided for @marketplaceInsuranceStay.
  ///
  /// In en, this message translates to:
  /// **'{amount} for 3 days'**
  String marketplaceInsuranceStay(String amount);

  /// No description provided for @marketplaceInsuranceNote.
  ///
  /// In en, this message translates to:
  /// **'1.5% of the daily rate, minimum ₦500 per day.'**
  String get marketplaceInsuranceNote;

  /// No description provided for @marketplaceAudit.
  ///
  /// In en, this message translates to:
  /// **'Condition audit'**
  String get marketplaceAudit;

  /// No description provided for @marketplaceLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get marketplaceLocation;

  /// No description provided for @marketplaceSimilar.
  ///
  /// In en, this message translates to:
  /// **'Similar equipment'**
  String get marketplaceSimilar;

  /// No description provided for @marketplaceReport.
  ///
  /// In en, this message translates to:
  /// **'Report this listing'**
  String get marketplaceReport;

  /// No description provided for @marketplaceStay.
  ///
  /// In en, this message translates to:
  /// **'{rate} per day · Est. 3-day total {total}'**
  String marketplaceStay(String rate, String total);

  /// No description provided for @marketplaceRefundable.
  ///
  /// In en, this message translates to:
  /// **'+ {amount} refundable deposit'**
  String marketplaceRefundable(String amount);

  /// No description provided for @marketplaceBookNow.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get marketplaceBookNow;

  /// No description provided for @marketplaceMissing.
  ///
  /// In en, this message translates to:
  /// **'This listing is no longer available.'**
  String get marketplaceMissing;
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
