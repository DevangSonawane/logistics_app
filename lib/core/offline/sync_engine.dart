import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/mock/mock_delay.dart';
import '../../data/models/advance.dart';
import '../../data/models/expense.dart';
import '../../data/models/trip.dart';
import '../../data/repositories/advance_repository.dart';
import '../../data/repositories/expense_repository.dart';
import '../../data/repositories/repository_providers.dart';
import '../../data/repositories/trip_repository.dart';
import '../config/constants.dart';
import '../network/connectivity_provider.dart';
import 'offline_action.dart';
import 'offline_queue.dart';
import 'sync_status_provider.dart';

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

/// Drain report for manual sync feedback.
typedef SyncReport = ({int uploaded, int failed, int rejected});

/// Drives the offline queue: manual "Sync now", connectivity-regain trigger
/// and a 60 s poll while items are pending. FIFO with exponential backoff;
/// server-wins conflicts mark actions rejected for the UI dialog path.
@Riverpod(keepAlive: true)
class SyncController extends _$SyncController {
  Timer? _poll;

  @override
  bool build() {
    ref.listen(isOnlineProvider, (bool? prev, bool next) {
      if (prev == false && next) {
        unawaited(syncNow());
      }
    });
    ref.onDispose(() => _poll?.cancel());
    return false;
  }

  void _ensurePoll() {
    _poll ??= Timer.periodic(
      const Duration(seconds: AppConstants.syncPollSeconds),
      (_) async {
        if (ref.read(pendingSyncCountProvider) > 0 &&
            ref.read(isOnlineProvider)) {
          await syncNow();
        }
      },
    );
  }

  Future<SyncReport> syncNow() async {
    if (state) return (uploaded: 0, failed: 0, rejected: 0);
    _ensurePoll();
    state = true;
    ref.read(syncStatusProvider.notifier).setActivity(SyncActivity.syncing);
    try {
      return await _drain();
    } finally {
      if (ref.mounted) {
        state = false;
        ref.read(syncStatusProvider.notifier).setActivity(SyncActivity.idle);
        ref.read(syncGenerationProvider.notifier).bump();
      }
    }
  }

  Future<SyncReport> _drain() async {
    final SyncEngine engine = SyncEngine();
    final OfflineQueue queue = ref.read(offlineQueueProvider.notifier);
    final TripRepository trips = ref.read(tripRepositoryProvider);
    final ExpenseRepository expenses = ref.read(expenseRepositoryProvider);
    final AdvanceRepository advances = ref.read(advanceRepositoryProvider);
    int uploaded = 0;
    int failed = 0;
    int rejected = 0;
    final List<OfflineAction> snapshot = ref.read(offlineQueueProvider);
    for (final OfflineAction action in snapshot) {
      if (action.status != OfflineActionStatus.pending &&
          action.status != OfflineActionStatus.failed) {
        continue;
      }
      final String? nextTry = action.payload['nextTryAt'] as String?;
      if (nextTry != null) {
        try {
          if (DateTime.now().isBefore(DateTime.parse(nextTry))) continue;
        } catch (_) {}
      }
      await queue.update(
        action.id,
        (a) => a.copyWith(status: OfflineActionStatus.uploading),
      );
      try {
        await _upload(action, trips, expenses, advances);
        await queue.update(
          action.id,
          (a) => a.copyWith(status: OfflineActionStatus.done),
        );
        uploaded++;
      } on TripConflictException catch (e) {
        await queue.update(
          action.id,
          (a) => a.copyWith(
            status: OfflineActionStatus.rejected,
            failureReason: e.message,
          ),
        );
        rejected++;
      } catch (e) {
        final int next = action.retryCount + 1;
        if (!engine.canRetry(action.retryCount)) {
          await queue.update(
            action.id,
            (a) => a.copyWith(
              status: OfflineActionStatus.failed,
              retryCount: next,
              failureReason: e.toString(),
            ),
          );
        } else {
          final Duration backoff =
              engine.backoffForAttempt(action.retryCount);
          await queue.update(
            action.id,
            (a) => a.copyWith(
              status: OfflineActionStatus.pending,
              retryCount: next,
              failureReason: e.toString(),
              payload: {
                ...a.payload,
                'nextTryAt':
                    DateTime.now().add(backoff).toIso8601String(),
              },
            ),
          );
        }
        failed++;
      }
    }
    await queue.pruneTerminal();
    return (uploaded: uploaded, failed: failed, rejected: rejected);
  }

  Future<void> _upload(
    OfflineAction action,
    TripRepository trips,
    ExpenseRepository expenses,
    AdvanceRepository advances,
  ) async {
    final Map<String, dynamic> p = action.payload;
    switch (action.type) {
      case OfflineActionType.tripStatus:
        await trips.updateStatus(
          tripId: action.tripId!,
          step: TripStepType.values.byName(p['step'] as String),
          photoPath: p['photoPath'] as String?,
          lat: (p['lat'] as num?)?.toDouble(),
          lng: (p['lng'] as num?)?.toDouble(),
          note: p['note'] as String?,
        );
      case OfflineActionType.tripOfferResponse:
        await trips.respondToOffer(
          tripId: action.tripId!,
          accept: p['accept'] as bool,
          reason: p['reason'] as String?,
        );
      case OfflineActionType.podSubmit:
        await trips.submitPod(
          tripId: action.tripId!,
          lrPhotoPath: p['lrPhotoPath'] as String,
          method: p['method'] as String,
          consigneeName: p['consigneeName'] as String?,
          hasDamageOrShortage: p['hasDamageOrShortage'] as bool? ?? false,
          damageRemark: p['damageRemark'] as String?,
          damageQty: p['damageQty'] as int?,
          damagePhotos: List<String>.from(p['damagePhotos'] ?? const []),
        );
      case OfflineActionType.expenseAdd:
        await expenses.add(
          Expense.fromJson(Map<String, dynamic>.from(p['expense'] as Map)),
          distanceKm: (p['distanceKm'] as num).toDouble(),
        );
      case OfflineActionType.advanceRequest:
        await advances.request(
          Advance.fromJson(Map<String, dynamic>.from(p['advance'] as Map)),
        );
      case OfflineActionType.sos:
      case OfflineActionType.gpsBatch:
        // Mock upload batch; Phase 5 fans SOS out to the ops exceptions feed.
        await mockDelay();
      default:
        await mockDelay();
    }
  }
}
