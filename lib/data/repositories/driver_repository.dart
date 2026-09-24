import '../models/driver.dart';
import '../models/vehicle.dart';

/// Driver repository: master record, earnings aggregate, vehicle docs.
abstract class DriverRepository {
  Future<Driver> getDriver(String userId);

  Future<EarningsSummary> getEarnings(String driverId);

  Future<List<VehicleDoc>> getVehicleDocs(String regNo);

  /// Fleet roster for ops planning (licence + on-trip checks upstream).
  Future<List<Driver>> listDrivers();
}
