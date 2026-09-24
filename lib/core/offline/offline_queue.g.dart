// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_queue.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Hive-backed FIFO queue of [OfflineAction].
///
/// The UI applies actions optimistically; the sync engine (sync_engine.dart)
/// drains the queue when online. Photos stay in the app documents
/// directory until uploaded.

@ProviderFor(OfflineQueue)
final offlineQueueProvider = OfflineQueueProvider._();

/// Hive-backed FIFO queue of [OfflineAction].
///
/// The UI applies actions optimistically; the sync engine (sync_engine.dart)
/// drains the queue when online. Photos stay in the app documents
/// directory until uploaded.
final class OfflineQueueProvider
    extends $NotifierProvider<OfflineQueue, List<OfflineAction>> {
  /// Hive-backed FIFO queue of [OfflineAction].
  ///
  /// The UI applies actions optimistically; the sync engine (sync_engine.dart)
  /// drains the queue when online. Photos stay in the app documents
  /// directory until uploaded.
  OfflineQueueProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'offlineQueueProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$offlineQueueHash();

  @$internal
  @override
  OfflineQueue create() => OfflineQueue();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OfflineAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OfflineAction>>(value),
    );
  }
}

String _$offlineQueueHash() => r'a3e9d73db039f5daac0fb8a7b1715a5c7ef88ca7';

/// Hive-backed FIFO queue of [OfflineAction].
///
/// The UI applies actions optimistically; the sync engine (sync_engine.dart)
/// drains the queue when online. Photos stay in the app documents
/// directory until uploaded.

abstract class _$OfflineQueue extends $Notifier<List<OfflineAction>> {
  List<OfflineAction> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<OfflineAction>, List<OfflineAction>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<OfflineAction>, List<OfflineAction>>,
        List<OfflineAction>,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}

/// Pending (non-terminal) action count for the SyncPill.

@ProviderFor(pendingSyncCount)
final pendingSyncCountProvider = PendingSyncCountProvider._();

/// Pending (non-terminal) action count for the SyncPill.

final class PendingSyncCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Pending (non-terminal) action count for the SyncPill.
  PendingSyncCountProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pendingSyncCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pendingSyncCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return pendingSyncCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$pendingSyncCountHash() => r'adee78b09f81cea43e9e9fcac61719b6fe5df770';
