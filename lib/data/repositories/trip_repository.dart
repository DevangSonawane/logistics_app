/// Trip repository interface. The full trip model and trip flows land in
/// Phase 3; Phase 2 needs only the logout blocker query below.
abstract class TripRepository {
  /// Whether the driver currently has a trip in a running state.
  Future<bool> hasActiveTrip(String driverId);
}
