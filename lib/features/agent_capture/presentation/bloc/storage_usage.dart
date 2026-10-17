import 'package:equatable/equatable.dart';

/// One line in the storage breakdown: what is holding the phone's space.
class StorageUsage extends Equatable {
  const StorageUsage({
    required this.labelKey,
    required this.sizeLabel,
    this.clearable = false,
  });

  /// Which localized label to use: `history`, `photos` or `maps`.
  final String labelKey;

  /// Monospace size, e.g. `1.4 GB`.
  final String sizeLabel;

  /// Whether this row offers a `Clear` action.
  final bool clearable;

  @override
  List<Object?> get props => [labelKey, sizeLabel, clearable];
}
