import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/assigned_shops_gateway.dart';

/// Reports nothing rather than inventing an assignment.
///
/// There is no assignment service yet, so this returns empty. That means the
/// screen shows its empty state — accurate, since no supervisor has assigned
/// this agent anything the app knows about.
final class UnwiredAssignedShopsGateway implements AssignedShopsGateway {
  const UnwiredAssignedShopsGateway();

  @override
  Future<RouteSummary?> loadRouteSummary() async => null;

  @override
  Future<List<AssignedShop>> loadShops() async => const [];

  @override
  Future<int> loadAttentionCount() async => 0;

  @override
  Future<int> loadMarketCount() async => 0;

  @override
  Future<int> loadUploadedCount(int stopCount) async => 0;
}
