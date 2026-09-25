// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Foreground GPS tracking. Starts on trip Start, stops on
/// Unloaded/Delivered. Battery-aware cadence; points append to Hive and
/// upload in batches of 5. Demo builds interpolate along the route when
/// no real fix is available so the owner/ops map shows a moving truck.

@ProviderFor(GpsTracker)
final gpsTrackerProvider = GpsTrackerProvider._();

/// Foreground GPS tracking. Starts on trip Start, stops on
/// Unloaded/Delivered. Battery-aware cadence; points append to Hive and
/// upload in batches of 5. Demo builds interpolate along the route when
/// no real fix is available so the owner/ops map shows a moving truck.
final class GpsTrackerProvider
    extends $NotifierProvider<GpsTracker, GpsTrackerState> {
  /// Foreground GPS tracking. Starts on trip Start, stops on
  /// Unloaded/Delivered. Battery-aware cadence; points append to Hive and
  /// upload in batches of 5. Demo builds interpolate along the route when
  /// no real fix is available so the owner/ops map shows a moving truck.
  GpsTrackerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'gpsTrackerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$gpsTrackerHash();

  @$internal
  @override
  GpsTracker create() => GpsTracker();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GpsTrackerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GpsTrackerState>(value),
    );
  }
}

String _$gpsTrackerHash() => r'1fbf78c710db9d79e0bfef72dc69709060407d45';

/// Foreground GPS tracking. Starts on trip Start, stops on
/// Unloaded/Delivered. Battery-aware cadence; points append to Hive and
/// upload in batches of 5. Demo builds interpolate along the route when
/// no real fix is available so the owner/ops map shows a moving truck.

abstract class _$GpsTracker extends $Notifier<GpsTrackerState> {
  GpsTrackerState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GpsTrackerState, GpsTrackerState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<GpsTrackerState, GpsTrackerState>,
        GpsTrackerState,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
