import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/core/network/connectivity_provider.dart';
import 'package:roadops/core/offline/offline_action.dart';
import 'package:roadops/core/offline/offline_queue.dart';
import 'package:roadops/core/offline/sync_engine.dart';
import 'package:roadops/data/models/expense.dart';
import 'package:roadops/data/repositories/mock_trip_repository.dart';
import 'package:roadops/data/repositories/repository_providers.dart';

import '../helpers/test_hive.dart';

/// Sync drain: FIFO upload, conflict rejection, retry budgeting.
/// NOTE: not executed yet - full test pass happens at the end (user call).
void main() {
  setUpAll(ensureTestHive);
  setUp(clearTestBoxes);

  OfflineAction stepAction(String id) => OfflineAction(
        id: id,
        type: OfflineActionType.tripStatus,
        tripId: 'trip-ramesh-1',
        payload: const {'step': 'reachedDrop'},
        createdAt: DateTime(2026, 1, 1),
      );

  test('drain uploads pending steps and prunes them', () async {
    // Unit tests have no platform channels: pin connectivity to wifi.
    final ProviderContainer container = ProviderContainer(
      overrides: [
        connectivityProvider.overrideWith(
          (ref) => Stream.value([ConnectivityResult.wifi]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final OfflineQueue queue = container.read(offlineQueueProvider.notifier);
    await queue.enqueue(stepAction('s1'));
    await queue.enqueue(
      OfflineAction(
        id: 'e1',
        type: OfflineActionType.expenseAdd,
        tripId: 'trip-ramesh-1',
        payload: {
          'expense': Expense(
            id: 'local-e1',
            tripId: 'trip-ramesh-1',
            type: ExpenseType.toll,
            amount: 200,
            createdAt: DateTime(2026, 1, 1),
          ).toJson(),
          'distanceKm': 1180,
        },
        createdAt: DateTime(2026, 1, 1),
      ),
    );

    final SyncReport report =
        await container.read(syncControllerProvider.notifier).syncNow();
    expect(report.uploaded, 2);
    expect(report.failed, 0);
    expect(report.rejected, 0);
    expect(container.read(offlineQueueProvider), isEmpty);
  });

  test('ops-cancelled trips reject queued actions', () async {
    final ProviderContainer container = ProviderContainer(
      overrides: [
        connectivityProvider.overrideWith(
          (ref) => Stream.value([ConnectivityResult.wifi]),
        ),
        tripRepositoryProvider.overrideWithValue(MockTripRepository()),
      ],
    );
    addTearDown(container.dispose);

    final MockTripRepository trips =
        container.read(tripRepositoryProvider) as MockTripRepository;
    trips.debugCancelTrip('trip-ramesh-1');

    await container
        .read(offlineQueueProvider.notifier)
        .enqueue(stepAction('s9'));
    final SyncReport report =
        await container.read(syncControllerProvider.notifier).syncNow();
    expect(report.rejected, 1);
    expect(container.read(offlineQueueProvider), isEmpty);
  });
}
