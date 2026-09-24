import '../mock/mock_delay.dart';
import '../models/trip.dart';

/// Server-wins conflict: the driver acted on a reassigned/cancelled trip.
/// The UI marks the queued action rejected, shows a dialog and refreshes.
class TripConflictException implements Exception {
  const TripConflictException(this.message);
  final String message;

  @override
  String toString() => 'TripConflictException: $message';
}

/// Trip repository interface. Phase 3 driver scope; ops planning (Phase 5)
/// adds assign/cancel and the live-trip queries.
abstract class TripRepository {
  /// Whether the driver currently has a trip in a running state.
  /// Used by the logout blockers.
  Future<bool> hasActiveTrip(String driverId);

  /// Current running/assigned trip, or null (empty state).
  Future<Trip?> getActiveTrip(String driverId);

  /// Pending trip offer, or null.
  Future<Trip?> getOffer(String driverId);

  /// Accept (status -> assigned) or reject with a required reason.
  Future<Trip> respondToOffer({
    required String tripId,
    required bool accept,
    String? reason,
  });

  /// Complete the next status step with photo + GPS. Validates step order
  /// and throws [TripConflictException] when Ops changed the trip.
  Future<Trip> updateStatus({
    required String tripId,
    required TripStepType step,
    String? photoPath,
    double? lat,
    double? lng,
    String? note,
  });

  /// Submit POD: status -> delivered, podStatus -> submitted.
  Future<Trip> submitPod({
    required String tripId,
    required String lrPhotoPath,
    required String method,
    String? consigneeName,
    bool hasDamageOrShortage = false,
    String? damageRemark,
    int? damageQty,
    List<String> damagePhotos = const [],
  });

  Future<Trip?> getTrip(String tripId);
}

/// Step-order guard shared by mock and (later) real implementations.
void validateStepOrder(Trip trip, TripStepType step) {
  final TripStepType? expected = nextStepFor(trip.status);
  if (expected == null) {
    throw const MockApiException('Trip flow is already finished');
  }
  if (expected != step) {
    throw MockApiException(
      'Expected step $expected but got $step (status ${trip.status})',
    );
  }
}
