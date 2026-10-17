import 'package:equatable/equatable.dart';

/// Where a capture's media pipeline currently is.
///
/// The five values are the compression sheet's five design frames. None of them
/// is a money state: the design is explicit that a pending bounty is not held
/// funds, so nothing here may use a lock glyph.
enum MediaPipelineStage {
  /// The clip is being compressed on the phone.
  compressing,

  /// Compressed and waiting for a usable connection.
  queued,

  /// Bytes are moving.
  uploading,

  /// The phone has no room to stage the upload.
  storageLow,

  /// Compressed, but the battery is too low to keep the radio on.
  batteryLow,
}

/// How a compression option is presented in the quality selector.
enum CompressionQuality {
  /// Best review quality for the smallest file.
  smallest,

  /// Sharper, larger file.
  balanced,

  /// The untouched recording.
  original,
}

/// A selectable compression target with the figures the design prints.
class CompressionOption extends Equatable {
  const CompressionOption({
    required this.quality,
    required this.sizeLabel,
    required this.durationLabel,
    this.recommended = false,
    this.warningLabel,
  });

  final CompressionQuality quality;

  /// Upload size, e.g. `5.2 MB`.
  final String sizeLabel;

  /// Transfer estimate on a field connection, e.g. `≈1 min 40 s on 3G`.
  final String durationLabel;

  /// Carries the `Recommended` chip.
  final bool recommended;

  /// Caution line, e.g. `Not recommended on 3G`.
  final String? warningLabel;

  @override
  List<Object?> get props => [
    quality,
    sizeLabel,
    durationLabel,
    recommended,
    warningLabel,
  ];
}

/// One row in the pipeline's status list.
class PipelineStep extends Equatable {
  const PipelineStep({
    required this.label,
    required this.state,
    this.detail,
    this.progress,
    this.sizePair,
  });

  final String label;

  /// Drives the glyph and the row's tone.
  final PipelineStepState state;

  /// Right-aligned monospace value, e.g. `65%`.
  final String? detail;

  /// Determinate progress 0 to 1 for the running step.
  final double? progress;

  /// Before/after sizes for a compression step, rendered with the original
  /// struck through so the saving is legible at a glance.
  final (String, String)? sizePair;

  @override
  List<Object?> get props => [label, state, detail, progress, sizePair];
}

/// A step's status glyph and tone.
enum PipelineStepState {
  /// Finished.
  done,

  /// Running now.
  running,

  /// Not started.
  pending,

  /// Waiting on a condition the agent can see (battery, connection).
  waiting,
}
