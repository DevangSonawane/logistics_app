import '../mock/mock_delay.dart';
import 'trip_repository.dart';

/// Mock trip store. Phase 3 replaces the body with the Section 8.2 seed
/// (25 trips, 6 running) and the full trip model.
class MockTripRepository implements TripRepository {
  /// Demo: Ramesh Yadav (u-driver-1) has the running Pune->Chennai trip.
  static const String demoActiveDriverId = 'u-driver-1';

  @override
  Future<bool> hasActiveTrip(String driverId) async {
    await mockDelay();
    throwIfChaos();
    return driverId == demoActiveDriverId;
  }
}
