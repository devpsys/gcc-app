import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The record control: a ring, an inner disc that becomes a stop square, and
/// the countdown ring drawn over the top while recording.
///
/// The 96 px diameter is fixed at every viewport. A 390 px screen must not
/// produce a bigger target or tighter framing — the plan treats that as an
/// inviolable rule for this control.
class RecordControl extends StatelessWidget {
  const RecordControl({
    required this.recording,
    required this.elapsed,
    required this.onTap,
    super.key,
  });

  final bool recording;

  /// Seconds elapsed in the current clip, capped at [maxSeconds].
  final int elapsed;
  final VoidCallback onTap;

  /// The design's minimum clip length; a shorter clip cannot be audited.
  static const int maxSeconds = 30;

  /// Fixed across viewports — see the class docs.
  static const double diameter = 96;

  static const double _innerDisc = 64;
  static const double _ringWidth = 3;

  /// Seconds from the end at which the design switches to its warning tone.
  static const int almostDoneAt = 5;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final progress = (elapsed / maxSeconds).clamp(0.0, 1.0);
    final almostDone = recording && elapsed >= maxSeconds - almostDoneAt;

    return Semantics(
      button: true,
      label: recording ? l10n.captureStopRecording : l10n.captureStartRecording,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
            child: recording
                ? Text(
                    _elapsedLabel(elapsed),
                    style: AppTextStyles.tabular(
                      Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: almostDone ? colors.warning : _onStageForeground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Text(
                    l10n.captureClipLengthLabel,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: _onStageForeground,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
          ),
          GestureDetector(
            onTap: onTap,
            child: SizedBox.square(
              key: const Key('capture.recordControl'),
              dimension: diameter,
              child: CustomPaint(
                painter: _CountdownRingPainter(
                  progress: recording ? progress : 0,
                  progressColor: almostDone ? colors.warning : scheme.primary,
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: _innerDisc,
                    height: _innerDisc,
                    decoration: BoxDecoration(
                      // Idle is a translucent disc; recording squares off into
                      // a solid stop button.
                      color: recording ? scheme.error : _idleDisc,
                      borderRadius: BorderRadius.circular(
                        recording ? AppRadii.button : AppRadii.pill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (recording) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.captureRecordingElapsed(elapsed),
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: _onStageForeground),
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              almostDone ? l10n.captureAlmostDone : l10n.captureRecordingHint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: almostDone ? colors.warning : _onStageForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Muted white the design draws for anything read over the dark stage.
  static const Color _onStageForeground = Color(0xB3FFFFFF);

  /// The idle disc at roughly half opacity.
  static const Color _idleDisc = Color(0x80FFFFFF);

  /// `00:07` — zero-padded to the design's clock format.
  String _elapsedLabel(int seconds) {
    final clamped = seconds.clamp(0, maxSeconds);
    final minutes = clamped ~/ 60;
    final rest = clamped % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${rest.toString().padLeft(2, '0')}';
  }
}

/// Draws the countdown ring that sweeps clockwise over the 30 second clip.
class _CountdownRingPainter extends CustomPainter {
  const _CountdownRingPainter({
    required this.progress,
    required this.progressColor,
  });

  final double progress;
  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) {
      return;
    }
    final radius =
        (math.min(size.width, size.height) / 2) - RecordControl._ringWidth;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = RecordControl._ringWidth * 2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_CountdownRingPainter old) =>
      old.progress != progress || old.progressColor != progressColor;
}
