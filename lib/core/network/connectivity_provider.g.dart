// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Raw connectivity stream. The app treats "no network interface" as
/// offline; captive portals are handled by failed sync attempts.

@ProviderFor(connectivity)
final connectivityProvider = ConnectivityProvider._();

/// Raw connectivity stream. The app treats "no network interface" as
/// offline; captive portals are handled by failed sync attempts.

final class ConnectivityProvider extends $FunctionalProvider<
        AsyncValue<List<ConnectivityResult>>,
        List<ConnectivityResult>,
        Stream<List<ConnectivityResult>>>
    with
        $FutureModifier<List<ConnectivityResult>>,
        $StreamProvider<List<ConnectivityResult>> {
  /// Raw connectivity stream. The app treats "no network interface" as
  /// offline; captive portals are handled by failed sync attempts.
  ConnectivityProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'connectivityProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$connectivityHash();

  @$internal
  @override
  $StreamProviderElement<List<ConnectivityResult>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<ConnectivityResult>> create(Ref ref) {
    return connectivity(ref);
  }
}

String _$connectivityHash() => r'69c6e2db8337a9ff832358c4a079a4846fa6f28c';

/// True unless all interfaces report [ConnectivityResult.none].
/// Defaults to online while the first event is pending.

@ProviderFor(isOnline)
final isOnlineProvider = IsOnlineProvider._();

/// True unless all interfaces report [ConnectivityResult.none].
/// Defaults to online while the first event is pending.

final class IsOnlineProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// True unless all interfaces report [ConnectivityResult.none].
  /// Defaults to online while the first event is pending.
  IsOnlineProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isOnlineProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isOnlineHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isOnline(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isOnlineHash() => r'0edb2b02a076a1c2c4e765fdd2de1a93720f0f9e';
