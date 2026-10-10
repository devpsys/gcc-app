import 'package:gcc_app/features/auth/presentation/widgets/language_option.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

List<LanguageOption> gccLanguageOptions(AppLocalizations l10n) {
  return [
    LanguageOption(
      id: 'english',
      englishName: l10n.languageEnglishName,
      nativeName: l10n.languageEnglishNative,
      sample: l10n.languageEnglishSample,
      enabled: true,
    ),
    LanguageOption(
      id: 'pidgin',
      englishName: l10n.languagePidginName,
      nativeName: l10n.languagePidginNative,
      sample: l10n.languagePidginSample,
      enabled: false,
    ),
    LanguageOption(
      id: 'yoruba',
      englishName: l10n.languageYorubaName,
      nativeName: l10n.languageYorubaNative,
      sample: l10n.languageYorubaSample,
      enabled: false,
    ),
    LanguageOption(
      id: 'igbo',
      englishName: l10n.languageIgboName,
      nativeName: l10n.languageIgboNative,
      sample: l10n.languageIgboSample,
      enabled: false,
    ),
    LanguageOption(
      id: 'hausa',
      englishName: l10n.languageHausaName,
      nativeName: l10n.languageHausaNative,
      sample: l10n.languageHausaSample,
      enabled: false,
    ),
  ];
}
