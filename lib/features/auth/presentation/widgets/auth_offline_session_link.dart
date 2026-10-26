import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';

/// “Offline? Use your last signed-in session.” (MOB-AUTH-UNIFIED Frame 01).
class AuthOfflineSessionLink extends StatelessWidget {
  const AuthOfflineSessionLink({this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Text.rich(
      TextSpan(
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        children: [
          TextSpan(text: '${l10n.authOfflineSessionLead} '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                l10n.authOfflineSessionLink,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: scheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
