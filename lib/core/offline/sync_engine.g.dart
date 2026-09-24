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
