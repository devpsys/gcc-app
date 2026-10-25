import 'package:gcc_app/core/theme/app_breakpoints.dart';

abstract final class AppSpacing {
  /// 6 px. The design sources use Tailwind's `1.5` step for tight gaps,
  /// chip gutters and label offsets, which sits between [xxs] and [xs].
  static const double tight = 6;
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
  static const double huge = 48;
  static const double max = 64;

  static const double pageGutterCompact = md;
  /// 20 px — 390 px absorption (16 → 20) before tablet gutters.
  static const double pageGutterComfortable = lg;
  static const double pageGutterExpanded = xl;

  /// Page gutter for the given viewport width.
  ///
  /// Compact phones keep 16. From [AppBreakpoints.comfortable] gutters open to
  /// 20. From tablet ([AppBreakpoints.medium]) they open to 24.
  static double pageGutterFor(double width) {
    if (width >= AppBreakpoints.medium) {
      return pageGutterExpanded;
    }
    if (width >= AppBreakpoints.comfortable) {
      return pageGutterComfortable;
    }
    return pageGutterCompact;
  }
}
