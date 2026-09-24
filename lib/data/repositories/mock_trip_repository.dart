import '../../mock/mock_business_data.dart';
import '../../mock/mock_delay.dart';
import '../../mock/mock_driver_data.dart';
import '../../models/trip.dart';
import 'trip_repository.dart';

/// Mock trip store with in-memory state per provider instance.
/// Phase 5 adds planning/assign/cancel and live queries on top.
class MockTripRepository implements TripRepository {
  MockTripRepository() {
    _trips[MockDriverData.rameshTrip().id] = MockDriverData.rameshTrip();
    _trips[MockDriverData.sureshOffer().id] = MockDriverData.sureshOffer();
    for (final Trip trip in MockBusinessData.businessTrips()) {
      _trips[trip.id] = trip;
    }
  }

  final Map<String, Trip> _trips = {};

  /// Trips Ops cancelled/reassigned behind the driver's back.
  final Set<String> _cancelledByOps = {};

  /// Demo hook (Phase 6 demo tools): simulate an Ops cancellation so the
  /// conflict dialog + refresh path can be exercised.
  void debugCancelTrip(String tripId) {
    _cancelledByOps.add(tripId);
  }

  void _throwIfConflict(String tripId) {
    if (_cancelledByOps.contains(tripId)) {
      throw const TripConflictException(
        'Ops changed this trip. Your pending action was rejected.',
      );
    }
  }

  Trip _require(String tripId) {
    final Trip? trip = _trips[tripId];
    if (trip == null) throw const MockApiException('Trip not found');
    return trip;
  }

  @override
  Future<bool> hasActiveTrip(String driverId) async {
    return (await getActiveTrip(driverId)) != null;
  }

  @override
  Future<Trip?> getActiveTrip(String driverId) async {
    await mockDelay();
    throwIfChaos();
    for (final Trip trip in _trips.values) {
      if (trip.driverId == driverId &&
          trip.status != TripStatus.offered &&
          trip.status != TripStatus.cancelled &&
          trip.status != TripStatus.closed &&
          trip.status != TripStatus.delivered) {
        return trip;
      }
    }
    return null;
  }

  @override
  Future<Trip?> getOffer(String driverId) async {
    await mockDelay();
    throwIfChaos();
    for (final Trip trip in _trips.values) {
      if (trip.driverId == driverId && trip.status == TripStatus.offered) {
        return trip;
      }
    }
    return null;
  }

  @override
  Future<Trip> respondToOffer({
    required String tripId,
    required bool accept,
    String? reason,
  }) async {
    await mockDelay();
    throwIfChaos();
    _throwIfConflict(tripId);
    final Trip trip = _require(tripId);
    if (trip.status != TripStatus.offered) {
      throw const MockApiException('Offer is no longer available');
    }
    if (!accept && (reason == null || reason.isEmpty)) {
      throw const MockApiException('A reject reason is required');
    }
    final Trip updated = trip.copyWith(
      status: accept ? TripStatus.assigned : TripStatus.cancelled,
      rejectReason: accept ? null : reason,
    );
    _trips[tripId] = updated;
    return updated;
  }

  @override
  Future<Trip> updateStatus({
    required String tripId,
    required TripStepType step,
    String? photoPath,
    double? lat,
    double? lng,
    String? note,
  }) async {
    await mockDelay();
    throwIfChaos();
    _throwIfConflict(tripId);
    final Trip trip = _require(tripId);
    validateStepOrder(trip, step);
    final Trip updated = trip.copyWith(
      status: statusAfterStep(step),
      steps: [
        ...trip.steps,
        TripStep(
          type: step,
          at: DateTime.now(),
          lat: lat ?? trip.pickupLat,
          lng: lng ?? trip.pickupLng,
          photoPath: photoPath,
          note: note,
        ),
      ],
    );
    _trips[tripId] = updated;
    return updated;
  }

  @override
  Future<Trip> submitPod({
    required String tripId,
    required String lrPhotoPath,
    required String method,
    String? consigneeName,
    bool hasDamageOrShortage = false,
    String? damageRemark,
    int? damageQty,
    List<String> damagePhotos = const [],
  }) async {
    await mockDelay();
    throwIfChaos();
    _throwIfConflict(tripId);
    final Trip trip = _require(tripId);
    if (trip.status != TripStatus.unloaded) {
      throw const MockApiException('POD needs an unloaded trip');
    }
    final Trip updated = trip.copyWith(
      status: TripStatus.delivered,
      podStatus: PodStatus.submitted,
    );
    _trips[tripId] = updated;
    return updated;
  }

  @override
  Future<Trip?> getTrip(String tripId) async {
    await mockDelay();
    return _trips[tripId];
  }

  /// Ops planning: books a trip as an offer the driver accepts in-app.
  Future<Trip> assignTrip(Trip trip) async {
    await mockDelay();
    throwIfChaos();
    _trips[trip.id] = trip;
    return trip;
  }

  /// Ops attaches/enters the e-way bill number from trip control.
  Future<Trip> updateEway(String tripId, String ewayNo) async {
    await mockDelay();
    throwIfChaos();
    final Trip trip = _require(tripId);
    final Trip updated = trip.copyWith(ewayBillNo: ewayNo);
    _trips[tripId] = updated;
    return updated;
  }

  /// Live-trips + map queries for ops/owner.
  Future<List<Trip>> runningTrips() async {
    await mockDelay();
    return _trips.values
        .where(
          (t) =>
              t.status == TripStatus.started ||
              t.status == TripStatus.reachedDrop ||
              t.status == TripStatus.reachedPickup ||
              t.status == TripStatus.loadingDone,
        )
        .toList();
  }
}
