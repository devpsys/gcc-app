import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_availability.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_condition_grade.dart';

/// One equipment entry captured for a shop.
///
/// Mutable only through [copyWith]. [reference] is assigned when the asset is
/// added to the draft so the collapsed row can identify it (`AST-0912`), which
/// matches the asset design's second frame.
class AssetDraft extends Equatable {
  const AssetDraft({
    this.ordinal = 0,
    this.category,
    this.make = '',
    this.capacity = '',
    this.model = '',
    this.year = '',
    this.serial = '',
    this.quantity = 1,
    this.condition,
    this.availability,
  });

  /// Monotonic ordinal used to build [reference]. Zero means "not added yet".
  final int ordinal;
  final AssetCategory? category;
  final String make;
  final String capacity;
  final String model;
  final String year;
  final String serial;
  final int quantity;
  final AssetConditionGrade? condition;
  final AssetAvailability? availability;

  /// `AST-0912` style identifier. Ordinals are 1-based and allocated as assets
  /// are appended, so the in-progress asset shows the reference it will take.
  String get displayReference =>
      'AST-${(911 + ordinal).toString().padLeft(4, '0')}';

  /// Whether the in-progress asset has been given its reference yet.
  bool get hasReference => ordinal > 0;

  /// Nothing has been typed yet, so the step shows its empty state rather
  /// than a blank form.
  bool get isEmpty =>
      category == null &&
      make.trim().isEmpty &&
      capacity.trim().isEmpty &&
      model.trim().isEmpty &&
      year.trim().isEmpty &&
      serial.trim().isEmpty &&
      condition == null &&
      availability == null;

  /// A single asset is only complete once the fields the design marks
  /// required have been filled.
  bool get isComplete =>
      category != null && capacity.trim().isNotEmpty && condition != null;

  int get issueCount {
    var count = 0;
    if (category == null) {
      count += 1;
    }
    if (capacity.trim().isEmpty) {
      count += 1;
    }
    if (condition == null) {
      count += 1;
    }
    return count;
  }

  AssetDraft copyWith({
    int? ordinal,
    AssetCategory? category,
    bool clearCategory = false,
    String? make,
    String? capacity,
    String? model,
    String? year,
    String? serial,
    int? quantity,
    AssetConditionGrade? condition,
    bool clearCondition = false,
    AssetAvailability? availability,
    bool clearAvailability = false,
  }) {
    return AssetDraft(
      ordinal: ordinal ?? this.ordinal,
      category: clearCategory ? null : category ?? this.category,
      make: make ?? this.make,
      capacity: capacity ?? this.capacity,
      model: model ?? this.model,
      year: year ?? this.year,
      serial: serial ?? this.serial,
      quantity: quantity ?? this.quantity,
      condition: clearCondition ? null : condition ?? this.condition,
      availability: clearAvailability
          ? null
          : availability ?? this.availability,
    );
  }

  @override
  List<Object?> get props => [
    ordinal,
    category,
    make,
    capacity,
    model,
    year,
    serial,
    quantity,
    condition,
    availability,
  ];
}
