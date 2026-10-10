enum AppWindowSize { compact, medium, expanded, large }

abstract final class AppBreakpoints {
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
}
