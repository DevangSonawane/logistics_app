import '../../mock/mock_business_data.dart';
import '../../mock/mock_delay.dart';
import '../models/dashboard.dart';
import 'dashboard_repository.dart';

/// Mock dashboard. Branch chips scale the company-wide seed so switching
/// branches visibly changes the numbers (real filtering lands with the API).
class MockDashboardRepository implements DashboardRepository {
  static const Map<String, double> _branchShare = {
    'all': 1,
    'br-mumbai': 0.45,
    'br-pune': 0.3,
    'br-chennai': 0.15,
    'br-delhi': 0.1,
  };

  double _share(String branchId) => _branchShare[branchId] ?? 1;

  @override
  Future<DashboardKpis> kpis(String branchId) async {
    await mockDelay();
    throwIfChaos();
    final DashboardKpis base = MockBusinessData.kpis();
    final double share = _share(branchId);
    int scaled(int v) => (v * share).round();
    return base.copyWith(
      tripsToday: scaled(base.tripsToday),
      running: scaled(base.running),
      delayed: scaled(base.delayed),
      delivered: scaled(base.delivered),
      revenueToday: scaled(base.revenueToday),
      revenueMonth: scaled(base.revenueMonth),
      collectionsMonth: scaled(base.collectionsMonth),
      outstanding: scaled(base.outstanding),
      cashBank: scaled(base.cashBank),
    );
  }

  @override
  Future<List<TrendPoint>> trend() async {
    await mockDelay();
    return MockBusinessData.trend();
  }

  @override
  Future<List<LaneMargin>> topLanes() async {
    await mockDelay();
    return MockBusinessData.topLanes();
  }

  @override
  Future<List<CustomerMargin>> bottomCustomers() async {
    await mockDelay();
    return MockBusinessData.bottomCustomers();
  }

  @override
  Future<List<AttentionItem>> attention() async {
    await mockDelay();
    return MockBusinessData.attention();
  }

  @override
  Future<String> brief() async {
    await mockDelay();
    return MockBusinessData.brief();
  }

  @override
  Future<DataAnswer> ask(String query) async {
    // Typing delay so the answer animation feels real.
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return MockBusinessData.ask(query);
  }

  @override
  Future<int?> contractRate(String from, String to, String vehicle) async {
    await mockDelay();
    return MockBusinessData.rateFor(from, to, vehicle);
  }
}
