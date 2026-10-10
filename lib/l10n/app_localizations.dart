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
