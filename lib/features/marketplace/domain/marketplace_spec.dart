import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_spec_kind.dart';

/// One specification. [value] is the listing's own text.
class MarketplaceSpec extends Equatable {
  const MarketplaceSpec({required this.kind, required this.value});

  final MarketplaceSpecKind kind;
  final String value;

  @override
  List<Object?> get props => [kind, value];
}
