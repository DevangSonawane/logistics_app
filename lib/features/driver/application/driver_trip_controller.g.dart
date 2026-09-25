// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_trip_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Driver trip state machine. Every mutation applies optimistically,
/// enqueues an OfflineAction, then uploads immediately when online.
/// Server-wins conflicts roll back with a rejected action.

@ProviderFor(DriverTrip)
final driverTripProvider = DriverTripFamily._();

/// Driver trip state machine. Every mutation applies optimistically,
/// enqueues an OfflineAction, then uploads immediately when online.
/// Server-wins conflicts roll back with a rejected action.
final class DriverTripProvider
    extends $AsyncNotifierProvider<DriverTrip, DriverTripState> {
  /// Driver trip state machine. Every mutation applies optimistically,
  /// enqueues an OfflineAction, then uploads immediately when online.
  /// Server-wins conflicts roll back with a rejected action.
  DriverTripProvider._(
      {required DriverTripFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'driverTripProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$driverTripHash();

  @override
  String toString() {
    return r'driverTripProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DriverTrip create() => DriverTrip();

  @override
  bool operator ==(Object other) {
    return other is DriverTripProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driverTripHash() => r'5bb5a2a3d16ca6912c7f2035bcbe2f4dd7711950';

/// Driver trip state machine. Every mutation applies optimistically,
/// enqueues an OfflineAction, then uploads immediately when online.
/// Server-wins conflicts roll back with a rejected action.

final class DriverTripFamily extends $Family
    with
        $ClassFamilyOverride<DriverTrip, AsyncValue<DriverTripState>,
            DriverTripState, FutureOr<DriverTripState>, String> {
  DriverTripFamily._()
      : super(
          retry: null,
          name: r'driverTripProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  /// Driver trip state machine. Every mutation applies optimistically,
  /// enqueues an OfflineAction, then uploads immediately when online.
  /// Server-wins conflicts roll back with a rejected action.

  DriverTripProvider call(
    String driverId,
  ) =>
      DriverTripProvider._(argument: driverId, from: this);

  @override
  String toString() => r'driverTripProvider';
}

/// Driver trip state machine. Every mutation applies optimistically,
/// enqueues an OfflineAction, then uploads immediately when online.
/// Server-wins conflicts roll back with a rejected action.

abstract class _$DriverTrip extends $AsyncNotifier<DriverTripState> {
  late final _$args = ref.$arg as String;
  String get driverId => _$args;

  FutureOr<DriverTripState> build(
    String driverId,
  );
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DriverTripState>, DriverTripState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<DriverTripState>, DriverTripState>,
        AsyncValue<DriverTripState>,
        Object?,
        Object?>;
    return element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
