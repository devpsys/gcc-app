import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// 32×32 GCC brand square (MOB-AUTH-UNIFIED Frame 01 / 03).
class AuthGccMark extends StatelessWidget {
  const AuthGccMark({super.key});

  static const double _size = AppDimensions.minTouchTarget * 2 / 3;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
      ),
      child: SizedBox.square(
        dimension: _size,
        child: Center(
          child: Text(
            'GCC',
            maxLines: 1,
            softWrap: false,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTextStyles.sansFamily,
              fontSize: AppTextStyles.bodySmallSize,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: AppTextStyles.bodySmallSize * 0.05,
              color: scheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
