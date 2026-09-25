import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/constants.dart';
import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/offline/sync_engine.dart';
import '../../../core/network/connectivity_provider.dart';
import '../../../core/services/background_gps_service.dart';
import '../../../core/services/location_service.dart';
import '../../../core/storage/boxes.dart';
import '../../../data/models/trip.dart';

part 'gps_controller.g.dart';

/// One logged GPS fix (Hive gps_track box + mock upload batches).
class GpsPoint {
  const GpsPoint({
    required this.lat,
    required this.lng,
    required this.at,
    this.battery,
  });

  final double lat;
  final double lng;
  final DateTime at;
  final int? battery;

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
        'at': at.toIso8601String(),
        'battery': battery,
      };

  factory GpsPoint.fromJson(Map<String, dynamic> json) => GpsPoint(
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        at: DateTime.parse(json['at'] as String),
        battery: json['battery'] as int?,
      );
}

class GpsTrackerState {
  const GpsTrackerState({
    this.tracking = false,
    this.tripId,
    this.pointCount = 0,
    this.lastPoint,
    this.journeyStart,
  });

  final bool tracking;
  final String? tripId;
  final int pointCount;
  final GpsPoint? lastPoint;
  final DateTime? journeyStart;

  GpsTrackerState copyWith({
    bool? tracking,
    String? tripId,
    int? pointCount,
    GpsPoint? Function()? lastPoint,
    DateTime? journeyStart,
  }) {
    return GpsTrackerState(
      tracking: tracking ?? this.tracking,
      tripId: tripId ?? this.tripId,
      pointCount: pointCount ?? this.pointCount,
      lastPoint: lastPoint != null ? lastPoint() : this.lastPoint,
      journeyStart: journeyStart ?? this.journeyStart,
    );
  }
}

/// Foreground GPS tracking. Starts on trip Start, stops on
/// Unloaded/Delivered. Battery-aware cadence; points append to Hive and
/// upload in batches of 5. Demo builds interpolate along the route when
/// no real fix is available so the owner/ops map shows a moving truck.
@Riverpod(keepAlive: true)
class GpsTracker extends _$GpsTracker {
  final Uuid _uuid = const Uuid();
  Timer? _tick;

  @override
  GpsTrackerState build() {
    ref.onDispose(() => _tick?.cancel());
    return const GpsTrackerState();
  }

  Future<void> start(Trip trip) async {
    _tick?.cancel();
    await ref.read(backgroundGpsServiceProvider).start(trip.no);
    state = GpsTrackerState(
      tracking: true,
      tripId: trip.id,
      journeyStart: DateTime.now(),
    );
    unawaited(_logPoint(trip));
    _schedule(trip, const Duration(seconds: AppConstants.gpsIntervalSeconds));
  }

  Future<void> stop() async {
    _tick?.cancel();
    _tick = null;
    // Never touched the platform unless tracking: avoids arming timers
    // (and platform calls) when idle, including in widget tests.
    final bool wasTracking = state.tracking;
    state = const GpsTrackerState();
    if (!wasTracking) return;
    try {
      await BackgroundGpsService().stop();
    } catch (_) {}
  }

  void _schedule(Trip trip, Duration interval) {
    _tick?.cancel();
    _tick = Timer.periodic(interval, (_) => _logPoint(trip));
  }

  Duration _intervalFor(int? battery) {
    if (battery != null &&
        battery < AppConstants.criticalBatteryPercent) {
      return const Duration(
        seconds: AppConstants.gpsCriticalBatteryIntervalSeconds,
      );
    }
    if (battery != null && battery < AppConstants.lowBatteryPercent) {
      return const Duration(
        seconds: AppConstants.gpsLowBatteryIntervalSeconds,
      );
    }
    return const Duration(seconds: AppConstants.gpsIntervalSeconds);
  }

  double _progress(Trip trip) {
    final DateTime start = state.journeyStart ?? DateTime.now();
    final DateTime eta = trip.liveEta ??
        trip.plannedEta ??
        start.add(const Duration(hours: 2));
    final int total = eta.difference(start).inSeconds;
    if (total <= 0) return 1;
    final int elapsed = DateTime.now().difference(start).inSeconds;
    return (elapsed / total).clamp(0, 1).toDouble();
  }

  Future<void> _logPoint(Trip trip) async {
    final ({double lat, double lng})? fix =
        await ref.read(locationServiceProvider).currentPosition();
    int? battery;
    try {
      battery = await Battery().batteryLevel;
    } catch (_) {}
    final ({double lat, double lng}) point = fix ??
        LocationService.interpolate(
          fromLat: trip.pickupLat,
          fromLng: trip.pickupLng,
          toLat: trip.dropLat,
          toLng: trip.dropLng,
          progress: _progress(trip),
        );
    final GpsPoint gps = GpsPoint(
      lat: point.lat,
      lng: point.lng,
      at: DateTime.now(),
      battery: battery,
    );
    await _appendHive(trip.id, gps);
    if (!ref.mounted) return;
    final int count = state.pointCount + 1;
    state = state.copyWith(
      pointCount: count,
      lastPoint: () => gps,
    );
    _schedule(trip, _intervalFor(battery));
    if (count % 5 == 0) {
      await ref.read(offlineQueueProvider.notifier).enqueue(
            OfflineAction(
              id: _uuid.v4(),
              type: OfflineActionType.gpsBatch,
              tripId: trip.id,
              payload: {'points': count},
              createdAt: DateTime.now(),
            ),
          );
      if (ref.read(isOnlineProvider)) {
        unawaited(ref.read(syncControllerProvider.notifier).syncNow());
      }
    }
  }

  Future<void> _appendHive(String tripId, GpsPoint point) async {
    try {
      final KeyValueBox box = ref.read(gpsTrackBoxProvider);
      final List<dynamic> raw = List<dynamic>.from(
        box.read(tripId, defaultValue: []) as List,
      );
      raw.add(point.toJson());
      await box.write(tripId, raw);
    } catch (_) {}
  }
}
