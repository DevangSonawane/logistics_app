// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncPillState)
final syncPillStateProvider = SyncPillStateProvider._();

final class SyncPillStateProvider
    extends $FunctionalProvider<SyncPillState, SyncPillState, SyncPillState>
    with $Provider<SyncPillState> {
  SyncPillStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'syncPillStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$syncPillStateHash();

  @$internal
  @override
  $ProviderElement<SyncPillState> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncPillState create(Ref ref) {
    return syncPillState(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncPillState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncPillState>(value),
    );
  }
}

String _$syncPillStateHash() => r'aaff609bfe1380cdff640e26509888ff2f92e140';
