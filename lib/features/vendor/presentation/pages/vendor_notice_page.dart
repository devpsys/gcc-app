import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_filter.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_notice_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_notice_state.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_notice_filter_bar.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/vendor_notice_row.dart';

class VendorNoticePage extends StatelessWidget {
  const VendorNoticePage({
    required this.state,
    required this.onOpenRequests,
    required this.onOpenWallet,
    super.key,
  });

  final VendorNoticeReady state;
  final VoidCallback onOpenRequests;
  final VoidCallback onOpenWallet;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VendorNoticeCubit>();
    final l10n = context.l10n;
    final visible = state.visible;
    final decision = state.filter == VendorNoticeFilter.requests
        ? state.decision
        : null;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: cubit.markAllRead,
                child: Text(l10n.vendorNoticeMarkRead),
              ),
            ),
          ),
        ),
        VendorNoticeFilterBar(
          selected: state.filter,
          labelOf: (filter) => _label(context, filter),
          onSelected: cubit.select,
        ),
        if (decision != null) _decision(context, decision),
        Expanded(
          child: ListView(
            primary: false,
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            children: [
              for (final section in _sections(context, visible)) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xs,
                  ),
                  child: Text(
                    section.heading,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                for (final notice in section.notices)
                  VendorNoticeRow(
                    notice: notice,
                    smsLabel: l10n.vendorNoticeSms,
                    unreadLabel: l10n.vendorNoticeUnread,
                    stackedTime: state.filter == VendorNoticeFilter.money,
                    onOpen: notice.opensRequests ? onOpenRequests : null,
                  ),
              ],
              if (state.filter == VendorNoticeFilter.requests) _sms(context),
              if (state.filter == VendorNoticeFilter.money) _wallet(context),
            ],
          ),
        ),
      ],
    );
  }

  String _label(BuildContext context, VendorNoticeFilter filter) {
    final l10n = context.l10n;
    final name = switch (filter) {
      VendorNoticeFilter.all => l10n.vendorNoticeAll,
      VendorNoticeFilter.requests => l10n.vendorNoticeRequests,
      VendorNoticeFilter.money => l10n.vendorNoticeMoney,
    };
    final counted = filter == VendorNoticeFilter.all || filter == state.filter;
    if (!counted) {
      return name;
    }
    return l10n.vendorNoticeTab(name, state.countOf(filter));
  }

  List<({String heading, List<VendorNotice> notices})> _sections(
    BuildContext context,
    List<VendorNotice> visible,
  ) {
    final l10n = context.l10n;
    if (state.filter == VendorNoticeFilter.requests) {
      return [(heading: l10n.vendorNoticeActiveRequests, notices: visible)];
    }
    if (state.filter == VendorNoticeFilter.money) {
      return [(heading: l10n.vendorNoticeAudit, notices: visible)];
    }
    final sections = <({String heading, List<VendorNotice> notices})>[];
    for (final notice in visible) {
      if (sections.isEmpty || sections.last.heading != notice.group) {
        sections.add((heading: notice.group, notices: [notice]));
      } else {
        sections.last.notices.add(notice);
      }
    }
    return sections;
  }

  Widget _decision(BuildContext context, VendorNotice decision) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final deadline = decision.decisionDeadline ?? '';
    return ColoredBox(
      color: colors.warningContainer,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.vendorNoticeDecision,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colors.warning,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              l10n.vendorNoticeWindow(deadline),
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.warning),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sms(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(color: colors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                  children: [
                    TextSpan(text: l10n.vendorNoticeSmsBefore),
                    TextSpan(
                      text: l10n.vendorNoticeSmsAccept,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextSpan(text: l10n.vendorNoticeSmsMiddle),
                    TextSpan(
                      text: l10n.vendorNoticeSmsReject,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextSpan(text: l10n.vendorNoticeSmsAfter),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppSecondaryButton(
                label: l10n.vendorNoticeReply,
                onPressed: null,
                disabledReason: l10n.dashboardActionUnavailable,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _wallet(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(color: colors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: AppDimensions.iconMd,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.vendorNoticeWalletNote,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    TextButton(
                      onPressed: onOpenWallet,
                      child: Text(l10n.vendorNoticeOpenWallet),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
