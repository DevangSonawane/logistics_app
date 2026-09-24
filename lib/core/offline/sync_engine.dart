import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/constants.dart';

part 'sync_engine.g.dart';

/// Sync engine: drains the offline queue FIFO with exponential backoff.
///
/// Triggers (wired in Phase 3 driver flows): connectivity regained, app
/// resume, manual "Sync now", and every 60 s while online with pending > 0.
/// Backoff: 5 s, 15 s, 45 s, 2 m, 5 m; max 8 tries, then Failed.
///
/// Conflict rule: the server (Ops) wins for trip reassignment/cancellation.
/// A rejected action is marked `rejected` with the reason and the UI shows
/// a dialog + refreshes the trip.
class SyncEngine {
  SyncEngine({Random? random}) : _random = random ?? Random();

  final Random _random;

  /// Backoff before the next attempt for the given retry count.
  /// Adds up to 20% jitter so a fleet does not retry in lockstep.
  Duration backoffForAttempt(int retryCount) {
    const List<int> scheduleSeconds = [5, 15, 45, 120, 300];
    final int capped = min(retryCount, scheduleSeconds.length - 1);
    final int base = scheduleSeconds[capped];
    final int jitter = (base * 0.2 * _random.nextDouble()).round();
    return Duration(seconds: base + jitter);
  }

  /// Whether another attempt is allowed.
  bool canRetry(int retryCount) =>
      retryCount < AppConstants.syncMaxRetries;
}

/// Current sync activity for banners and the queue page.
enum SyncActivity { idle, syncing, offline, failed }

/// Watches connectivity + queue in Phase 3; idle until then.
/// TODO(Phase 3): implement drain loop (connectivity regain, app resume,
/// 60 s poll) and wire uploader callbacks per action type.
@Riverpod(keepAlive: true)
class SyncStatus extends _$SyncStatus {
  @override
  SyncActivity build() => SyncActivity.idle;

  // ignore: use_setters_to_change_properties
  void setActivity(SyncActivity activity) {
    state = activity;
  }
}
