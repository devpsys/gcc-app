import 'package:flutter/painting.dart';
import 'package:gcc_app/core/theme/app_colors.dart';

abstract final class AppElevation {
  static const double level0 = 0;
  static const double level1 = 1;
  static const double level2 = 8;

  static const List<BoxShadow> sticky = [
    BoxShadow(
      color: AppColors.stickyShadow,
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  /// The switch thumb lift from the designs' `.switch-thumb`
  /// (`0 1px 3px rgba(0,0,0,.25)`). Kept because it reads as a physical
  /// affordance on a moving control, not as card decoration.
  static const List<BoxShadow> thumb = [
    BoxShadow(color: Color(0x40000000), offset: Offset(0, 1), blurRadius: 3),
  ];

  static const List<BoxShadow> overlay = [
    BoxShadow(
      color: AppColors.shadow,
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -4,
    ),
  ];
}
