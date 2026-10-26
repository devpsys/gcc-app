import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gcc_app/core/config/app_environment.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Branded env ribbon in the bottom-end corner (away from status / app bars).
///
/// Shown for non-production builds in debug or profile mode.
class AppDebugEnvBanner extends StatelessWidget {
  const AppDebugEnvBanner({
    required this.environment,
    required this.child,
    this.forceVisible = false,
    super.key,
  });

  final AppEnvironment environment;
  final Widget child;

  /// Test hook — production builds never show the ribbon regardless.
  final bool forceVisible;

  static bool shouldShow(
    AppEnvironment environment, {
    bool forceVisible = false,
  }) {
    if (environment == AppEnvironment.production) {
      return false;
    }
    return forceVisible || kDebugMode || kProfileMode;
  }

  static String labelFor(AppEnvironment environment) {
    return switch (environment) {
      AppEnvironment.development => 'GCC · DEV',
      AppEnvironment.staging => 'GCC · STAGING',
      AppEnvironment.production => 'GCC · PROD',
    };
  }

  @override
  Widget build(BuildContext context) {
    if (!shouldShow(environment, forceVisible: forceVisible)) {
      return child;
    }

    final colors = context.semanticColors;
    return Banner(
      message: labelFor(environment),
      location: BannerLocation.bottomEnd,
      color: colors.warning,
      textStyle: AppTextStyles.mono(
        const TextStyle(
          color: AppColors.surface,
          fontSize: AppTextStyles.eyebrowSize,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
      child: child,
    );
  }
}
