import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../data/models/advance.dart';
import '../../../data/models/driver.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/vehicle.dart';
import '../../../data/repositories/repository_providers.dart';
import 'driver_trip_controller.dart';

part 'driver_providers.g.dart';

/// Per-trip expenses for lists and the advance-balance chip.
@riverpod
Future<List<Expense>> tripExpenses(Ref ref, String tripId) {
  return ref.watch(expenseRepositoryProvider).list(tripId);
}

/// Per-trip advance history (requested/approved/paid/rejected).
@riverpod
Future<List<Advance>> tripAdvances(Ref ref, String tripId) {
  return ref.watch(advanceRepositoryProvider).list(tripId);
}

/// Running advance balance: trip advanceGiven minus recorded expenses.
@riverpod
Future<int> advanceBalance(Ref ref, String driverId) async {
  final DriverTripState tripState =
      await ref.watch(driverTripProvider(driverId).future);
  final trip = tripState.activeTrip;
  if (trip == null) return 0;
  final List<Expense> expenses =
      await ref.watch(tripExpensesProvider(trip.id).future);
  final int total = expenses.fold(0, (sum, e) => sum + e.amount);
  return trip.advanceGiven - total;
}

/// Earnings aggregate for the earnings tab.
@riverpod
Future<EarningsSummary> driverEarnings(Ref ref, String driverId) {
  return ref.watch(driverRepositoryProvider).getEarnings(driverId);
}

/// Driver record + vehicle documents for the documents tab.
@riverpod
Future<({Driver driver, List<VehicleDoc> docs})> driverDocuments(
  Ref ref,
  String driverId,
) async {
  final Driver driver =
      await ref.watch(driverRepositoryProvider).getDriver(driverId);
  final List<VehicleDoc> docs = await ref
      .watch(driverRepositoryProvider)
      .getVehicleDocs(driver.vehicleReg ?? '');
  return (driver: driver, docs: docs);
}

/// Counts queued-but-unsent driver actions for the sync pill badge.
@riverpod
int driverPendingCount(Ref ref) {
  final actions = ref.watch(offlineQueueProvider);
  return actions
      .where((OfflineAction a) => a.status != OfflineActionStatus.done)
      .length;
}
