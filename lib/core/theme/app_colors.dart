import 'package:flutter/material.dart';

/// Product palette from the GCC design spec.
///
/// The spec defines the light palette. Dark-theme containers are adaptations
/// of those hues so semantic roles stay stable in both brightness modes.
abstract final class AppColors {
  static const Color ink950 = Color(0xFF0B1220);
  static const Color ink900 = Color(0xFF111827);
  static const Color ink800 = Color(0xFF1F2937);
  static const Color ink700 = Color(0xFF374151);
  static const Color ink600 = Color(0xFF4B5563);
  static const Color ink500 = Color(0xFF6B7280);
  static const Color ink400 = Color(0xFF9CA3AF);
  static const Color ink300 = Color(0xFFD1D5DB);
  static const Color ink200 = Color(0xFFE5E7EB);
  static const Color ink100 = Color(0xFFF3F4F6);
  static const Color ink50 = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color canvas = Color(0xFFF9FAFB);
  static const Color nightCanvas = Color(0xFF0B1311);

  static const Color brand700 = Color(0xFF0E4C3F);
  static const Color brand600 = Color(0xFF146B57);
  static const Color brand500 = Color(0xFF17856C);
  static const Color brand100 = Color(0xFFE3F1EC);
  static const Color brand50 = Color(0xFFF1F8F5);

  static const Color accent600 = Color(0xFFB4690E);
  static const Color accent500 = Color(0xFFE08A0B);
  static const Color accent100 = Color(0xFFFDF0D5);

  static const Color success600 = Color(0xFF127A4B);
  static const Color success50 = Color(0xFFE7F5EE);
  static const Color warning600 = Color(0xFFE08A0B);
  static const Color warning50 = Color(0xFFFDF4E3);
  static const Color danger700 = Color(0xFF9B2019);
  static const Color danger600 = Color(0xFFB3261E);
  static const Color danger50 = Color(0xFFFBEBEA);
  static const Color dangerBorder = Color(0xFFF5C2C0);
  static const Color info600 = Color(0xFF17548E);
  static const Color info50 = Color(0xFFE9F1F9);

  static const Color darkSuccessContainer = Color(0xFF12382A);
  static const Color darkWarningContainer = Color(0xFF3A2A10);
  static const Color darkDangerContainer = Color(0xFF3A1614);
  static const Color darkInfoContainer = Color(0xFF12283F);
  static const Color darkHeldFundsContainer = Color(0xFF3A2A10);

  static const Color shadow = Color(0x1F101828);
  static const Color stickyShadow = Color(0x0F101828);
  static const Color scrim = Color(0x73000000);
  static const Color transparent = Color(0x00000000);
}
