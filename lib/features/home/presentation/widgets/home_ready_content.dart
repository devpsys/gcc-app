import 'package:flutter/material.dart';
import 'package:gcc_app/core/config/app_environment.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/key_value_line.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';
import 'package:gcc_app/features/home/presentation/widgets/theme_mode_selector.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

class HomeReadyContent extends StatelessWidget {
  const HomeReadyContent({
    required this.themeMode,
    required this.environment,
    required this.apiConfigured,
    this.errorMessage,
    super.key,
  });

  final AppThemeMode themeMode;
  final AppEnvironment environment;
  final bool apiConfigured;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final message = errorMessage;

    return ResponsiveContent(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(l10n.homeHeadline, style: textTheme.headlineMedium),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(l10n.homeBody, style: textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.xl),
              ThemeModeSelector(themeMode: themeMode),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.md),
                StatusChip(label: message, tone: StatusTone.danger),
              ],
              const SizedBox(height: AppSpacing.xl),
              KeyValueLine(
                label: l10n.environmentTitle,
                value: _environmentName(l10n),
              ),
              const SizedBox(height: AppSpacing.md),
              StatusChip(
                label: apiConfigured
                    ? l10n.apiConfigured
                    : l10n.apiNotConfigured,
                tone: apiConfigured ? StatusTone.success : StatusTone.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _environmentName(AppLocalizations l10n) {
    return switch (environment) {
      AppEnvironment.development => l10n.environmentDevelopment,
      AppEnvironment.staging => l10n.environmentStaging,
      AppEnvironment.production => l10n.environmentProduction,
    };
  }
}
