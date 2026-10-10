import 'package:flutter/material.dart';

class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.danger,
    required this.dangerContainer,
    required this.info,
    required this.infoContainer,
    required this.heldFunds,
    required this.heldFundsContainer,
    required this.border,
    required this.dangerBorder,
    required this.muted,
  });

  final Color success;
  final Color successContainer;
  final Color warning;
  final Color warningContainer;
  final Color danger;
  final Color dangerContainer;
  final Color info;
  final Color infoContainer;
  final Color heldFunds;
  final Color heldFundsContainer;
  final Color border;
  final Color dangerBorder;
  final Color muted;

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? successContainer,
    Color? warning,
    Color? warningContainer,
    Color? danger,
    Color? dangerContainer,
    Color? info,
    Color? infoContainer,
    Color? heldFunds,
    Color? heldFundsContainer,
    Color? border,
    Color? dangerBorder,
    Color? muted,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      danger: danger ?? this.danger,
      dangerContainer: dangerContainer ?? this.dangerContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      heldFunds: heldFunds ?? this.heldFunds,
      heldFundsContainer: heldFundsContainer ?? this.heldFundsContainer,
      border: border ?? this.border,
      dangerBorder: dangerBorder ?? this.dangerBorder,
      muted: muted ?? this.muted,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) {
      return this;
    }
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t) ?? success,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t) ??
          successContainer,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t) ??
          warningContainer,
      danger: Color.lerp(danger, other.danger, t) ?? danger,
      dangerContainer:
          Color.lerp(dangerContainer, other.dangerContainer, t) ??
          dangerContainer,
      info: Color.lerp(info, other.info, t) ?? info,
      infoContainer:
          Color.lerp(infoContainer, other.infoContainer, t) ?? infoContainer,
      heldFunds: Color.lerp(heldFunds, other.heldFunds, t) ?? heldFunds,
      heldFundsContainer:
          Color.lerp(heldFundsContainer, other.heldFundsContainer, t) ??
          heldFundsContainer,
      border: Color.lerp(border, other.border, t) ?? border,
      dangerBorder:
          Color.lerp(dangerBorder, other.dangerBorder, t) ?? dangerBorder,
      muted: Color.lerp(muted, other.muted, t) ?? muted,
    );
  }
}
