// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ops_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ordersByStatus)
final ordersByStatusProvider = OrdersByStatusFamily._();

final class OrdersByStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Order>>,
          List<Order>,
          FutureOr<List<Order>>
        >
    with $FutureModifier<List<Order>>, $FutureProvider<List<Order>> {
  OrdersByStatusProvider._({
    required OrdersByStatusFamily super.from,
    required OrderStatus super.argument,
  }) : super(
         retry: null,
         name: r'ordersByStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ordersByStatusHash();

  @override
  String toString() {
    return r'ordersByStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Order>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Order>> create(Ref ref) {
    final argument = this.argument as OrderStatus;
    return ordersByStatus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrdersByStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ordersByStatusHash() => r'9da8a60ff2d19ade2b4b30e330c618b9957eb752';

final class OrdersByStatusFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Order>>, OrderStatus> {
  OrdersByStatusFamily._()
    : super(
        retry: null,
        name: r'ordersByStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrdersByStatusProvider call(OrderStatus status) =>
      OrdersByStatusProvider._(argument: status, from: this);

  @override
  String toString() => r'ordersByStatusProvider';
}

@ProviderFor(allOpsOrders)
final allOpsOrdersProvider = AllOpsOrdersProvider._();

final class AllOpsOrdersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Order>>,
          List<Order>,
          FutureOr<List<Order>>
        >
    with $FutureModifier<List<Order>>, $FutureProvider<List<Order>> {
  AllOpsOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allOpsOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allOpsOrdersHash();

  @$internal
  @override
  $FutureProviderElement<List<Order>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Order>> create(Ref ref) {
    return allOpsOrders(ref);
  }
}

String _$allOpsOrdersHash() => r'30b07d6416a4d43123b0938c38460a5db2042a6e';

@ProviderFor(rankedVehicles)
final rankedVehiclesProvider = RankedVehiclesFamily._();

final class RankedVehiclesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Vehicle>>,
          List<Vehicle>,
          FutureOr<List<Vehicle>>
        >
    with $FutureModifier<List<Vehicle>>, $FutureProvider<List<Vehicle>> {
  RankedVehiclesProvider._({
    required RankedVehiclesFamily super.from,
    required ({double weightKg, String vehicleType}) super.argument,
  }) : super(
         retry: null,
         name: r'rankedVehiclesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rankedVehiclesHash();

  @override
  String toString() {
    return r'rankedVehiclesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Vehicle>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vehicle>> create(Ref ref) {
    final argument = this.argument as ({double weightKg, String vehicleType});
    return rankedVehicles(
      ref,
      weightKg: argument.weightKg,
      vehicleType: argument.vehicleType,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RankedVehiclesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rankedVehiclesHash() => r'0904a1367cbadb069800a3c98c2a9871a3efe0b8';

final class RankedVehiclesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Vehicle>>,
          ({double weightKg, String vehicleType})
        > {
  RankedVehiclesFamily._()
    : super(
        retry: null,
        name: r'rankedVehiclesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RankedVehiclesProvider call({
    required double weightKg,
    required String vehicleType,
  }) => RankedVehiclesProvider._(
    argument: (weightKg: weightKg, vehicleType: vehicleType),
    from: this,
  );

  @override
  String toString() => r'rankedVehiclesProvider';
}

@ProviderFor(rosterDrivers)
final rosterDriversProvider = RosterDriversProvider._();

final class RosterDriversProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Driver>>,
          List<Driver>,
          FutureOr<List<Driver>>
        >
    with $FutureModifier<List<Driver>>, $FutureProvider<List<Driver>> {
  RosterDriversProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rosterDriversProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rosterDriversHash();

  @$internal
  @override
  $FutureProviderElement<List<Driver>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Driver>> create(Ref ref) {
    return rosterDrivers(ref);
  }
}

String _$rosterDriversHash() => r'2f9a17e688360191590d2f56c14f532ebdddb08f';

/// driverId -> has an active trip (drives the on-trip block in planning).

@ProviderFor(driverTripLoad)
final driverTripLoadProvider = DriverTripLoadProvider._();

/// driverId -> has an active trip (drives the on-trip block in planning).

final class DriverTripLoadProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, bool>>,
          Map<String, bool>,
          FutureOr<Map<String, bool>>
        >
    with
        $FutureModifier<Map<String, bool>>,
        $FutureProvider<Map<String, bool>> {
  /// driverId -> has an active trip (drives the on-trip block in planning).
  DriverTripLoadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverTripLoadProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverTripLoadHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, bool>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, bool>> create(Ref ref) {
    return driverTripLoad(ref);
  }
}

String _$driverTripLoadHash() => r'2f4c4130f9141eb999d88fa9a8e6f588c7196409';

@ProviderFor(opsLiveTrips)
final opsLiveTripsProvider = OpsLiveTripsProvider._();

final class OpsLiveTripsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Trip>>,
          List<Trip>,
          FutureOr<List<Trip>>
        >
    with $FutureModifier<List<Trip>>, $FutureProvider<List<Trip>> {
  OpsLiveTripsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'opsLiveTripsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$opsLiveTripsHash();

  @$internal
  @override
  $FutureProviderElement<List<Trip>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Trip>> create(Ref ref) {
    return opsLiveTrips(ref);
  }
}

String _$opsLiveTripsHash() => r'cc7bbdc94d41365b2a3905701c44dbad289c1206';

@ProviderFor(exceptionsFeed)
final exceptionsFeedProvider = ExceptionsFeedProvider._();

final class ExceptionsFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExceptionItem>>,
          List<ExceptionItem>,
          FutureOr<List<ExceptionItem>>
        >
    with
        $FutureModifier<List<ExceptionItem>>,
        $FutureProvider<List<ExceptionItem>> {
  ExceptionsFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exceptionsFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exceptionsFeedHash();

  @$internal
  @override
  $FutureProviderElement<List<ExceptionItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExceptionItem>> create(Ref ref) {
    return exceptionsFeed(ref);
  }
}

String _$exceptionsFeedHash() => r'c2ebc7463a54daff6fd3e2fc134ba72aff97d1a4';

@ProviderFor(openExceptionsCount)
final openExceptionsCountProvider = OpenExceptionsCountProvider._();

final class OpenExceptionsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  OpenExceptionsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openExceptionsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openExceptionsCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return openExceptionsCount(ref);
  }
}

String _$openExceptionsCountHash() =>
    r'a3ce8a5913308137e301d1025cc85d4b90ee9b19';

@ProviderFor(marketVehicles)
final marketVehiclesProvider = MarketVehiclesProvider._();

final class MarketVehiclesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MarketVehicle>>,
          List<MarketVehicle>,
          FutureOr<List<MarketVehicle>>
        >
    with
        $FutureModifier<List<MarketVehicle>>,
        $FutureProvider<List<MarketVehicle>> {
  MarketVehiclesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marketVehiclesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marketVehiclesHash();

  @$internal
  @override
  $FutureProviderElement<List<MarketVehicle>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MarketVehicle>> create(Ref ref) {
    return marketVehicles(ref);
  }
}

String _$marketVehiclesHash() => r'9aa1e7775697442868ab11aa64804097ef3da094';
