import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_elevation.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_semantic_colors.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData light() {
    return _build(
      scheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.brand600,
        onPrimary: AppColors.surface,
        primaryContainer: AppColors.brand100,
        onPrimaryContainer: AppColors.brand700,
        secondary: AppColors.brand700,
        onSecondary: AppColors.surface,
        secondaryContainer: AppColors.brand50,
        onSecondaryContainer: AppColors.brand700,
        error: AppColors.danger600,
        onError: AppColors.surface,
        errorContainer: AppColors.danger50,
        onErrorContainer: AppColors.danger600,
        surface: AppColors.surface,
        onSurface: AppColors.ink900,
        onSurfaceVariant: AppColors.ink500,
        outline: AppColors.ink200,
        outlineVariant: AppColors.ink100,
        shadow: AppColors.shadow,
      ),
      semantic: const AppSemanticColors(
        success: AppColors.success600,
        successContainer: AppColors.success50,
        warning: AppColors.warning600,
        warningContainer: AppColors.warning50,
        danger: AppColors.danger600,
        dangerContainer: AppColors.danger50,
        info: AppColors.info600,
        infoContainer: AppColors.info50,
        heldFunds: AppColors.accent600,
        heldFundsContainer: AppColors.accent100,
        border: AppColors.ink200,
        muted: AppColors.ink500,
      ),
    );
  }

  static ThemeData dark() {
    return _build(
      scheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.brand500,
        onPrimary: AppColors.ink950,
        primaryContainer: AppColors.brand700,
        onPrimaryContainer: AppColors.brand100,
        secondary: AppColors.brand100,
        onSecondary: AppColors.ink950,
        secondaryContainer: AppColors.brand700,
        onSecondaryContainer: AppColors.brand50,
        error: AppColors.danger600,
        onError: AppColors.surface,
        errorContainer: AppColors.darkDangerContainer,
        onErrorContainer: AppColors.danger50,
        surface: AppColors.ink900,
        onSurface: AppColors.ink50,
        onSurfaceVariant: AppColors.ink400,
        outline: AppColors.ink700,
        outlineVariant: AppColors.ink700,
        shadow: AppColors.shadow,
      ),
      semantic: const AppSemanticColors(
        success: AppColors.success600,
        successContainer: AppColors.darkSuccessContainer,
        warning: AppColors.warning600,
        warningContainer: AppColors.darkWarningContainer,
        danger: AppColors.danger600,
        dangerContainer: AppColors.darkDangerContainer,
        info: AppColors.info600,
        infoContainer: AppColors.darkInfoContainer,
        heldFunds: AppColors.accent500,
        heldFundsContainer: AppColors.darkHeldFundsContainer,
        border: AppColors.ink700,
        muted: AppColors.ink400,
      ),
      scaffoldBackground: AppColors.ink950,
    );
  }

  static ThemeData _build({
    required ColorScheme scheme,
    required AppSemanticColors semantic,
    Color? scaffoldBackground,
  }) {
    final textTheme = AppTextStyles.textTheme(scheme);
    final border = BorderSide(
      color: semantic.border,
      width: AppDimensions.borderWidth,
    );
    final inputRadius = BorderRadius.circular(AppRadii.input);
    final cardRadius = BorderRadius.circular(AppRadii.card);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scaffoldBackground ?? scheme.surface,
      shadowColor: scheme.shadow,
      extensions: [semantic],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: AppElevation.level0,
        scrolledUnderElevation: AppElevation.level0,
        toolbarHeight: AppDimensions.topBarHeight,
        titleTextStyle: textTheme.headlineSmall,
        shape: Border(bottom: border),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: AppElevation.level0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: cardRadius, side: border),
      ),
      dividerTheme: DividerThemeData(
        color: semantic.border,
        thickness: AppDimensions.borderWidth,
        space: AppDimensions.borderWidth,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: scheme.surface,
        elevation: AppElevation.level2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppRadii.overlay),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        elevation: AppElevation.level2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.overlay),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        selectedIconTheme: IconThemeData(
          color: scheme.primary,
          size: AppDimensions.iconMd,
        ),
        unselectedIconTheme: IconThemeData(
          color: scheme.onSurfaceVariant,
          size: AppDimensions.iconMd,
        ),
        labelType: NavigationRailLabelType.none,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: AppDimensions.navigationBarHeight,
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        elevation: AppElevation.level0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(
            AppDimensions.minTouchTarget,
            AppDimensions.buttonHeightMd,
          ),
          shape: RoundedRectangleBorder(borderRadius: cardRadius),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(
            AppDimensions.minTouchTarget,
            AppDimensions.buttonHeightMd,
          ),
          shape: RoundedRectangleBorder(borderRadius: cardRadius),
          side: border,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          minimumSize: const Size(
            AppDimensions.minTouchTarget,
            AppDimensions.buttonHeightMd,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: border,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: border,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(
            color: scheme.primary,
            width: AppDimensions.focusBorderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: scheme.error),
        ),
      ),
    );
  }
}
