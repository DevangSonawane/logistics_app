// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Single place to swap mock <-> real implementations.
/// Tests override these providers; UI code never instantiates repositories.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// Single place to swap mock <-> real implementations.
/// Tests override these providers; UI code never instantiates repositories.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Single place to swap mock <-> real implementations.
  /// Tests override these providers; UI code never instantiates repositories.
  AuthRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'387b6e9a78d246a81ba25c340fe035788819ea94';

/// Driver-scope stores with in-memory demo state (Phase 3).
/// Ops/owner/finance repositories land in Phases 4-7.

@ProviderFor(tripRepository)
final tripRepositoryProvider = TripRepositoryProvider._();

/// Driver-scope stores with in-memory demo state (Phase 3).
/// Ops/owner/finance repositories land in Phases 4-7.

final class TripRepositoryProvider
    extends $FunctionalProvider<TripRepository, TripRepository, TripRepository>
    with $Provider<TripRepository> {
  /// Driver-scope stores with in-memory demo state (Phase 3).
  /// Ops/owner/finance repositories land in Phases 4-7.
  TripRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tripRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tripRepositoryHash();

  @$internal
  @override
  $ProviderElement<TripRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TripRepository create(Ref ref) {
    return tripRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripRepository>(value),
    );
  }
}

String _$tripRepositoryHash() => r'69dd2422bdc3dd61da75df076445121c130d5e05';

/// Mock stores hold demo state per container; keep alive for the session.

@ProviderFor(expenseRepository)
final expenseRepositoryProvider = ExpenseRepositoryProvider._();

/// Mock stores hold demo state per container; keep alive for the session.

final class ExpenseRepositoryProvider extends $FunctionalProvider<
    ExpenseRepository,
    ExpenseRepository,
    ExpenseRepository> with $Provider<ExpenseRepository> {
  /// Mock stores hold demo state per container; keep alive for the session.
  ExpenseRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'expenseRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$expenseRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExpenseRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExpenseRepository create(Ref ref) {
    return expenseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpenseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpenseRepository>(value),
    );
  }
}

String _$expenseRepositoryHash() => r'a210aa8a9c81b5400c0260443b78fc3b7eb49878';

@ProviderFor(advanceRepository)
final advanceRepositoryProvider = AdvanceRepositoryProvider._();

final class AdvanceRepositoryProvider extends $FunctionalProvider<
    AdvanceRepository,
    AdvanceRepository,
    AdvanceRepository> with $Provider<AdvanceRepository> {
  AdvanceRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'advanceRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$advanceRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdvanceRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdvanceRepository create(Ref ref) {
    return advanceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdvanceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdvanceRepository>(value),
    );
  }
}

String _$advanceRepositoryHash() => r'f19b777f5591bd97f3b7297636d1f738911930e4';

@ProviderFor(driverRepository)
final driverRepositoryProvider = DriverRepositoryProvider._();

final class DriverRepositoryProvider extends $FunctionalProvider<
    DriverRepository,
    DriverRepository,
    DriverRepository> with $Provider<DriverRepository> {
  DriverRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'driverRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$driverRepositoryHash();

  @$internal
  @override
  $ProviderElement<DriverRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DriverRepository create(Ref ref) {
    return driverRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriverRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriverRepository>(value),
    );
  }
}

String _$driverRepositoryHash() => r'eb119be8cc67c75d3d954e1bfcf6f7b5634b7876';

@ProviderFor(customerRepository)
final customerRepositoryProvider = CustomerRepositoryProvider._();

final class CustomerRepositoryProvider extends $FunctionalProvider<
    CustomerRepository,
    CustomerRepository,
    CustomerRepository> with $Provider<CustomerRepository> {
  CustomerRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'customerRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$customerRepositoryHash();

  @$internal
  @override
  $ProviderElement<CustomerRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CustomerRepository create(Ref ref) {
    return customerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomerRepository>(value),
    );
  }
}

String _$customerRepositoryHash() =>
    r'bd6c5b08cae4ef55700c6bf618ae6d31c80029da';

@ProviderFor(orderRepository)
final orderRepositoryProvider = OrderRepositoryProvider._();

final class OrderRepositoryProvider extends $FunctionalProvider<OrderRepository,
    OrderRepository, OrderRepository> with $Provider<OrderRepository> {
  OrderRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'orderRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$orderRepositoryHash();

  @$internal
  @override
  $ProviderElement<OrderRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderRepository create(Ref ref) {
    return orderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderRepository>(value),
    );
  }
}

String _$orderRepositoryHash() => r'dee06663f1fff54035d6193c01ba818caa5c4917';

@ProviderFor(vehicleRepository)
final vehicleRepositoryProvider = VehicleRepositoryProvider._();

final class VehicleRepositoryProvider extends $FunctionalProvider<
    VehicleRepository,
    VehicleRepository,
    VehicleRepository> with $Provider<VehicleRepository> {
  VehicleRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'vehicleRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$vehicleRepositoryHash();

  @$internal
  @override
  $ProviderElement<VehicleRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VehicleRepository create(Ref ref) {
    return vehicleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleRepository>(value),
    );
  }
}

String _$vehicleRepositoryHash() => r'ad1bc4cb4f05722413c8e5e54ee1510e6fc25e43';

@ProviderFor(dashboardRepository)
final dashboardRepositoryProvider = DashboardRepositoryProvider._();

final class DashboardRepositoryProvider extends $FunctionalProvider<
    DashboardRepository,
    DashboardRepository,
    DashboardRepository> with $Provider<DashboardRepository> {
  DashboardRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dashboardRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dashboardRepositoryHash();

  @$internal
  @override
  $ProviderElement<DashboardRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DashboardRepository create(Ref ref) {
    return dashboardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardRepository>(value),
    );
  }
}

String _$dashboardRepositoryHash() =>
    r'f0a439955ba7aea30048e1984431eb159a16b263';

@ProviderFor(approvalRepository)
final approvalRepositoryProvider = ApprovalRepositoryProvider._();

final class ApprovalRepositoryProvider extends $FunctionalProvider<
    ApprovalRepository,
    ApprovalRepository,
    ApprovalRepository> with $Provider<ApprovalRepository> {
  ApprovalRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'approvalRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$approvalRepositoryHash();

  @$internal
  @override
  $ProviderElement<ApprovalRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApprovalRepository create(Ref ref) {
    return approvalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApprovalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApprovalRepository>(value),
    );
  }
}

String _$approvalRepositoryHash() =>
    r'f19bed5c7c9366bd86ea0b2d358b60d6dc1b61ba';

@ProviderFor(financeRepository)
final financeRepositoryProvider = FinanceRepositoryProvider._();

final class FinanceRepositoryProvider extends $FunctionalProvider<
    FinanceRepository,
    FinanceRepository,
    FinanceRepository> with $Provider<FinanceRepository> {
  FinanceRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'financeRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$financeRepositoryHash();

  @$internal
  @override
  $ProviderElement<FinanceRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FinanceRepository create(Ref ref) {
    return financeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinanceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinanceRepository>(value),
    );
  }
}

String _$financeRepositoryHash() => r'7244f82d7afe649c736f69e78504d6e370a6a57f';

@ProviderFor(exceptionRepository)
final exceptionRepositoryProvider = ExceptionRepositoryProvider._();

final class ExceptionRepositoryProvider extends $FunctionalProvider<
    ExceptionRepository,
    ExceptionRepository,
    ExceptionRepository> with $Provider<ExceptionRepository> {
  ExceptionRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'exceptionRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$exceptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExceptionRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExceptionRepository create(Ref ref) {
    return exceptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExceptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExceptionRepository>(value),
    );
  }
}

String _$exceptionRepositoryHash() =>
    r'10b9e643e55fc856f0952b1d9b86f94339dee246';

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider extends $FunctionalProvider<
    NotificationRepository,
    NotificationRepository,
    NotificationRepository> with $Provider<NotificationRepository> {
  NotificationRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'85ae8f79dca17fc1cfca5bfa0c4adc70c7a90ed3';

/// Hire repo shares the approval store so above-limit advances raise
/// inbox items (wired here to keep UI code free of repository plumbing).

@ProviderFor(hireRepository)
final hireRepositoryProvider = HireRepositoryProvider._();

/// Hire repo shares the approval store so above-limit advances raise
/// inbox items (wired here to keep UI code free of repository plumbing).

final class HireRepositoryProvider
    extends $FunctionalProvider<HireRepository, HireRepository, HireRepository>
    with $Provider<HireRepository> {
  /// Hire repo shares the approval store so above-limit advances raise
  /// inbox items (wired here to keep UI code free of repository plumbing).
  HireRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'hireRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hireRepositoryHash();

  @$internal
  @override
  $ProviderElement<HireRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HireRepository create(Ref ref) {
    return hireRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HireRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HireRepository>(value),
    );
  }
}

String _$hireRepositoryHash() => r'cb71904bbc01994ae36e802e20f8352a00f3f93c';

@ProviderFor(leadRepository)
final leadRepositoryProvider = LeadRepositoryProvider._();

final class LeadRepositoryProvider
    extends $FunctionalProvider<LeadRepository, LeadRepository, LeadRepository>
    with $Provider<LeadRepository> {
  LeadRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'leadRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$leadRepositoryHash();

  @$internal
  @override
  $ProviderElement<LeadRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LeadRepository create(Ref ref) {
    return leadRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LeadRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LeadRepository>(value),
    );
  }
}

String _$leadRepositoryHash() => r'f2108a290294d699f40a42b888228f77bbb583a5';

@ProviderFor(hubRepository)
final hubRepositoryProvider = HubRepositoryProvider._();

final class HubRepositoryProvider
    extends $FunctionalProvider<HubRepository, HubRepository, HubRepository>
    with $Provider<HubRepository> {
  HubRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'hubRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hubRepositoryHash();

  @$internal
  @override
  $ProviderElement<HubRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HubRepository create(Ref ref) {
    return hubRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HubRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HubRepository>(value),
    );
  }
}

String _$hubRepositoryHash() => r'a683595ff88a61557da679d60b806f66ac265cee';

@ProviderFor(invoiceRepository)
final invoiceRepositoryProvider = InvoiceRepositoryProvider._();

final class InvoiceRepositoryProvider extends $FunctionalProvider<
    InvoiceRepository,
    InvoiceRepository,
    InvoiceRepository> with $Provider<InvoiceRepository> {
  InvoiceRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'invoiceRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$invoiceRepositoryHash();

  @$internal
  @override
  $ProviderElement<InvoiceRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InvoiceRepository create(Ref ref) {
    return invoiceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InvoiceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InvoiceRepository>(value),
    );
  }
}

String _$invoiceRepositoryHash() => r'c259f34a9b3a23f27c246c8afd54650ad350eada';
