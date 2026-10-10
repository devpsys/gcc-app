import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class AuthSessionFooter extends StatelessWidget {
  const AuthSessionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final muted = Theme.of(context).textTheme.bodySmall;
    return Column(
      children: [
        Text(
          l10n.authOfflineSession,
          textAlign: TextAlign.center,
          style: muted,
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text.rich(
          TextSpan(
            style: muted?.copyWith(color: scheme.onSurface),
            children: [
              TextSpan(text: '${l10n.authSupport} '),
              TextSpan(
                text: l10n.authSupportPhone,
                style: AppTextStyles.mono(
                  (muted ?? const TextStyle()).copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
