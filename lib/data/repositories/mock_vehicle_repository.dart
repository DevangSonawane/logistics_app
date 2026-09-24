import '../../mock/mock_business_data.dart';
import '../../mock/mock_delay.dart';
import '../models/vehicle.dart';
import 'vehicle_repository.dart';

class MockVehicleRepository implements VehicleRepository {
  MockVehicleRepository() {
    _vehicles.addAll(MockBusinessData.vehicles());
  }

  final List<Vehicle> _vehicles = [];

  @override
  Future<List<Vehicle>> list() async {
    await mockDelay();
    throwIfChaos();
    return List.unmodifiable(_vehicles);
  }

  @override
  Future<Vehicle?> get(String id) async {
    await mockDelay();
    for (final Vehicle v in _vehicles) {
      if (v.id == id) return v;
    }
    return null;
  }

  @override
  Future<List<Vehicle>> suggest({
    required double weightKg,
    required String vehicleType,
  }) async {
    await mockDelay();
    final DateTime now = DateTime.now();
    final List<Vehicle> ranked = List.of(_vehicles);
    int score(Vehicle v) {
      int s = 0;
      final bool docsOk = v.docs.every((d) => d.expiry.isAfter(now));
      if (docsOk) s += 100;
      if (v.status == VehicleStatus.idle) s += 50;
      if (v.type == vehicleType) s += 30;
      if (v.capacityTons * 1000 >= weightKg) s += 20;
      if (v.ownership == VehicleOwnership.own) s += 10;
      return s;
    }

    ranked.sort((a, b) => score(b).compareTo(score(a)));
    return ranked;
  }
}
