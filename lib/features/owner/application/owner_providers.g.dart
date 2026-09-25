// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ownerKpis)
final ownerKpisProvider = OwnerKpisFamily._();

final class OwnerKpisProvider
    extends
        $FunctionalProvider<
          AsyncValue<DashboardKpis>,
          DashboardKpis,
          FutureOr<DashboardKpis>
        >
    with $FutureModifier<DashboardKpis>, $FutureProvider<DashboardKpis> {
  OwnerKpisProvider._({
    required OwnerKpisFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ownerKpisProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ownerKpisHash();

  @override
  String toString() {
    return r'ownerKpisProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<DashboardKpis> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DashboardKpis> create(Ref ref) {
    final argument = this.argument as String;
    return ownerKpis(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OwnerKpisProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ownerKpisHash() => r'e7297d3c56340331084a49c957a1fd59d5f61d53';

final class OwnerKpisFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<DashboardKpis>, String> {
  OwnerKpisFamily._()
    : super(
        retry: null,
        name: r'ownerKpisProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OwnerKpisProvider call(String branchId) =>
      OwnerKpisProvider._(argument: branchId, from: this);

  @override
  String toString() => r'ownerKpisProvider';
}

@ProviderFor(revenueTrend)
final revenueTrendProvider = RevenueTrendProvider._();

final class RevenueTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TrendPoint>>,
          List<TrendPoint>,
          FutureOr<List<TrendPoint>>
        >
    with $FutureModifier<List<TrendPoint>>, $FutureProvider<List<TrendPoint>> {
  RevenueTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'revenueTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$revenueTrendHash();

  @$internal
  @override
  $FutureProviderElement<List<TrendPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TrendPoint>> create(Ref ref) {
    return revenueTrend(ref);
  }
}

String _$revenueTrendHash() => r'90ab726ab2f6d422a02747ccb4a6b627bab49b4c';

@ProviderFor(topLanes)
final topLanesProvider = TopLanesProvider._();

final class TopLanesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LaneMargin>>,
          List<LaneMargin>,
          FutureOr<List<LaneMargin>>
        >
    with $FutureModifier<List<LaneMargin>>, $FutureProvider<List<LaneMargin>> {
  TopLanesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'topLanesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$topLanesHash();

  @$internal
  @override
  $FutureProviderElement<List<LaneMargin>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LaneMargin>> create(Ref ref) {
    return topLanes(ref);
  }
}

String _$topLanesHash() => r'0750360bae992b87081ae55ab50809e9ff7366c2';

@ProviderFor(bottomCustomers)
final bottomCustomersProvider = BottomCustomersProvider._();

final class BottomCustomersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CustomerMargin>>,
          List<CustomerMargin>,
          FutureOr<List<CustomerMargin>>
        >
    with
        $FutureModifier<List<CustomerMargin>>,
        $FutureProvider<List<CustomerMargin>> {
  BottomCustomersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bottomCustomersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bottomCustomersHash();

  @$internal
  @override
  $FutureProviderElement<List<CustomerMargin>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CustomerMargin>> create(Ref ref) {
    return bottomCustomers(ref);
  }
}

String _$bottomCustomersHash() => r'295c11b4437414d9e9c28b874aa224af232bf986';

@ProviderFor(attention)
final attentionProvider = AttentionProvider._();

final class AttentionProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AttentionItem>>,
          List<AttentionItem>,
          FutureOr<List<AttentionItem>>
        >
    with
        $FutureModifier<List<AttentionItem>>,
        $FutureProvider<List<AttentionItem>> {
  AttentionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attentionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attentionHash();

  @$internal
  @override
  $FutureProviderElement<List<AttentionItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AttentionItem>> create(Ref ref) {
    return attention(ref);
  }
}

String _$attentionHash() => r'7cc89765675df9ad83d31b5882be7a77a9ee3d59';

@ProviderFor(dailyBrief)
final dailyBriefProvider = DailyBriefProvider._();

final class DailyBriefProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  DailyBriefProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyBriefProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyBriefHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return dailyBrief(ref);
  }
}

String _$dailyBriefHash() => r'c404f8f0ed296e1b27a2658ea88f415245b4ac79';

@ProviderFor(approvalInbox)
final approvalInboxProvider = ApprovalInboxProvider._();

final class ApprovalInboxProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ApprovalItem>>,
          List<ApprovalItem>,
          FutureOr<List<ApprovalItem>>
        >
    with
        $FutureModifier<List<ApprovalItem>>,
        $FutureProvider<List<ApprovalItem>> {
  ApprovalInboxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'approvalInboxProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$approvalInboxHash();

  @$internal
  @override
  $FutureProviderElement<List<ApprovalItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ApprovalItem>> create(Ref ref) {
    return approvalInbox(ref);
  }
}

String _$approvalInboxHash() => r'6798702f310b4fcd1b3b25699cd07fc0034d518c';

@ProviderFor(pendingApprovalsCount)
final pendingApprovalsCountProvider = PendingApprovalsCountProvider._();

final class PendingApprovalsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  PendingApprovalsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingApprovalsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingApprovalsCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return pendingApprovalsCount(ref);
  }
}

String _$pendingApprovalsCountHash() =>
    r'2a98f922900ed7cb581c212072f24e90df612dcc';

@ProviderFor(unreadNotificationsCount)
final unreadNotificationsCountProvider = UnreadNotificationsCountProvider._();

final class UnreadNotificationsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  UnreadNotificationsCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationsCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationsCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return unreadNotificationsCount(ref);
  }
}

String _$unreadNotificationsCountHash() =>
    r'c642f81d3916ccccfc6862b4edb6dbdfb993e1ae';

@ProviderFor(liveTrips)
final liveTripsProvider = LiveTripsProvider._();

final class LiveTripsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Trip>>,
          List<Trip>,
          FutureOr<List<Trip>>
        >
    with $FutureModifier<List<Trip>>, $FutureProvider<List<Trip>> {
  LiveTripsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveTripsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveTripsHash();

  @$internal
  @override
  $FutureProviderElement<List<Trip>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Trip>> create(Ref ref) {
    return liveTrips(ref);
  }
}

String _$liveTripsHash() => r'e45542fa8e6c447801a72b2f076cf6509114bf9f';

@ProviderFor(fleetVehicles)
final fleetVehiclesProvider = FleetVehiclesProvider._();

final class FleetVehiclesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Vehicle>>,
          List<Vehicle>,
          FutureOr<List<Vehicle>>
        >
    with $FutureModifier<List<Vehicle>>, $FutureProvider<List<Vehicle>> {
  FleetVehiclesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fleetVehiclesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fleetVehiclesHash();

  @$internal
  @override
  $FutureProviderElement<List<Vehicle>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vehicle>> create(Ref ref) {
    return fleetVehicles(ref);
  }
}

String _$fleetVehiclesHash() => r'57deb1d38350ba19ab779c56a19ec60eeb6c1d46';

@ProviderFor(openExceptions)
final openExceptionsProvider = OpenExceptionsProvider._();

final class OpenExceptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExceptionItem>>,
          List<ExceptionItem>,
          FutureOr<List<ExceptionItem>>
        >
    with
        $FutureModifier<List<ExceptionItem>>,
        $FutureProvider<List<ExceptionItem>> {
  OpenExceptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openExceptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openExceptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<ExceptionItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExceptionItem>> create(Ref ref) {
    return openExceptions(ref);
  }
}

String _$openExceptionsHash() => r'c7dfb94fc1a84513766482b5d8b0152287219f21';

@ProviderFor(ageingBuckets)
final ageingBucketsProvider = AgeingBucketsProvider._();

final class AgeingBucketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AgeingBucket>>,
          List<AgeingBucket>,
          FutureOr<List<AgeingBucket>>
        >
    with
        $FutureModifier<List<AgeingBucket>>,
        $FutureProvider<List<AgeingBucket>> {
  AgeingBucketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ageingBucketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ageingBucketsHash();

  @$internal
  @override
  $FutureProviderElement<List<AgeingBucket>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AgeingBucket>> create(Ref ref) {
    return ageingBuckets(ref);
  }
}

String _$ageingBucketsHash() => r'4d1f167ddb482878ea6ea65edc6e60dff9e59829';

@ProviderFor(bankBalances)
final bankBalancesProvider = BankBalancesProvider._();

final class BankBalancesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BankAccount>>,
          List<BankAccount>,
          FutureOr<List<BankAccount>>
        >
    with
        $FutureModifier<List<BankAccount>>,
        $FutureProvider<List<BankAccount>> {
  BankBalancesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bankBalancesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bankBalancesHash();

  @$internal
  @override
  $FutureProviderElement<List<BankAccount>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BankAccount>> create(Ref ref) {
    return bankBalances(ref);
  }
}

String _$bankBalancesHash() => r'f47d5c4650c680e48deea183a7bfcb3e808799e5';

@ProviderFor(gstSummary)
final gstSummaryProvider = GstSummaryProvider._();

final class GstSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<GstSummary>,
          GstSummary,
          FutureOr<GstSummary>
        >
    with $FutureModifier<GstSummary>, $FutureProvider<GstSummary> {
  GstSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gstSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gstSummaryHash();

  @$internal
  @override
  $FutureProviderElement<GstSummary> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GstSummary> create(Ref ref) {
    return gstSummary(ref);
  }
}

String _$gstSummaryHash() => r'257e48f0242be62583a23ed8624b47c4d45de664';

@ProviderFor(daybook)
final daybookProvider = DaybookProvider._();

final class DaybookProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LedgerEntry>>,
          List<LedgerEntry>,
          FutureOr<List<LedgerEntry>>
        >
    with
        $FutureModifier<List<LedgerEntry>>,
        $FutureProvider<List<LedgerEntry>> {
  DaybookProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'daybookProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$daybookHash();

  @$internal
  @override
  $FutureProviderElement<List<LedgerEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LedgerEntry>> create(Ref ref) {
    return daybook(ref);
  }
}

String _$daybookHash() => r'3c9a69dcecfbd413f1b2b990cb2a6f7ecabb98c1';

@ProviderFor(tripPnl)
final tripPnlProvider = TripPnlProvider._();

final class TripPnlProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TripPnl>>,
          List<TripPnl>,
          FutureOr<List<TripPnl>>
        >
    with $FutureModifier<List<TripPnl>>, $FutureProvider<List<TripPnl>> {
  TripPnlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripPnlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripPnlHash();

  @$internal
  @override
  $FutureProviderElement<List<TripPnl>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TripPnl>> create(Ref ref) {
    return tripPnl(ref);
  }
}

String _$tripPnlHash() => r'dabe9699286b78c86a3a0889026b17f1da65110f';

@ProviderFor(pnl)
final pnlProvider = PnlProvider._();

final class PnlProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PnlLine>>,
          List<PnlLine>,
          FutureOr<List<PnlLine>>
        >
    with $FutureModifier<List<PnlLine>>, $FutureProvider<List<PnlLine>> {
  PnlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pnlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pnlHash();

  @$internal
  @override
  $FutureProviderElement<List<PnlLine>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PnlLine>> create(Ref ref) {
    return pnl(ref);
  }
}

String _$pnlHash() => r'6519c53ca21b1be54287b9e71ed11eba9ef72377';

@ProviderFor(customers)
final customersProvider = CustomersProvider._();

final class CustomersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Customer>>,
          List<Customer>,
          FutureOr<List<Customer>>
        >
    with $FutureModifier<List<Customer>>, $FutureProvider<List<Customer>> {
  CustomersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customersHash();

  @$internal
  @override
  $FutureProviderElement<List<Customer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Customer>> create(Ref ref) {
    return customers(ref);
  }
}

String _$customersHash() => r'889aa06b11633a70d088ddd720da53267619cd9d';

@ProviderFor(customerLedger)
final customerLedgerProvider = CustomerLedgerFamily._();

final class CustomerLedgerProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LedgerEntry>>,
          List<LedgerEntry>,
          FutureOr<List<LedgerEntry>>
        >
    with
        $FutureModifier<List<LedgerEntry>>,
        $FutureProvider<List<LedgerEntry>> {
  CustomerLedgerProvider._({
    required CustomerLedgerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'customerLedgerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$customerLedgerHash();

  @override
  String toString() {
    return r'customerLedgerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<LedgerEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LedgerEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return customerLedger(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerLedgerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$customerLedgerHash() => r'e8097d7562776cedd2aaec49137c09eea0a13149';

final class CustomerLedgerFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LedgerEntry>>, String> {
  CustomerLedgerFamily._()
    : super(
        retry: null,
        name: r'customerLedgerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CustomerLedgerProvider call(String customerId) =>
      CustomerLedgerProvider._(argument: customerId, from: this);

  @override
  String toString() => r'customerLedgerProvider';
}

@ProviderFor(vendorLedger)
final vendorLedgerProvider = VendorLedgerFamily._();

final class VendorLedgerProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LedgerEntry>>,
          List<LedgerEntry>,
          FutureOr<List<LedgerEntry>>
        >
    with
        $FutureModifier<List<LedgerEntry>>,
        $FutureProvider<List<LedgerEntry>> {
  VendorLedgerProvider._({
    required VendorLedgerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vendorLedgerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vendorLedgerHash();

  @override
  String toString() {
    return r'vendorLedgerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<LedgerEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LedgerEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return vendorLedger(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VendorLedgerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vendorLedgerHash() => r'aca616c5c21615c925183a5252237cd34472eeb1';

final class VendorLedgerFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LedgerEntry>>, String> {
  VendorLedgerFamily._()
    : super(
        retry: null,
        name: r'vendorLedgerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VendorLedgerProvider call(String vendor) =>
      VendorLedgerProvider._(argument: vendor, from: this);

  @override
  String toString() => r'vendorLedgerProvider';
}

@ProviderFor(contractRate)
final contractRateProvider = ContractRateFamily._();

final class ContractRateProvider
    extends $FunctionalProvider<AsyncValue<int?>, int?, FutureOr<int?>>
    with $FutureModifier<int?>, $FutureProvider<int?> {
  ContractRateProvider._({
    required ContractRateFamily super.from,
    required (String, String, String) super.argument,
  }) : super(
         retry: null,
         name: r'contractRateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contractRateHash();

  @override
  String toString() {
    return r'contractRateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int?> create(Ref ref) {
    final argument = this.argument as (String, String, String);
    return contractRate(ref, argument.$1, argument.$2, argument.$3);
  }

  @override
  bool operator ==(Object other) {
    return other is ContractRateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contractRateHash() => r'962617d00cdb41b56602fac22301eba0207a6050';

final class ContractRateFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int?>, (String, String, String)> {
  ContractRateFamily._()
    : super(
        retry: null,
        name: r'contractRateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContractRateProvider call(String from, String to, String vehicle) =>
      ContractRateProvider._(argument: (from, to, vehicle), from: this);

  @override
  String toString() => r'contractRateProvider';
}

@ProviderFor(allOrders)
final allOrdersProvider = AllOrdersProvider._();

final class AllOrdersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Order>>,
          List<Order>,
          FutureOr<List<Order>>
        >
    with $FutureModifier<List<Order>>, $FutureProvider<List<Order>> {
  AllOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allOrdersHash();

  @$internal
  @override
  $FutureProviderElement<List<Order>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Order>> create(Ref ref) {
    return allOrders(ref);
  }
}

String _$allOrdersHash() => r'd7d46af28ce75318254d6b06bd1e95e894eb10d9';

@ProviderFor(notifications)
final notificationsProvider = NotificationsProvider._();

final class NotificationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AppNotification>>,
          List<AppNotification>,
          FutureOr<List<AppNotification>>
        >
    with
        $FutureModifier<List<AppNotification>>,
        $FutureProvider<List<AppNotification>> {
  NotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsHash();

  @$internal
  @override
  $FutureProviderElement<List<AppNotification>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AppNotification>> create(Ref ref) {
    return notifications(ref);
  }
}

String _$notificationsHash() => r'265b31ff2e52bb2411af73e06133883a54454068';
