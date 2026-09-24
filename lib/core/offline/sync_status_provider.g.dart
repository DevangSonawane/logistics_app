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

/// Bumped after every drain so trip views reconcile with server truth.

@ProviderFor(SyncGeneration)
final syncGenerationProvider = SyncGenerationProvider._();

/// Bumped after every drain so trip views reconcile with server truth.
final class SyncGenerationProvider
    extends $NotifierProvider<SyncGeneration, int> {
  /// Bumped after every drain so trip views reconcile with server truth.
  SyncGenerationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'syncGenerationProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$syncGenerationHash();

  @$internal
  @override
  SyncGeneration create() => SyncGeneration();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$syncGenerationHash() => r'86cc7715e82c1ba14c99260f3782db8a9e8ab4a5';

/// Bumped after every drain so trip views reconcile with server truth.

abstract class _$SyncGeneration extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element = ref.element
        as $ClassProviderElement<AnyNotifier<int, int>, int, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
