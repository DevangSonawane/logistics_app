// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_engine.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Watches connectivity + queue in Phase 3; idle until then.
/// TODO(Phase 3): implement drain loop (connectivity regain, app resume,
/// 60 s poll) and wire uploader callbacks per action type.

@ProviderFor(SyncStatus)
final syncStatusProvider = SyncStatusProvider._();

/// Watches connectivity + queue in Phase 3; idle until then.
/// TODO(Phase 3): implement drain loop (connectivity regain, app resume,
/// 60 s poll) and wire uploader callbacks per action type.
final class SyncStatusProvider
    extends $NotifierProvider<SyncStatus, SyncActivity> {
  /// Watches connectivity + queue in Phase 3; idle until then.
  /// TODO(Phase 3): implement drain loop (connectivity regain, app resume,
  /// 60 s poll) and wire uploader callbacks per action type.
  SyncStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'syncStatusProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$syncStatusHash();

  @$internal
  @override
  SyncStatus create() => SyncStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncActivity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncActivity>(value),
    );
  }
}

String _$syncStatusHash() => r'004381a1018e8424af64b445f3852c4a5b464b83';

/// Watches connectivity + queue in Phase 3; idle until then.
/// TODO(Phase 3): implement drain loop (connectivity regain, app resume,
/// 60 s poll) and wire uploader callbacks per action type.

abstract class _$SyncStatus extends $Notifier<SyncActivity> {
  SyncActivity build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SyncActivity, SyncActivity>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SyncActivity, SyncActivity>,
        SyncActivity,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}

/// Drives the offline queue: manual "Sync now", connectivity-regain trigger
/// and a 60 s poll while items are pending. FIFO with exponential backoff;
/// server-wins conflicts mark actions rejected for the UI dialog path.

@ProviderFor(SyncController)
final syncControllerProvider = SyncControllerProvider._();

/// Drives the offline queue: manual "Sync now", connectivity-regain trigger
/// and a 60 s poll while items are pending. FIFO with exponential backoff;
/// server-wins conflicts mark actions rejected for the UI dialog path.
final class SyncControllerProvider
    extends $NotifierProvider<SyncController, bool> {
  /// Drives the offline queue: manual "Sync now", connectivity-regain trigger
  /// and a 60 s poll while items are pending. FIFO with exponential backoff;
  /// server-wins conflicts mark actions rejected for the UI dialog path.
  SyncControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'syncControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$syncControllerHash();

  @$internal
  @override
  SyncController create() => SyncController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$syncControllerHash() => r'399f3cf70699faa7840b78613999cc7746b3da83';

/// Drives the offline queue: manual "Sync now", connectivity-regain trigger
/// and a 60 s poll while items are pending. FIFO with exponential backoff;
/// server-wins conflicts mark actions rejected for the UI dialog path.

abstract class _$SyncController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
