enum OnboardingLanguage { english, pidgin, yoruba, igbo, hausa }

extension OnboardingLanguageAvailability on OnboardingLanguage {
  bool get isAvailable => this == OnboardingLanguage.english;
}
