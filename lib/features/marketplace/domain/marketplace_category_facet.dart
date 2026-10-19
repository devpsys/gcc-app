import 'package:equatable/equatable.dart';

/// One category row on the filter sheet and the empty-state popular list.
class MarketplaceCategoryFacet extends Equatable {
  const MarketplaceCategoryFacet({required this.name, required this.count});

  final String name;
  final int count;

  @override
  List<Object?> get props => [name, count];
}
