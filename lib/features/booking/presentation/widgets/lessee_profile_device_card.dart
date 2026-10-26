import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/lessee_profile.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_profile_section.dart';

/// Device diagnostics and offline capture toggle (MOB-LSE-17).
class LesseeProfileDeviceCard extends StatelessWidget {
  const LesseeProfileDeviceCard({required this.profile, super.key});

  final LesseeProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return LesseeProfileSection(
      title: l10n.lesseeProfileDevice,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            _monoRow(context, l10n.profileRowModel, profile.deviceModel),
            const SizedBox(height: AppSpacing.xs),
            _monoRow(
              context,
              l10n.lesseeProfileOsPlatform,
              profile.devicePlatform,
            ),
            const SizedBox(height: AppSpacing.xs),
            _monoRow(
              context,
              l10n.profileRowAppVersion,
              profile.appVersion,
            ),
            const SizedBox(height: AppSpacing.sm),
            Divider(height: 1, color: colors.border),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  l10n.profileRowOfflineCapture,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      profile.offlineCapture,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    IgnorePointer(
                      child: Switch.adaptive(
                        value: true,
                        onChanged: (_) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _monoRow(BuildContext context, String label, String value) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: AppTextStyles.mono(
              Theme.of(context).textTheme.bodySmall!.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.mono(
              Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
