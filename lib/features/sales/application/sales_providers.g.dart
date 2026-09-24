// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(salesLeads)
final salesLeadsProvider = SalesLeadsProvider._();

final class SalesLeadsProvider extends $FunctionalProvider<
        AsyncValue<List<Lead>>, List<Lead>, FutureOr<List<Lead>>>
    with $FutureModifier<List<Lead>>, $FutureProvider<List<Lead>> {
  SalesLeadsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'salesLeadsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$salesLeadsHash();

  @$internal
  @override
  $FutureProviderElement<List<Lead>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Lead>> create(Ref ref) {
    return salesLeads(ref);
  }
}

String _$salesLeadsHash() => r'5713e356a825c3f950ba15d30400e9c1fa9520d8';

@ProviderFor(plannedVisits)
final plannedVisitsProvider = PlannedVisitsProvider._();

final class PlannedVisitsProvider extends $FunctionalProvider<
        AsyncValue<List<Visit>>, List<Visit>, FutureOr<List<Visit>>>
    with $FutureModifier<List<Visit>>, $FutureProvider<List<Visit>> {
  PlannedVisitsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'plannedVisitsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$plannedVisitsHash();

  @$internal
  @override
  $FutureProviderElement<List<Visit>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Visit>> create(Ref ref) {
    return plannedVisits(ref);
  }
}

String _$plannedVisitsHash() => r'b986c628631571203d59d30b722e8e5be4327230';

@ProviderFor(salesTargets)
final salesTargetsProvider = SalesTargetsProvider._();

final class SalesTargetsProvider extends $FunctionalProvider<
        AsyncValue<List<SalesTarget>>,
        List<SalesTarget>,
        FutureOr<List<SalesTarget>>>
    with
        $FutureModifier<List<SalesTarget>>,
        $FutureProvider<List<SalesTarget>> {
  SalesTargetsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'salesTargetsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$salesTargetsHash();

  @$internal
  @override
  $FutureProviderElement<List<SalesTarget>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<SalesTarget>> create(Ref ref) {
    return salesTargets(ref);
  }
}

String _$salesTargetsHash() => r'a54460fbcd75f0f85a526869cfb6805e002e3ac8';

@ProviderFor(laneRate)
final laneRateProvider = LaneRateFamily._();

final class LaneRateProvider
    extends $FunctionalProvider<AsyncValue<int?>, int?, FutureOr<int?>>
    with $FutureModifier<int?>, $FutureProvider<int?> {
  LaneRateProvider._(
      {required LaneRateFamily super.from,
      required (
        String,
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'laneRateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$laneRateHash();

  @override
  String toString() {
    return r'laneRateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int?> create(Ref ref) {
    final argument = this.argument as (
      String,
      String,
      String,
    );
    return laneRate(
      ref,
      argument.$1,
      argument.$2,
      argument.$3,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LaneRateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$laneRateHash() => r'1b50af6db459cde6386028751e50c1cabe608254';

final class LaneRateFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<int?>,
            (
              String,
              String,
              String,
            )> {
  LaneRateFamily._()
      : super(
          retry: null,
          name: r'laneRateProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  LaneRateProvider call(
    String from,
    String to,
    String vehicle,
  ) =>
      LaneRateProvider._(argument: (
        from,
        to,
        vehicle,
      ), from: this);

  @override
  String toString() => r'laneRateProvider';
}

@ProviderFor(salesCustomers)
final salesCustomersProvider = SalesCustomersProvider._();

final class SalesCustomersProvider extends $FunctionalProvider<
        AsyncValue<List<Customer>>, List<Customer>, FutureOr<List<Customer>>>
    with $FutureModifier<List<Customer>>, $FutureProvider<List<Customer>> {
  SalesCustomersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'salesCustomersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$salesCustomersHash();

  @$internal
  @override
  $FutureProviderElement<List<Customer>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Customer>> create(Ref ref) {
    return salesCustomers(ref);
  }
}

String _$salesCustomersHash() => r'7c202dceab2fce58d616cdae781174bca9de97a7';

@ProviderFor(customerOrders)
final customerOrdersProvider = CustomerOrdersFamily._();

final class CustomerOrdersProvider extends $FunctionalProvider<
        AsyncValue<List<Order>>, List<Order>, FutureOr<List<Order>>>
    with $FutureModifier<List<Order>>, $FutureProvider<List<Order>> {
  CustomerOrdersProvider._(
      {required CustomerOrdersFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'customerOrdersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$customerOrdersHash();

  @override
  String toString() {
    return r'customerOrdersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Order>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Order>> create(Ref ref) {
    final argument = this.argument as String;
    return customerOrders(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerOrdersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerOrdersHash() => r'd863d389ec1a0370fe2c2678c9cd7092fb4cf2a0';

final class CustomerOrdersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Order>>, String> {
  CustomerOrdersFamily._()
      : super(
          retry: null,
          name: r'customerOrdersProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  CustomerOrdersProvider call(
    String customerId,
  ) =>
      CustomerOrdersProvider._(argument: customerId, from: this);

  @override
  String toString() => r'customerOrdersProvider';
}
