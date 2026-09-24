// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountant_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(accountKpis)
final accountKpisProvider = AccountKpisProvider._();

final class AccountKpisProvider extends $FunctionalProvider<
        AsyncValue<DashboardKpis>, DashboardKpis, FutureOr<DashboardKpis>>
    with $FutureModifier<DashboardKpis>, $FutureProvider<DashboardKpis> {
  AccountKpisProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'accountKpisProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$accountKpisHash();

  @$internal
  @override
  $FutureProviderElement<DashboardKpis> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DashboardKpis> create(Ref ref) {
    return accountKpis(ref);
  }
}

String _$accountKpisHash() => r'58617fc75dd42a7c4da5dd1e0aae2ff57ad70630';

@ProviderFor(accountGst)
final accountGstProvider = AccountGstProvider._();

final class AccountGstProvider extends $FunctionalProvider<
        AsyncValue<GstSummary>, GstSummary, FutureOr<GstSummary>>
    with $FutureModifier<GstSummary>, $FutureProvider<GstSummary> {
  AccountGstProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'accountGstProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$accountGstHash();

  @$internal
  @override
  $FutureProviderElement<GstSummary> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GstSummary> create(Ref ref) {
    return accountGst(ref);
  }
}

String _$accountGstHash() => r'96635077c886b97483a1673e10d8d13b786fc228';

@ProviderFor(invoices)
final invoicesProvider = InvoicesProvider._();

final class InvoicesProvider extends $FunctionalProvider<
        AsyncValue<List<Invoice>>, List<Invoice>, FutureOr<List<Invoice>>>
    with $FutureModifier<List<Invoice>>, $FutureProvider<List<Invoice>> {
  InvoicesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'invoicesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$invoicesHash();

  @$internal
  @override
  $FutureProviderElement<List<Invoice>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Invoice>> create(Ref ref) {
    return invoices(ref);
  }
}

String _$invoicesHash() => r'b1c01d16f17d9ecb378a909b624d063e41cdb88b';

@ProviderFor(accountCustomers)
final accountCustomersProvider = AccountCustomersProvider._();

final class AccountCustomersProvider extends $FunctionalProvider<
        AsyncValue<List<Customer>>, List<Customer>, FutureOr<List<Customer>>>
    with $FutureModifier<List<Customer>>, $FutureProvider<List<Customer>> {
  AccountCustomersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'accountCustomersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$accountCustomersHash();

  @$internal
  @override
  $FutureProviderElement<List<Customer>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Customer>> create(Ref ref) {
    return accountCustomers(ref);
  }
}

String _$accountCustomersHash() => r'5cb2d1bdc8a3d2a1898c996418bbb1b25f3779ef';

/// Overdue customers sorted by outstanding (reminder priority).

@ProviderFor(overdueCustomers)
final overdueCustomersProvider = OverdueCustomersProvider._();

/// Overdue customers sorted by outstanding (reminder priority).

final class OverdueCustomersProvider extends $FunctionalProvider<
        AsyncValue<List<Customer>>, List<Customer>, FutureOr<List<Customer>>>
    with $FutureModifier<List<Customer>>, $FutureProvider<List<Customer>> {
  /// Overdue customers sorted by outstanding (reminder priority).
  OverdueCustomersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'overdueCustomersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$overdueCustomersHash();

  @$internal
  @override
  $FutureProviderElement<List<Customer>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Customer>> create(Ref ref) {
    return overdueCustomers(ref);
  }
}

String _$overdueCustomersHash() => r'63fd79e9ec31425da4a71248d0c69d3449349517';
