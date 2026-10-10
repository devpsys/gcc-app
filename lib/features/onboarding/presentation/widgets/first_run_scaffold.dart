import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/first_run_step_indicator.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_brand_mark.dart';

class FirstRunScaffold extends StatelessWidget {
  const FirstRunScaffold({
    required this.title,
    required this.step,
    required this.body,
    required this.footer,
    this.subtitle,
    this.centerHeader = false,
    this.showBrandMark = false,
    super.key,
  });

  final String title;
  final int step;
  final String? subtitle;
  final Widget body;
  final Widget footer;
  final bool centerHeader;
  final bool showBrandMark;

  @override
  Widget build(BuildContext context) {
    final subtitleText = subtitle;
    final headerAlign = centerHeader ? TextAlign.center : TextAlign.start;
    final scheme = Theme.of(context).colorScheme;
    const padding = EdgeInsets.fromLTRB(
      AppSpacing.pageGutterCompact,
      AppSpacing.md,
      AppSpacing.pageGutterCompact,
      AppSpacing.xl,
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
                          FirstRunStepIndicator(step: step),
                          const SizedBox(height: AppSpacing.md),
                          if (showBrandMark) ...[
                            const Center(child: OnboardingBrandMark()),
                            const SizedBox(height: AppSpacing.sm),
                          ],
                          Text(
                            title,
                            textAlign: headerAlign,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          if (subtitleText != null) ...[
                            const SizedBox(height: AppSpacing.xxs),
                            Text(
                              subtitleText,
                              textAlign: headerAlign,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.lg),
                          body,
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.md),
                            child: footer,
                          ),
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
