import '../mock/mock_business_data.dart';
import '../mock/mock_delay.dart';
import '../mock/mock_driver_data.dart';
import '../models/driver.dart';
import '../models/vehicle.dart';
import 'driver_repository.dart';

/// Mock driver store backed by the Phase 3 seed.
class MockDriverRepository implements DriverRepository {
  @override
  Future<Driver> getDriver(String userId) async {
    await mockDelay();
    throwIfChaos();
    return MockDriverData.driver(userId);
  }

  @override
  Future<EarningsSummary> getEarnings(String driverId) async {
    await mockDelay();
    throwIfChaos();
    return MockDriverData.earnings();
  }

  @override
  Future<List<VehicleDoc>> getVehicleDocs(String regNo) async {
    await mockDelay();
    throwIfChaos();
    return MockDriverData.vehicleDocs();
  }

  @override
  Future<List<Driver>> listDrivers() async {
    await mockDelay();
    throwIfChaos();
    return MockBusinessData.drivers();
  }
}
