import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const double displaySize = 28;
  static const double displayLineHeight = 34;
  static const double headlineSize = 22;
  static const double headlineLineHeight = 28;
  static const double titleSize = 18;
  static const double titleLineHeight = 24;
  static const double sectionSize = 15;
  static const double sectionLineHeight = 22;
  static const double bodySize = 14;
  static const double bodyLineHeight = 20;
  static const double bodySmallSize = 13;
  static const double bodySmallLineHeight = 18;
  static const double labelSize = 12;
  static const double labelLineHeight = 16;
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
        fontWeight: FontWeight.w600,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontSize: headlineSize,
        height: headlineLineHeight / headlineSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      headlineSmall: TextStyle(
        fontSize: titleSize,
        height: titleLineHeight / titleSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleMedium: TextStyle(
        fontSize: sectionSize,
        height: sectionLineHeight / sectionSize,
        fontWeight: FontWeight.w600,
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

  static const TextStyle money = TextStyle(
    fontFeatures: [FontFeature.tabularFigures()],
  );
}
