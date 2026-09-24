import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/approval.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/dashboard.dart';
import '../../../data/models/exception.dart';
import '../../../data/models/finance.dart';
import '../../../data/models/notification.dart';
import '../../../data/models/order.dart';
import '../../../data/models/trip.dart';
import '../../../data/models/vehicle.dart';
import '../../../data/repositories/repository_providers.dart';

part 'owner_providers.g.dart';

@riverpod
Future<DashboardKpis> ownerKpis(Ref ref, String branchId) {
  return ref.watch(dashboardRepositoryProvider).kpis(branchId);
}

@riverpod
Future<List<TrendPoint>> revenueTrend(Ref ref) {
  return ref.watch(dashboardRepositoryProvider).trend();
}

@riverpod
Future<List<LaneMargin>> topLanes(Ref ref) {
  return ref.watch(dashboardRepositoryProvider).topLanes();
}

@riverpod
Future<List<CustomerMargin>> bottomCustomers(Ref ref) {
  return ref.watch(dashboardRepositoryProvider).bottomCustomers();
}

@riverpod
Future<List<AttentionItem>> attention(Ref ref) {
  return ref.watch(dashboardRepositoryProvider).attention();
}

@riverpod
Future<String> dailyBrief(Ref ref) {
  return ref.watch(dashboardRepositoryProvider).brief();
}

@riverpod
Future<List<ApprovalItem>> approvalInbox(Ref ref) {
  return ref.watch(approvalRepositoryProvider).list();
}

@riverpod
Future<int> pendingApprovalsCount(Ref ref) async {
  final List<ApprovalItem> items =
      await ref.watch(approvalInboxProvider.future);
  return items.where((a) => a.status == ApprovalStatus.pending).length;
}

@riverpod
Future<int> unreadNotificationsCount(Ref ref) {
  return ref.watch(notificationRepositoryProvider).unreadCount();
}

@riverpod
Future<List<Trip>> liveTrips(Ref ref) {
  return ref.watch(tripRepositoryProvider).runningTrips();
}

@riverpod
Future<List<Vehicle>> fleetVehicles(Ref ref) {
  return ref.watch(vehicleRepositoryProvider).list();
}

@riverpod
Future<List<ExceptionItem>> openExceptions(Ref ref) {
  return ref.watch(exceptionRepositoryProvider).list();
}

@riverpod
Future<List<AgeingBucket>> ageingBuckets(Ref ref) {
  return ref.watch(financeRepositoryProvider).ageing();
}

@riverpod
Future<List<BankAccount>> bankBalances(Ref ref) {
  return ref.watch(financeRepositoryProvider).bankBalances();
}

@riverpod
Future<GstSummary> gstSummary(Ref ref) {
  return ref.watch(financeRepositoryProvider).gstSummary();
}

@riverpod
Future<List<LedgerEntry>> daybook(Ref ref) {
  return ref.watch(financeRepositoryProvider).dayBook();
}

@riverpod
Future<List<TripPnl>> tripPnl(Ref ref) {
  return ref.watch(financeRepositoryProvider).tripPnl();
}

@riverpod
Future<List<PnlLine>> pnl(Ref ref) {
  return ref.watch(financeRepositoryProvider).pnl();
}

@riverpod
Future<List<Customer>> customers(Ref ref) {
  return ref.watch(customerRepositoryProvider).list();
}

@riverpod
Future<List<LedgerEntry>> customerLedger(Ref ref, String customerId) {
  return ref.watch(financeRepositoryProvider).customerLedger(customerId);
}

@riverpod
Future<List<LedgerEntry>> vendorLedger(Ref ref, String vendor) {
  return ref.watch(financeRepositoryProvider).vendorLedger(vendor);
}

@riverpod
Future<int?> contractRate(
  Ref ref,
  String from,
  String to,
  String vehicle,
) {
  return ref.watch(dashboardRepositoryProvider).contractRate(
        from,
        to,
        vehicle,
      );
}

@riverpod
Future<List<Order>> allOrders(Ref ref) {
  return ref.watch(orderRepositoryProvider).list();
}

@riverpod
Future<List<AppNotification>> notifications(Ref ref) {
  return ref.watch(notificationRepositoryProvider).list();
}
