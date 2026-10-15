import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_colors.dart';

abstract final class AppGradients {
  static const LinearGradient agentHeaderWash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.brand700, AppColors.brand600],
  );
}
