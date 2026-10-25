enum AppWindowSize { compact, medium, expanded, large }

abstract final class AppBreakpoints {
  /// iOS / modern Android phone width where gutters absorb ambient space
  /// (MOB-AGT-02 / 09 @ 390) without component reflow.
  static const double comfortable = 390;
  static const double medium = 768;
  static const double expanded = 1024;
  static const double large = 1440;

  static AppWindowSize sizeFor(double width) {
    if (width < medium) {
      return AppWindowSize.compact;
    }
    if (width < expanded) {
      return AppWindowSize.medium;
    }
    if (width < large) {
      return AppWindowSize.expanded;
    }
    return AppWindowSize.large;
  }

  /// True at tablet portrait and up (App B master-detail, top tabs).
  static bool isTablet(double width) => width >= medium;
}
