import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';

/// Presentation-layer contract for the agent's assignment.
///
/// Assignments come from a supervisor, so this has no backend contract yet. It
/// exists so the work list never reaches for data directly and so a real
/// implementation can replace the unwired one without touching a widget.
abstract interface class AssignedShopsGateway {
  /// Today's route figures. Unwired returns null.
  Future<RouteSummary?> loadRouteSummary();

  /// The stops assigned to this agent. Unwired returns empty.
  Future<List<AssignedShop>> loadShops();

  /// How many assigned shops currently need attention. Unwired returns zero.
  Future<int> loadAttentionCount();

  /// How many distinct markets the assignment covers. Unwired returns zero.
  Future<int> loadMarketCount();

  /// How many of [stopCount] shops have finished uploading.
  Future<int> loadUploadedCount(int stopCount);
}
