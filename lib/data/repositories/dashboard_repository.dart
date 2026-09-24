import '../models/dashboard.dart';

/// Owner dashboard reads: KPIs (branch-scaled), trend, margins, brief,
/// ask-your-data and contract rate lookup.
abstract class DashboardRepository {
  Future<DashboardKpis> kpis(String branchId);
  Future<List<TrendPoint>> trend();
  Future<List<LaneMargin>> topLanes();
  Future<List<CustomerMargin>> bottomCustomers();
  Future<List<AttentionItem>> attention();
  Future<String> brief();
  Future<DataAnswer> ask(String query);
  Future<int?> contractRate(String from, String to, String vehicle);
}
