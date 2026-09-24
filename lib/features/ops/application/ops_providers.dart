import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/driver.dart';
import '../../../data/models/exception.dart';
import '../../../data/models/hire.dart';
import '../../../data/models/order.dart';
import '../../../data/models/trip.dart';
import '../../../data/models/vehicle.dart';
import '../../../data/repositories/repository_providers.dart';

part 'ops_providers.g.dart';

@riverpod
Future<List<Order>> ordersByStatus(Ref ref, OrderStatus status) {
  return ref.watch(orderRepositoryProvider).list(status);
}

@riverpod
Future<List<Order>> allOpsOrders(Ref ref) {
  return ref.watch(orderRepositoryProvider).list();
}

@riverpod
Future<List<Vehicle>> rankedVehicles(
  Ref ref, {
  required double weightKg,
  required String vehicleType,
}) {
  return ref.watch(vehicleRepositoryProvider).suggest(
        weightKg: weightKg,
        vehicleType: vehicleType,
      );
}

@riverpod
Future<List<Driver>> rosterDrivers(Ref ref) {
  return ref.watch(driverRepositoryProvider).listDrivers();
}

/// driverId -> has an active trip (drives the on-trip block in planning).
@riverpod
Future<Map<String, bool>> driverTripLoad(Ref ref) async {
  final List<Driver> drivers =
      await ref.watch(rosterDriversProvider.future);
  final List<bool> results = await Future.wait(
    drivers.map(
      (d) => ref.watch(tripRepositoryProvider).hasActiveTrip(d.id),
    ),
  );
  return {for (int i = 0; i < drivers.length; i++) drivers[i].id: results[i]};
}

@riverpod
Future<List<Trip>> opsLiveTrips(Ref ref) {
  return ref.watch(tripRepositoryProvider).runningTrips();
}

@riverpod
Future<List<ExceptionItem>> exceptionsFeed(Ref ref) {
  return ref.watch(exceptionRepositoryProvider).list();
}

@riverpod
Future<int> openExceptionsCount(Ref ref) async {
  final List<ExceptionItem> items =
      await ref.watch(exceptionsFeedProvider.future);
  return items.where((e) => !e.resolved).length;
}

@riverpod
Future<List<MarketVehicle>> marketVehicles(Ref ref) {
  return ref.watch(hireRepositoryProvider).vehicles();
}
