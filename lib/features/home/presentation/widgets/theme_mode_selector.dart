import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({required this.themeMode, super.key});

  final AppThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.themeModeLabel,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < AppBreakpoints.medium) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final mode in AppThemeMode.values) ...[
                    mode == themeMode
                        ? FilledButton(
                            onPressed: () => _select(context, mode),
                            child: Text(_label(l10n, mode)),
                          )
                        : OutlinedButton(
                            onPressed: () => _select(context, mode),
                            child: Text(_label(l10n, mode)),
                          ),
                    if (mode != AppThemeMode.values.last)
                      const SizedBox(height: AppSpacing.xs),
                  ],
                ],
              );
            }
            return SegmentedButton<AppThemeMode>(
              segments: [
                for (final mode in AppThemeMode.values)
                  ButtonSegment<AppThemeMode>(
                    value: mode,
                    label: Text(_label(l10n, mode)),
                  ),
              ],
              selected: {themeMode},
              onSelectionChanged: (selection) =>
                  _select(context, selection.first),
            );
          },
        ),
      ],
    );
  }

  void _select(BuildContext context, AppThemeMode mode) {
    context.read<HomeCubit>().setThemeMode(mode);
  }

  String _label(AppLocalizations l10n, AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => l10n.themeModeSystem,
      AppThemeMode.light => l10n.themeModeLight,
      AppThemeMode.dark => l10n.themeModeDark,
    };
  }
}
