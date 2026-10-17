import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_colors.dart';

abstract final class AppGradients {
  /// The wallet's available-balance card.
  ///
  /// A subtle two-stop brand wash, the designs' only gradient. Kept here
  /// because a decoration cannot reach a color scheme.
  static const LinearGradient availableBalance = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.brand700, AppColors.brand600],
  );

  static const LinearGradient agentHeaderWash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.brand700, AppColors.brand600],
  );
}
