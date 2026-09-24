import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/core/services/voice_service.dart';
import 'package:roadops/data/models/trip.dart';

void main() {
  test('english phrases map to steps', () {
    expect(matchDriverCommand('we reached pickup', 'en'), TripStepType.reachedPickup);
    expect(matchDriverCommand('loading done', 'en'), TripStepType.loadingDone);
    expect(matchDriverCommand('start trip', 'en'), TripStepType.startTrip);
    expect(matchDriverCommand('reached drop', 'en'), TripStepType.reachedDrop);
    expect(matchDriverCommand('unloading done', 'en'), TripStepType.unloaded);
  });

  test('hindi phrases map to steps', () {
    expect(
      matchDriverCommand('saman load ho gaya', 'hi'),
      TripStepType.loadingDone,
    );
    expect(
      matchDriverCommand('unloading ho gayi', 'hi'),
      TripStepType.unloaded,
    );
    expect(matchDriverCommand('chalo', 'hi'), TripStepType.startTrip);
  });

  test('unknown locales fall back to english', () {
    expect(matchDriverCommand('loading done', 'ta'), TripStepType.loadingDone);
  });

  test('no match returns null (never auto-applies)', () {
    expect(matchDriverCommand('hello there', 'en'), isNull);
    expect(matchDriverCommand('', 'hi'), isNull);
  });
}
