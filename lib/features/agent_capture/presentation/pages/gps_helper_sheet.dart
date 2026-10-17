import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_acquire_progress.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_accuracy_gauge.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_guidance_list.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_helper_actions.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_helper_header.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_helper_primary_actions.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_helper_view.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_permission_steps_card.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_signal_figure.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_status_pill.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/manual_coordinates_form.dart';

/// Presents the GPS helper in [view]. Returns the chosen result, or null when
/// dismissed without acting.
Future<GpsHelperResult?> showGpsHelper(
  BuildContext context, {
  required GpsHelperView view,
}) {
  return Navigator.of(context).push<GpsHelperResult>(
    MaterialPageRoute<GpsHelperResult>(
      builder: (context) => GpsHelperSheet(
        initialView: view,
        onExit: (result) => Navigator.of(context).pop(result),
      ),
    ),
  );
}

/// Full-screen GPS helper.
///
/// Four views share one sheet so the agent never loses their place in the
/// capture flow: a weak signal with guidance, an acquired fix, a denied
/// permission, and manual coordinate entry.
///
/// There is no location service wired up, so accuracy is a presentation value
/// rather than a reading — the sheet advances between views in response to the
/// agent's own taps.
class GpsHelperSheet extends StatefulWidget {
  const GpsHelperSheet({
    required this.initialView,
    required this.onExit,
    super.key,
  });

  final GpsHelperView initialView;
  final ValueChanged<GpsHelperResult?> onExit;

  @override
  State<GpsHelperSheet> createState() => _GpsHelperSheetState();
}

class _GpsHelperSheetState extends State<GpsHelperSheet> {
  late GpsHelperView _view = widget.initialView;

  /// Counts up while the agent waits for a fix, then reports success.
  int _elapsed = 0;

  Timer? _acquireTimer;

  /// Set once the agent has tried to save an out-of-range coordinate.
  bool _showCoordinateErrors = false;

  static const double _weakAccuracy = 38;
  static const double _acquiredAccuracy = 9;
  static const double _targetAccuracy = 25;

  String _latitude = '';
  String _longitude = '';

  void _goTo(GpsHelperView view) => setState(() => _view = view);

  /// Walks the short acquire countdown, then hands the agent a fix.
  void _retry() {
    _acquireTimer?.cancel();
    setState(() => _elapsed = 1);
    _acquireTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_elapsed >= 2) {
        timer.cancel();
        setState(() => _view = GpsHelperView.fixAcquired);
        return;
      }
      setState(() => _elapsed += 1);
    });
  }

  @override
  void dispose() {
    _acquireTimer?.cancel();
    super.dispose();
  }

  bool get _latitudeValid => _inRange(_latitude, 90);
  bool get _longitudeValid => _inRange(_longitude, 180);

  static bool _inRange(String value, double limit) {
    if (value.trim().isEmpty) {
      return true;
    }
    final parsed = double.tryParse(value.trim());
    return parsed == null ? false : parsed.abs() <= limit;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          widget.onExit(null);
        }
      },
      child: Scaffold(
        // The view's own Column must be the direct child of a bounded box:
        // nesting it in another Column would hand it unbounded height and its
        // Expanded scroll region could not lay out.
        body: SafeArea(child: _build()),
      ),
    );
  }

  Widget _build() => switch (_view) {
    GpsHelperView.signalWeak => _signalView(good: false),
    GpsHelperView.fixAcquired => _signalView(good: true),
    GpsHelperView.permissionDenied => _permissionView(),
    GpsHelperView.manualEntry => _manualView(),
  };

  /// Weak-signal and acquired views share the gauge, guidance and actions;
  /// only the tone and the copy differ.
  Widget _signalView({required bool good}) {
    final l10n = context.l10n;
    final accuracy = good ? _acquiredAccuracy : _weakAccuracy;
    final acquiring = !good && _elapsed > 0 && _elapsed < 2;
    final progress = good
        ? 1.0
        : (1 - (accuracy / (_targetAccuracy * 2))).clamp(0.0, 1.0);
    return Column(
      children: [
        GpsHelperHeader(
          title: l10n.gpsHelperTitle,
          onClose: () => widget.onExit(null),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GpsStatusPill(
                    label: good ? l10n.gpsSignalGood : l10n.gpsSignalWeak,
                    good: good,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Center(
                  child: GpsAccuracyGauge(
                    progress: progress,
                    valueLabel: l10n.gpsAccuracyValue(accuracy.round()),
                    targetLabel: l10n.gpsAccuracyTarget,
                  ),
                ),
                if (!good && !acquiring) GpsSignalFigure(),
                if (!good) ...[
                  Text(
                    l10n.gpsStepOpenSky,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  GpsGuidanceList(
                    steps: [
                      l10n.gpsStepOpenSky,
                      l10n.gpsStepHoldStill,
                      l10n.gpsStepAwayFromMetal,
                    ],
                  ),
                ],
                if (acquiring) ...[
                  const SizedBox(height: AppSpacing.sm),
                  GpsAcquireProgress(
                    label: l10n.gpsAcquiring,
                    elapsed: _elapsed,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (good)
          GpsHelperPrimaryActions(
            primaryLabel: l10n.gpsContinueWithFix,
            onPrimary: () => widget.onExit(GpsHelperResult.accept),
            textLabel: l10n.gpsContinueWithoutFix,
            onText: () => widget.onExit(GpsHelperResult.continueWithoutFix),
          )
        else
          GpsHelperActions(
            secondaryLabel: l10n.gpsTryAgain,
            onSecondary: _retry,
            textLabel: l10n.gpsEnterCoordinates,
            onText: () => _goTo(GpsHelperView.manualEntry),
          ),
      ],
    );
  }

  Widget _permissionView() {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        GpsHelperHeader(
          title: l10n.gpsHelperTitle,
          onClose: () => widget.onExit(null),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xs),
                Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                      border: Border.all(color: context.semanticColors.border),
                    ),
                    child: SizedBox.square(
                      dimension: AppDimensions.noticeIcon * 1.6,
                      child: Icon(
                        Icons.location_off_outlined,
                        size: AppDimensions.iconLg * 2,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.gpsPermissionTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.gpsPermissionBody,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.md),
                GpsPermissionStepsCard(
                  title: l10n.gpsHowToAllow,
                  steps: [
                    l10n.gpsAllowStep1,
                    l10n.gpsAllowStep2,
                    l10n.gpsAllowStep3,
                  ],
                  footnote: l10n.gpsAllowFootnote,
                ),
              ],
            ),
          ),
        ),
        GpsHelperPrimaryActions(
          primaryLabel: l10n.gpsTurnOnLocation,
          onPrimary: () => _goTo(GpsHelperView.signalWeak),
          textLabel: l10n.gpsEnterCoordinates,
          onText: () => _goTo(GpsHelperView.manualEntry),
        ),
      ],
    );
  }

  Widget _manualView() {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final showErrors = _showCoordinateErrors;
    return Column(
      children: [
        GpsHelperHeader(
          title: l10n.gpsCoordinatesTitle,
          onClose: () => widget.onExit(null),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.gpsCoordinatesHeading,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.gpsCoordinatesHelper,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.md),
                ManualCoordinatesForm(
                  latitudeLabel: l10n.gpsLatitude,
                  longitudeLabel: l10n.gpsLongitude,
                  northSuffix: l10n.gpsDirectionNorth,
                  eastSuffix: l10n.gpsDirectionEast,
                  latitudeError: showErrors && !_latitudeValid
                      ? l10n.gpsLatitudeRange
                      : null,
                  longitudeError: showErrors && !_longitudeValid
                      ? l10n.gpsLongitudeRange
                      : null,
                  onChanged:
                      ({required String latitude, required String longitude}) {
                        _latitude = latitude;
                        _longitude = longitude;
                        if (_showCoordinateErrors) {
                          setState(() {});
                        }
                      },
                ),
              ],
            ),
          ),
        ),
        GpsHelperPrimaryActions(
          primaryLabel: l10n.gpsSaveCoordinates,
          onPrimary: () {
            setState(() => _showCoordinateErrors = true);
            if (_latitudeValid && _longitudeValid) {
              widget.onExit(GpsHelperResult.useCoordinates);
            }
          },
          textLabel: l10n.gpsDiscardCoordinates,
          onText: () => _goTo(GpsHelperView.signalWeak),
        ),
      ],
    );
  }
}
