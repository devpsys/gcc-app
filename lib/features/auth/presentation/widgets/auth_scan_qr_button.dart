import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Full-width Scan QR ghost button (48px).
class AuthScanQrButton extends StatelessWidget {
  const AuthScanQrButton({
    required this.label,
    this.onPressed,
    this.disabledReason,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? disabledReason;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final action = onPressed ?? () {};
    return Tooltip(
      message: onPressed == null ? (disabledReason ?? '') : '',
      child: SizedBox(
        height: AppDimensions.minTouchTarget,
        width: double.infinity,
        child: OutlinedButton(
          onPressed: action,
          style: OutlinedButton.styleFrom(
            foregroundColor: scheme.onSurface,
            backgroundColor: scheme.surface,
            disabledForegroundColor: scheme.onSurface,
            side: BorderSide(color: colors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.input),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: AppDimensions.iconMd,
                color: scheme.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
