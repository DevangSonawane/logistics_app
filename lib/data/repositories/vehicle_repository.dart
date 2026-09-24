import '../models/vehicle.dart';

/// Fleet store: live map, plan-trip suggestions, doc-expiry checks.
abstract class VehicleRepository {
  Future<List<Vehicle>> list();
  Future<Vehicle?> get(String id);

  /// Ranked suggestions for an order: docs valid first, then capacity fit.
  Future<List<Vehicle>> suggest({
    required double weightKg,
    required String vehicleType,
  });
}
