import 'package:flutter/material.dart';

/// Mobile type scale from the field design system.
///
/// Inter and JetBrains Mono are the specified faces. They are not bundled, so
/// UI text uses the platform font and identifiers use the platform monospace.
abstract final class AppTextStyles {
  static const double displaySize = 28;
  static const double displayLineHeight = 34;
  static const double headlineSize = 22;
  static const double headlineLineHeight = 28;
  static const double titleSize = 18;
  static const double titleLineHeight = 24;
  static const double sheetTitleSize = 17;
  static const double sheetTitleLineHeight = 24;
  static const double bodyLargeSize = 16;
  static const double bodyLargeLineHeight = 24;
  static const double bodySize = 15;
  static const double bodyLineHeight = 22;
  static const double bodySmallSize = 13;
  static const double bodySmallLineHeight = 18;
  static const double labelSize = 12;
  static const double labelLineHeight = 16;
  static const double buttonSize = 15;
  static const double buttonLineHeight = 20;
  static const double eyebrowSize = 11;
  static const double eyebrowLineHeight = 14;
  static const double eyebrowLetterSpacing = 0.88;

  static TextTheme textTheme(ColorScheme scheme) {
    final color = scheme.onSurface;
    final muted = scheme.onSurfaceVariant;
    return TextTheme(
      displaySmall: TextStyle(
        fontSize: displaySize,
        height: displayLineHeight / displaySize,
        fontWeight: FontWeight.w700,
        letterSpacing: displaySize * -0.02,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontSize: headlineSize,
        height: headlineLineHeight / headlineSize,
        fontWeight: FontWeight.w600,
        letterSpacing: headlineSize * -0.015,
        color: color,
      ),
      headlineSmall: TextStyle(
        fontSize: titleSize,
        height: titleLineHeight / titleSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleLarge: TextStyle(
        fontSize: sheetTitleSize,
        height: sheetTitleLineHeight / sheetTitleSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleMedium: TextStyle(
        fontSize: bodyLargeSize,
        height: bodyLargeLineHeight / bodyLargeSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      bodyLarge: TextStyle(
        fontSize: bodyLargeSize,
        height: bodyLargeLineHeight / bodyLargeSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontSize: bodySize,
        height: bodyLineHeight / bodySize,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      bodySmall: TextStyle(
        fontSize: bodySmallSize,
        height: bodySmallLineHeight / bodySmallSize,
        fontWeight: FontWeight.w400,
        color: muted,
      ),
      labelLarge: TextStyle(
        fontSize: buttonSize,
        height: buttonLineHeight / buttonSize,
        fontWeight: FontWeight.w600,
        letterSpacing: buttonSize * 0.01,
        color: color,
      ),
      labelMedium: TextStyle(
        fontSize: labelSize,
        height: labelLineHeight / labelSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      labelSmall: TextStyle(
        fontSize: eyebrowSize,
        height: eyebrowLineHeight / eyebrowSize,
        fontWeight: FontWeight.w600,
        letterSpacing: eyebrowLetterSpacing,
        color: muted,
      ),
    );
  }

  static TextStyle tabular(TextStyle style) {
    return style.copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
  }

  static TextStyle mono(TextStyle style) {
    return style.copyWith(
      fontFamily: 'monospace',
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
