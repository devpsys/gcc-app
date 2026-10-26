import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';

/// Agent / Vendor / Lessee entry pills (MOB-AUTH-UNIFIED Frame 01).
class AuthRoleSwitcher extends StatelessWidget {
  const AuthRoleSwitcher({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final AuthRole selected;
  final ValueChanged<AuthRole> onSelected;

  static const _order = [AuthRole.agent, AuthRole.vendor, AuthRole.lessee];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: Row(
          children: [
            for (final role in _order)
              Expanded(
                child: _pill(
                  context,
                  label: switch (role) {
                    AuthRole.agent => l10n.authRoleAgentPill,
                    AuthRole.vendor => l10n.authRoleVendorPill,
                    AuthRole.lessee => l10n.authRoleLesseePill,
                  },
                  selected: role == selected,
                  onTap: () => onSelected(role),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _pill(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.surface : scheme.surface.withValues(alpha: 0),
      elevation: selected ? 1 : 0,
      shadowColor: scheme.shadow.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(AppRadii.button),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.button),
            border: selected
                ? Border.all(color: scheme.outlineVariant.withValues(alpha: 0.8))
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: selected ? scheme.primary : scheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
