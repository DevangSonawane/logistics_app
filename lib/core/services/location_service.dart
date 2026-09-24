import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/constants.dart';

part 'location_service.g.dart';

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => const LocationService();

/// Foreground + background GPS access. Battery-aware intervals and the
/// accuracy filter come from [AppConstants]. All failures return null so
/// callers fall back to trip coordinates (demo simulation).
class LocationService {
  const LocationService();

  /// Best-effort current fix. Points with accuracy > 100 m are discarded.
  Future<({double lat, double lng})?> currentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 8),
        ),
      ).timeout(const Duration(seconds: 10));
      if (position.accuracy > AppConstants.maxGpsAccuracyMeters) return null;
      return (lat: position.latitude, lng: position.longitude);
    } catch (_) {
      return null;
    }
  }

  /// Demo interpolation along the pickup->drop line for the owner/ops map.
  /// [progress] is 0 (pickup) to 1 (drop).
  static ({double lat, double lng}) interpolate({
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
    required double progress,
  }) {
    final double p = progress.clamp(0, 1);
    return (
      lat: fromLat + (toLat - fromLat) * p,
      lng: fromLng + (toLng - fromLng) * p,
    );
  }
}
