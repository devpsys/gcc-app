import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/shell_app_bar_style.dart';

/// Wallet app-bar chip that names the signed-in role (MOB-LSE-14 / dual-role).
class WalletModeBadge extends StatelessWidget {
  const WalletModeBadge({
    required this.label,
    this.appBarStyle = ShellAppBarStyle.surface,
    super.key,
  });

  final String label;
  final ShellAppBarStyle appBarStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brand = appBarStyle == ShellAppBarStyle.brand;
    final background = brand
        ? scheme.onSecondary.withValues(alpha: 0.16)
        : scheme.secondaryContainer;
    final foreground = brand ? scheme.onSecondary : scheme.onSecondaryContainer;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.xxs,
            ),
            child: Text(
              label.toUpperCase(),
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
