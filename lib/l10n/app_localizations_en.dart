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
}
