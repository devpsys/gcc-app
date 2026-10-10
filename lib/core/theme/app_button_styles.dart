import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_elevation.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

abstract final class AppButtonStyles {
  static ButtonStyle primary(ColorScheme scheme) {
    return _base(scheme).copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.ink100;
        }
        if (states.contains(WidgetState.pressed)) {
          return AppColors.brand700;
        }
        return scheme.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.ink400;
        }
        return scheme.onPrimary;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return const BorderSide(color: AppColors.ink200);
        }
        return BorderSide.none;
      }),
    );
  }

  static ButtonStyle secondary(ColorScheme scheme) {
    return _base(scheme).copyWith(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return scheme.primaryContainer;
        }
        return scheme.surface;
      }),
      foregroundColor: WidgetStatePropertyAll(scheme.primary),
      side: WidgetStatePropertyAll(
        BorderSide(
          color: scheme.primary,
          width: AppDimensions.emphasisBorderWidth,
        ),
      ),
    );
  }

  static ButtonStyle neutral(ColorScheme scheme) {
    return _base(scheme).copyWith(
      backgroundColor: const WidgetStatePropertyAll(AppColors.surface),
      foregroundColor: WidgetStatePropertyAll(scheme.onSurface),
      side: WidgetStatePropertyAll(
        BorderSide(color: scheme.outline, width: AppDimensions.borderWidth),
      ),
    );
  }

  static ButtonStyle destructive(ColorScheme scheme, {required bool filled}) {
    if (filled) {
      return _base(scheme).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.danger700;
          }
          return scheme.error;
        }),
        foregroundColor: WidgetStatePropertyAll(scheme.onError),
      );
    }

    return _base(scheme).copyWith(
      backgroundColor: WidgetStatePropertyAll(scheme.errorContainer),
      foregroundColor: WidgetStatePropertyAll(scheme.error),
      side: WidgetStatePropertyAll(
        BorderSide(color: scheme.error, width: AppDimensions.borderWidth),
      ),
    );
  }

  static ButtonStyle _base(ColorScheme scheme) {
    return ButtonStyle(
      elevation: const WidgetStatePropertyAll(AppElevation.level0),
      minimumSize: const WidgetStatePropertyAll(
        Size(AppDimensions.minTouchTarget, AppDimensions.buttonHeight),
      ),
      tapTargetSize: MaterialTapTargetSize.padded,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        AppTextStyles.textTheme(scheme).labelLarge,
      ),
    );
  }
}
