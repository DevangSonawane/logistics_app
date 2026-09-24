import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/data/models/trip.dart';
import 'package:roadops/data/repositories/trip_repository.dart';

void main() {
  test('next step follows the status flow', () {
    expect(nextStepFor(TripStatus.assigned), TripStepType.reachedPickup);
    expect(nextStepFor(TripStatus.reachedPickup), TripStepType.loadingDone);
    expect(nextStepFor(TripStatus.loadingDone), TripStepType.startTrip);
    expect(nextStepFor(TripStatus.started), TripStepType.reachedDrop);
    expect(nextStepFor(TripStatus.reachedDrop), TripStepType.unloaded);
    expect(nextStepFor(TripStatus.unloaded), isNull);
    expect(nextStepFor(TripStatus.delivered), isNull);
  });

  test('status advances exactly one step', () {
    expect(
      statusAfterStep(TripStepType.reachedPickup),
      TripStatus.reachedPickup,
    );
    expect(statusAfterStep(TripStepType.startTrip), TripStatus.started);
    expect(statusAfterStep(TripStepType.unloaded), TripStatus.unloaded);
  });

  Trip tripWith(TripStatus status) => Trip(
        id: 't',
        no: 'T',
        orderId: 'O',
        customer: 'C',
        pickupAddress: 'P',
        pickupContact: 'P',
        pickupPhone: '9812345678',
        pickupLat: 0,
        pickupLng: 0,
        dropAddress: 'D',
        dropContact: 'D',
        dropPhone: '9912345678',
        dropLat: 0,
        dropLng: 0,
        distanceKm: 10,
        freightAllowance: 100,
        pickupBy: DateTime(2026),
        vehicleReg: 'V',
        driverId: 'd',
        status: status,
      );

  test('steps cannot be skipped', () {
    // Correct next step passes.
    validateStepOrder(tripWith(TripStatus.started), TripStepType.reachedDrop);
    // Skipping ahead throws.
    expect(
      () => validateStepOrder(tripWith(TripStatus.started), TripStepType.unloaded),
      throwsA(isA<Exception>()),
    );
    // Finished trips reject everything.
    expect(
      () => validateStepOrder(
        tripWith(TripStatus.delivered),
        TripStepType.unloaded,
      ),
      throwsA(isA<Exception>()),
    );
  });
}
