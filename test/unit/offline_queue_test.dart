import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/core/offline/offline_action.dart';
import 'package:roadops/core/offline/offline_queue.dart';
import 'package:roadops/core/offline/sync_engine.dart';

import '../helpers/test_hive.dart';

OfflineAction _action(String id) => OfflineAction(
      id: id,
      type: OfflineActionType.tripStatus,
      tripId: 'trip-1',
      payload: const {'step': 'reached_pickup'},
      createdAt: DateTime(2026, 9, 24, 10),
    );

void main() {
  setUpAll(ensureTestHive);
  setUp(clearTestBoxes);

  test('enqueue preserves FIFO order and persists', () async {
    final ProviderContainer container = ProviderContainer();
    addTearDown(container.dispose);

    final OfflineQueue queue = container.read(offlineQueueProvider.notifier);
    await queue.enqueue(_action('a'));
    await queue.enqueue(_action('b'));

    final List<OfflineAction> state = container.read(offlineQueueProvider);
    expect(state.map((e) => e.id), ['a', 'b']);

    // New container over the same Hive box sees the same rows.
    final ProviderContainer second = ProviderContainer();
    addTearDown(second.dispose);
    expect(
      second.read(offlineQueueProvider).map((e) => e.id),
      ['a', 'b'],
    );
  });

  test('update + pruneTerminal + pending count', () async {
    final ProviderContainer container = ProviderContainer();
    addTearDown(container.dispose);

    final OfflineQueue queue = container.read(offlineQueueProvider.notifier);
    await queue.enqueue(_action('a'));
    await queue.enqueue(_action('b'));
    await queue.update(
      'a',
      (a) => a.copyWith(status: OfflineActionStatus.done),
    );

    expect(container.read(pendingSyncCountProvider), 1);

    await queue.pruneTerminal();
    expect(
      container.read(offlineQueueProvider).map((e) => e.id),
      ['b'],
    );
  });

  test('backoff schedule with jitter bounds', () {
    final SyncEngine engine = SyncEngine(random: Random(42));
    // 5 s, 15 s, 45 s, 2 m, 5 m caps.
    expect(engine.backoffForAttempt(0).inSeconds, inInclusiveRange(5, 6));
    expect(engine.backoffForAttempt(1).inSeconds, inInclusiveRange(15, 18));
    expect(engine.backoffForAttempt(2).inSeconds, inInclusiveRange(45, 54));
    expect(engine.backoffForAttempt(3).inSeconds, inInclusiveRange(120, 144));
    expect(engine.backoffForAttempt(7).inSeconds, inInclusiveRange(300, 360));
    // Capped at the 5-minute bucket beyond the schedule.
    expect(engine.backoffForAttempt(100).inSeconds, inInclusiveRange(300, 360));
  });

  test('retry budget is 8 attempts', () {
    final SyncEngine engine = SyncEngine();
    expect(engine.canRetry(0), isTrue);
    expect(engine.canRetry(7), isTrue);
    expect(engine.canRetry(8), isFalse);
  });
}
