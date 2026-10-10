class LanguageOption {
  const LanguageOption({
    required this.id,
    required this.englishName,
    required this.nativeName,
    required this.sample,
    required this.enabled,
  });

  final String id;
  final String englishName;
  final String nativeName;
  final String sample;
  final bool enabled;
}
