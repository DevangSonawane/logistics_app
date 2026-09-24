import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

/// Driver status-step order. Steps cannot be skipped (validated both sides).
enum TripStepType {
  reachedPickup,
  loadingDone,
  startTrip,
  reachedDrop,
  unloaded,
}

/// Trip lifecycle. `offered` = new trip offer awaiting accept/reject.
enum TripStatus {
  offered,
  assigned,
  reachedPickup,
  loadingDone,
  started,
  reachedDrop,
  unloaded,
  podSubmitted,
  delivered,
  closed,
  cancelled,
}

enum PodStatus { pending, submitted, verified }

/// Next driver step for a status, or null when the flow is finished.
TripStepType? nextStepFor(TripStatus status) {
  return switch (status) {
    TripStatus.assigned => TripStepType.reachedPickup,
    TripStatus.reachedPickup => TripStepType.loadingDone,
    TripStatus.loadingDone => TripStepType.startTrip,
    TripStatus.startTrip => TripStepType.reachedDrop,
    TripStatus.reachedDrop => TripStepType.unloaded,
    _ => null,
  };
}

/// Status resulting from completing a step.
TripStatus statusAfterStep(TripStepType step) {
  return switch (step) {
    TripStepType.reachedPickup => TripStatus.reachedPickup,
    TripStepType.loadingDone => TripStatus.loadingDone,
    TripStepType.startTrip => TripStatus.started,
    TripStepType.reachedDrop => TripStatus.reachedDrop,
    TripStepType.unloaded => TripStatus.unloaded,
  };
}

/// One completed status checkpoint with photo + GPS + timestamp.
@freezed
abstract class TripStep with _$TripStep {
  const factory TripStep({
    required TripStepType type,
    required DateTime at,
    required double lat,
    required double lng,
    String? photoPath,
    String? note,
  }) = _TripStep;

  factory TripStep.fromJson(Map<String, dynamic> json) =>
      _$TripStepFromJson(json);
}

/// The trip is the centre: every cost, document and status attaches to it.
/// Money fields are integer rupees.
@freezed
abstract class Trip with _$Trip {
  const factory Trip({
    required String id,
    required String no,
    required String orderId,
    required String customer,
    required String pickupAddress,
    required String pickupContact,
    required String pickupPhone,
    required double pickupLat,
    required double pickupLng,
    required String dropAddress,
    required String dropContact,
    required String dropPhone,
    required double dropLat,
    required double dropLng,
    required double distanceKm,
    required int freightAllowance,
    required DateTime pickupBy,
    required String vehicleReg,
    required String driverId,
    required TripStatus status,
    DateTime? plannedEta,
    DateTime? liveEta,
    @Default([]) List<TripStep> steps,
    String? lrNo,
    String? ewayBillNo,
    @Default(PodStatus.pending) PodStatus podStatus,
    @Default(0) int advanceGiven,
    String? rejectReason,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
