import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/hive_boxes.dart';
import 'offline_action.dart';

part 'offline_queue.g.dart';

/// Hive-backed FIFO queue of [OfflineAction].
///
/// The UI applies actions optimistically; the sync engine (sync_engine.dart)
/// drains the queue when online. Photos stay in the app documents
/// directory until uploaded.
@Riverpod(keepAlive: true)
class OfflineQueue extends _$OfflineQueue {
  @override
  List<OfflineAction> build() {
    return _readAll();
  }

  Box<dynamic> get _box => Hive.box(HiveBoxes.offlineQueue);

  List<OfflineAction> _readAll() {
    final List<dynamic> raw =
        _box.get(HiveBoxes.keyActions, defaultValue: <dynamic>[]) as List;
    return raw
        .map((dynamic e) =>
            OfflineAction.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> _persist(List<OfflineAction> actions) async {
    await _box.put(
      HiveBoxes.keyActions,
      actions.map((OfflineAction a) => a.toJson()).toList(),
    );
    if (!ref.mounted) return;
    state = List.unmodifiable(actions);
  }

  Future<void> enqueue(OfflineAction action) async {
    await _persist([...state, action]);
  }

  Future<void> update(String id, OfflineAction Function(OfflineAction) f) async {
    await _persist([
      for (final OfflineAction a in state)
        if (a.id == id) f(a) else a,
    ]);
  }

  /// Removes terminal actions (done / rejected) from the queue.
  Future<void> pruneTerminal() async {
    await _persist(
      state
          .where((OfflineAction a) =>
              a.status != OfflineActionStatus.done &&
              a.status != OfflineActionStatus.rejected)
          .toList(),
    );
  }

  /// Test/demo helper: drops everything.
  Future<void> clear() => _persist([]);
}

/// Pending (non-terminal) action count for the SyncPill.
@riverpod
int pendingSyncCount(Ref ref) {
  final List<OfflineAction> actions = ref.watch(offlineQueueProvider);
  return actions
      .where((OfflineAction a) =>
          a.status == OfflineActionStatus.pending ||
          a.status == OfflineActionStatus.failed ||
          a.status == OfflineActionStatus.uploading)
      .length;
}
