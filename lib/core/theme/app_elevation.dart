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

  static const List<BoxShadow> overlay = [
    BoxShadow(
      color: AppColors.shadow,
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -4,
    ),
  ];
}
