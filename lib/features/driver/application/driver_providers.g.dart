// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Per-trip expenses for lists and the advance-balance chip.

@ProviderFor(tripExpenses)
final tripExpensesProvider = TripExpensesFamily._();

/// Per-trip expenses for lists and the advance-balance chip.

final class TripExpensesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Expense>>,
          List<Expense>,
          FutureOr<List<Expense>>
        >
    with $FutureModifier<List<Expense>>, $FutureProvider<List<Expense>> {
  /// Per-trip expenses for lists and the advance-balance chip.
  TripExpensesProvider._({
    required TripExpensesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tripExpensesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tripExpensesHash();

  @override
  String toString() {
    return r'tripExpensesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Expense>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Expense>> create(Ref ref) {
    final argument = this.argument as String;
    return tripExpenses(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TripExpensesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tripExpensesHash() => r'56ff8f81fb6a229af59b8a71e9ee15d9c2be5f08';

/// Per-trip expenses for lists and the advance-balance chip.

final class TripExpensesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Expense>>, String> {
  TripExpensesFamily._()
    : super(
        retry: null,
        name: r'tripExpensesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Per-trip expenses for lists and the advance-balance chip.

  TripExpensesProvider call(String tripId) =>
      TripExpensesProvider._(argument: tripId, from: this);

  @override
  String toString() => r'tripExpensesProvider';
}

/// Per-trip advance history (requested/approved/paid/rejected).

@ProviderFor(tripAdvances)
final tripAdvancesProvider = TripAdvancesFamily._();

/// Per-trip advance history (requested/approved/paid/rejected).

final class TripAdvancesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Advance>>,
          List<Advance>,
          FutureOr<List<Advance>>
        >
    with $FutureModifier<List<Advance>>, $FutureProvider<List<Advance>> {
  /// Per-trip advance history (requested/approved/paid/rejected).
  TripAdvancesProvider._({
    required TripAdvancesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tripAdvancesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tripAdvancesHash();

  @override
  String toString() {
    return r'tripAdvancesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Advance>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Advance>> create(Ref ref) {
    final argument = this.argument as String;
    return tripAdvances(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TripAdvancesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tripAdvancesHash() => r'9f3075b358351af498d2f26084c4f0618e1b5011';

/// Per-trip advance history (requested/approved/paid/rejected).

final class TripAdvancesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Advance>>, String> {
  TripAdvancesFamily._()
    : super(
        retry: null,
        name: r'tripAdvancesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Per-trip advance history (requested/approved/paid/rejected).

  TripAdvancesProvider call(String tripId) =>
      TripAdvancesProvider._(argument: tripId, from: this);

  @override
  String toString() => r'tripAdvancesProvider';
}

/// Running advance balance: trip advanceGiven minus recorded expenses.

@ProviderFor(advanceBalance)
final advanceBalanceProvider = AdvanceBalanceFamily._();

/// Running advance balance: trip advanceGiven minus recorded expenses.

final class AdvanceBalanceProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Running advance balance: trip advanceGiven minus recorded expenses.
  AdvanceBalanceProvider._({
    required AdvanceBalanceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'advanceBalanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$advanceBalanceHash();

  @override
  String toString() {
    return r'advanceBalanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as String;
    return advanceBalance(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdvanceBalanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$advanceBalanceHash() => r'e4856d9208d212be15a7531fd6b566a2ceb92b40';

/// Running advance balance: trip advanceGiven minus recorded expenses.

final class AdvanceBalanceFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, String> {
  AdvanceBalanceFamily._()
    : super(
        retry: null,
        name: r'advanceBalanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Running advance balance: trip advanceGiven minus recorded expenses.

  AdvanceBalanceProvider call(String driverId) =>
      AdvanceBalanceProvider._(argument: driverId, from: this);

  @override
  String toString() => r'advanceBalanceProvider';
}

/// Earnings aggregate for the earnings tab.

@ProviderFor(driverEarnings)
final driverEarningsProvider = DriverEarningsFamily._();

/// Earnings aggregate for the earnings tab.

final class DriverEarningsProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarningsSummary>,
          EarningsSummary,
          FutureOr<EarningsSummary>
        >
    with $FutureModifier<EarningsSummary>, $FutureProvider<EarningsSummary> {
  /// Earnings aggregate for the earnings tab.
  DriverEarningsProvider._({
    required DriverEarningsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'driverEarningsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driverEarningsHash();

  @override
  String toString() {
    return r'driverEarningsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EarningsSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarningsSummary> create(Ref ref) {
    final argument = this.argument as String;
    return driverEarnings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DriverEarningsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driverEarningsHash() => r'51a9f179b24fbd4092cffe42f9134a5c5a92ff82';

/// Earnings aggregate for the earnings tab.

final class DriverEarningsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EarningsSummary>, String> {
  DriverEarningsFamily._()
    : super(
        retry: null,
        name: r'driverEarningsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Earnings aggregate for the earnings tab.

  DriverEarningsProvider call(String driverId) =>
      DriverEarningsProvider._(argument: driverId, from: this);

  @override
  String toString() => r'driverEarningsProvider';
}

/// Driver record + vehicle documents for the documents tab.

@ProviderFor(driverDocuments)
final driverDocumentsProvider = DriverDocumentsFamily._();

/// Driver record + vehicle documents for the documents tab.

final class DriverDocumentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<({List<VehicleDoc> docs, Driver driver})>,
          ({List<VehicleDoc> docs, Driver driver}),
          FutureOr<({List<VehicleDoc> docs, Driver driver})>
        >
    with
        $FutureModifier<({List<VehicleDoc> docs, Driver driver})>,
        $FutureProvider<({List<VehicleDoc> docs, Driver driver})> {
  /// Driver record + vehicle documents for the documents tab.
  DriverDocumentsProvider._({
    required DriverDocumentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'driverDocumentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driverDocumentsHash();

  @override
  String toString() {
    return r'driverDocumentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<({List<VehicleDoc> docs, Driver driver})>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<({List<VehicleDoc> docs, Driver driver})> create(Ref ref) {
    final argument = this.argument as String;
    return driverDocuments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DriverDocumentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driverDocumentsHash() => r'4bcd356d933b6d57d8c5b23aa89fa1c4743cb63a';

/// Driver record + vehicle documents for the documents tab.

final class DriverDocumentsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<({List<VehicleDoc> docs, Driver driver})>,
          String
        > {
  DriverDocumentsFamily._()
    : super(
        retry: null,
        name: r'driverDocumentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Driver record + vehicle documents for the documents tab.

  DriverDocumentsProvider call(String driverId) =>
      DriverDocumentsProvider._(argument: driverId, from: this);

  @override
  String toString() => r'driverDocumentsProvider';
}

/// Counts queued-but-unsent driver actions for the sync pill badge.

@ProviderFor(driverPendingCount)
final driverPendingCountProvider = DriverPendingCountProvider._();

/// Counts queued-but-unsent driver actions for the sync pill badge.

final class DriverPendingCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Counts queued-but-unsent driver actions for the sync pill badge.
  DriverPendingCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverPendingCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverPendingCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return driverPendingCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$driverPendingCountHash() =>
    r'fea8bc74c276499b1f82dccf8998a748f1a7b975';
