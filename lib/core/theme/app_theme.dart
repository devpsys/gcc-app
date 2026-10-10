import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_button_styles.dart';
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
        outline: AppColors.ink300,
        outlineVariant: AppColors.ink200,
        surfaceContainerLow: AppColors.ink50,
        surfaceContainerHighest: AppColors.ink100,
        shadow: AppColors.shadow,
        scrim: AppColors.scrim,
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
        dangerBorder: AppColors.dangerBorder,
        muted: AppColors.ink500,
      ),
      scaffoldBackground: AppColors.canvas,
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
        surfaceContainerLow: AppColors.ink800,
        surfaceContainerHighest: AppColors.ink700,
        shadow: AppColors.shadow,
        scrim: AppColors.scrim,
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
        dangerBorder: AppColors.darkDangerContainer,
        muted: AppColors.ink400,
      ),
      scaffoldBackground: AppColors.nightCanvas,
    );
  }

  static ThemeData _build({
    required ColorScheme scheme,
    required AppSemanticColors semantic,
    required Color scaffoldBackground,
  }) {
    final textTheme = AppTextStyles.textTheme(scheme);
    final cardRadius = BorderRadius.circular(AppRadii.card);
    final inputRadius = BorderRadius.circular(AppRadii.input);
    final cardBorder = BorderSide(
      color: semantic.border,
      width: AppDimensions.borderWidth,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scaffoldBackground,
      shadowColor: scheme.shadow,
      extensions: [semantic],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: AppElevation.level0,
        scrolledUnderElevation: AppElevation.level0,
        toolbarHeight: AppDimensions.topBarHeight,
        titleTextStyle: textTheme.titleLarge,
        shape: Border(bottom: cardBorder),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: AppElevation.level0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: cardRadius,
          side: cardBorder,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: semantic.border,
        thickness: AppDimensions.borderWidth,
        space: AppDimensions.borderWidth,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: scheme.surface,
        elevation: AppElevation.level0,
        shape: const RoundedRectangleBorder(),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        elevation: AppElevation.level2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.dialog),
          side: cardBorder,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        elevation: AppElevation.level2,
        modalBarrierColor: AppColors.scrim,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.sheet),
          ),
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
        indicatorColor: AppColors.transparent,
        elevation: AppElevation.level0,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: AppDimensions.iconMd,
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          );
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(
          color: scheme.outline,
          width: AppDimensions.emphasisBorderWidth,
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return scheme.surface;
        }),
        checkColor: WidgetStatePropertyAll(scheme.onPrimary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: AppButtonStyles.primary(scheme),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(
            AppDimensions.minTouchTarget,
            AppDimensions.buttonHeightCompact,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: AppButtonStyles.secondary(scheme),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          minimumSize: const Size(
            AppDimensions.minTouchTarget,
            AppDimensions.buttonHeightCompact,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        isDense: true,
        constraints: const BoxConstraints(minHeight: AppDimensions.inputHeight),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.ink400),
        labelStyle: textTheme.labelMedium,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: scheme.outline),
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
