import 'package:equatable/equatable.dart';

/// One storage category on the profile screen.
class StorageCategory extends Equatable {
  const StorageCategory({
    required this.label,
    required this.size,
    required this.clearable,
  });

  final String label;

  /// e.g. `1.8 GB`.
  final String size;

  /// Whether this category offers a clear action.
  ///
  /// There is no storage backend yet, so the profile withholds clear buttons
  /// rather than drawing controls that cannot act.
  final bool clearable;

  @override
  List<Object?> get props => [label, size, clearable];
}
