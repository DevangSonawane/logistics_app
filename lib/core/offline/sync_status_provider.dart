import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'offline_queue.dart';
import 'sync_engine.dart';

part 'sync_status_provider.g.dart';

/// Combined pill state: pending count + current activity.
typedef SyncPillState = ({int pending, SyncActivity activity});

@riverpod
SyncPillState syncPillState(Ref ref) {
  final int pending = ref.watch(pendingSyncCountProvider);
  final SyncActivity activity = ref.watch(syncStatusProvider);
  return (pending: pending, activity: activity);
}
