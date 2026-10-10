import 'package:flutter/material.dart';
import 'package:gcc_app/core/config/app_environment.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';
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
          padding: const EdgeInsets.all(AppSpacing.lg),
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
                Text(
                  message,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              Text(_environmentLabel(l10n), style: textTheme.bodySmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                apiConfigured ? l10n.apiConfigured : l10n.apiNotConfigured,
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _environmentLabel(AppLocalizations l10n) {
    final name = switch (environment) {
      AppEnvironment.development => l10n.environmentDevelopment,
      AppEnvironment.staging => l10n.environmentStaging,
      AppEnvironment.production => l10n.environmentProduction,
    };
    return l10n.environmentLabel(name);
  }
}
