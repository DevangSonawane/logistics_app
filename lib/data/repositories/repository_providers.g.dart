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
