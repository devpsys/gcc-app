import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_mark.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_piece.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_tone.dart';

/// One inbox row. The SMS mark is a label, not a second tap target.
class VendorNoticeRow extends StatelessWidget {
  const VendorNoticeRow({
    required this.notice,
    required this.smsLabel,
    required this.unreadLabel,
    required this.stackedTime,
    this.onOpen,
    super.key,
  });

  final VendorNotice notice;
  final String smsLabel;
  final String unreadLabel;
  final bool stackedTime;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = _toneColors(context);
    return Semantics(
      button: onOpen != null,
      label: notice.unread ? '${notice.title}. $unreadLabel' : notice.title,
      child: InkWell(
        onTap: onOpen,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.topBarHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _avatar(context, tone),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notice.title,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.xxs,
                        children: [
                          for (final piece in notice.detail)
                            _piece(context, piece),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (stackedTime && notice.timeDay != null)
                      Text(
                        notice.timeDay!,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                    Text(
                      notice.time,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.bodySmall!
                            .copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                    if (notice.unread) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const SizedBox.square(dimension: AppSpacing.xs),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar(BuildContext context, ({Color color, Color background}) tone) {
    final colors = context.semanticColors;
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: tone.background,
            shape: BoxShape.circle,
            border: notice.tone == VendorNoticeTone.held
                ? Border.all(color: colors.heldFunds)
                : null,
          ),
          child: SizedBox.square(
            dimension: AppSpacing.xxxl,
            child: Icon(
              _icon(notice.mark),
              size: AppDimensions.iconMd,
              color: tone.color,
            ),
          ),
        ),
        if (notice.sms)
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.infoContainer,
              borderRadius: BorderRadius.circular(AppRadii.input),
              border: Border.all(color: colors.info),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              child: Text(
                smsLabel,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: colors.info, fontWeight: FontWeight.w700),
              ),
            ),
          ),
      ],
    );
  }

  Widget _piece(BuildContext context, VendorNoticePiece piece) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final style = piece.locked
        ? Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colors.heldFunds, fontWeight: FontWeight.w700)
        : piece.emphasis
        ? AppTextStyles.mono(
            Theme.of(context).textTheme.bodySmall!
                .copyWith(color: scheme.onSurface, fontWeight: FontWeight.w600),
          )
        : Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant);
    if (!piece.locked) {
      return Text(piece.text, style: style);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.lock, size: AppDimensions.iconSm, color: colors.heldFunds),
        const SizedBox(width: AppSpacing.xxs),
        Text(piece.text, style: style),
      ],
    );
  }

  ({Color color, Color background}) _toneColors(BuildContext context) {
    final colors = context.semanticColors;
    return switch (notice.tone) {
      VendorNoticeTone.info => (
        color: colors.info,
        background: colors.infoContainer,
      ),
      VendorNoticeTone.danger => (
        color: colors.danger,
        background: colors.dangerContainer,
      ),
      VendorNoticeTone.warning => (
        color: colors.warning,
        background: colors.warningContainer,
      ),
      VendorNoticeTone.success => (
        color: colors.success,
        background: colors.successContainer,
      ),
      VendorNoticeTone.held => (
        color: colors.heldFunds,
        background: colors.heldFundsContainer,
      ),
    };
  }

  IconData _icon(VendorNoticeMark mark) {
    return switch (mark) {
      VendorNoticeMark.message => Icons.chat_bubble_outline,
      VendorNoticeMark.alert => Icons.warning_amber,
      VendorNoticeMark.home => Icons.home_outlined,
      VendorNoticeMark.check => Icons.check,
      VendorNoticeMark.send => Icons.send,
      VendorNoticeMark.lock => Icons.lock,
    };
  }
}
