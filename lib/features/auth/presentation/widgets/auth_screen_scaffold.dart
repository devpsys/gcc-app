import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/auth/presentation/widgets/auth_brand_mark.dart';

class AuthScreenScaffold extends StatelessWidget {
  const AuthScreenScaffold({
    required this.title,
    required this.body,
    required this.footer,
    this.subtitle,
    this.belowCard,
    this.onBack,
    this.backLabel,
    super.key,
  });

  final String title;
  final Widget? subtitle;
  final Widget body;
  final Widget? belowCard;
  final Widget footer;
  final VoidCallback? onBack;
  final String? backLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final caption = subtitle;
    final supporting = belowCard;
    final back = onBack;
    const padding = EdgeInsets.fromLTRB(
      AppSpacing.pageGutterCompact,
      AppSpacing.sm,
      AppSpacing.pageGutterCompact,
      AppSpacing.lg,
    );

    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.maxContentWidth,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final minHeight = constraints.maxHeight.isFinite
                    ? (constraints.maxHeight - padding.vertical)
                          .clamp(0.0, double.infinity)
                          .toDouble()
                    : 0.0;
                return SingleChildScrollView(
                  padding: padding,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: minHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (back != null)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                tooltip: backLabel,
                                onPressed: back,
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                          const Center(child: AuthBrandMark()),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          if (caption != null) ...[
                            const SizedBox(height: AppSpacing.xxs),
                            IconTheme(
                              data: IconThemeData(color: scheme.onSurface),
                              child: DefaultTextStyle(
                                style:
                                    Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: scheme.onSurfaceVariant,
                                        ) ??
                                    const TextStyle(),
                                textAlign: TextAlign.center,
                                child: caption,
                              ),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.md),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(
                                AppRadii.dialog,
                              ),
                              border: Border.all(
                                color: context.semanticColors.border,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: body,
                            ),
                          ),
                          if (supporting != null) ...[
                            const SizedBox(height: AppSpacing.md),
                            supporting,
                          ],
                          const Spacer(),
                          const SizedBox(height: AppSpacing.md),
                          footer,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
