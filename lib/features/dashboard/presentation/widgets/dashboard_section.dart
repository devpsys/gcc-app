import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_notice_panel.dart';
import 'package:gcc_app/core/widgets/skeleton_list_card.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({
    required this.child,
    this.title,
    this.loading = false,
    this.errorMessage,
    this.onRetry,
    this.trailing,
    this.titleStyle,
    this.framed = true,
    this.contentPadding = const EdgeInsets.all(AppSpacing.md),
    super.key,
  });

  final String? title;
  final Widget child;
  final bool loading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final bool framed;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final heading = title;
    final action = trailing;
    final error = errorMessage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (heading != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  heading,
                  style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (action != null) ...[
                const SizedBox(width: AppSpacing.sm),
                action,
              ],
            ],
          ),
        if (heading != null) const SizedBox(height: AppSpacing.sm),
        if (loading)
          const SkeletonListCard()
        else if (error != null)
          AppNoticePanel(
            icon: Icons.error_outline,
            title: error,
            message: error,
            actionLabel: onRetry == null ? null : context.l10n.dashboardRetry,
            onAction: onRetry,
          )
        else if (framed)
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(color: context.semanticColors.border),
            ),
            child: Padding(padding: contentPadding, child: child),
          )
        else
          child,
      ],
    );
  }
}
