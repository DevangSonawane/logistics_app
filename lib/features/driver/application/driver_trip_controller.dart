import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/network/connectivity_provider.dart';
import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/offline/sync_status_provider.dart';
import '../../../core/services/location_service.dart';
import '../../../data/models/pod.dart';
import '../../../data/models/trip.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../../data/repositories/trip_repository.dart';
import 'gps_controller.dart';

part 'driver_trip_controller.g.dart';

/// Outcome of an optimistic driver mutation.
enum MutationOutcome { done, queued, conflict, error }

typedef MutationResult = ({MutationOutcome outcome, String? message});

class DriverTripState {
  const DriverTripState({this.activeTrip, this.offer});

  final Trip? activeTrip;
  final Trip? offer;

  DriverTripState copyWith({Trip? Function()? activeTrip, Trip? Function()? offer}) {
    return DriverTripState(
      activeTrip: activeTrip != null ? activeTrip() : this.activeTrip,
      offer: offer != null ? offer() : this.offer,
    );
  }
}

/// Driver trip state machine. Every mutation applies optimistically,
/// enqueues an OfflineAction, then uploads immediately when online.
/// Server-wins conflicts roll back with a rejected action.
@Riverpod(keepAlive: true)
class DriverTrip extends _$DriverTrip {
  final Uuid _uuid = const Uuid();

  @override
  Future<DriverTripState> build(String driverId) async {
    ref.watch(syncGenerationProvider);
    final TripRepository repo = ref.read(tripRepositoryProvider);
    final Trip? active = await repo.getActiveTrip(driverId);
    final Trip? offer = active == null ? await repo.getOffer(driverId) : null;
    return DriverTripState(activeTrip: active, offer: offer);
  }

  bool _online() => ref.read(isOnlineProvider);

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }

  Future<void> _markDone(String id) {
    return ref.read(offlineQueueProvider.notifier).update(
          id,
          (a) => a.copyWith(status: OfflineActionStatus.done),
        );
  }

  Future<void> _markRejected(String id, String reason) {
    return ref.read(offlineQueueProvider.notifier).update(
          id,
          (a) => a.copyWith(
            status: OfflineActionStatus.rejected,
            failureReason: reason,
          ),
        );
  }

  Future<MutationResult> respondToOffer({
    required bool accept,
    String? reason,
  }) async {
    final DriverTripState? cur = state.valueOrNull;
    final Trip? offer = cur?.offer;
    if (cur == null || offer == null) {
      return (outcome: MutationOutcome.error, message: null);
    }
    state = AsyncData(
      cur.copyWith(
        offer: () => null,
        activeTrip: accept
            ? () => offer.copyWith(status: TripStatus.assigned)
            : () => null,
      ),
    );
    final OfflineAction action = OfflineAction(
      id: _uuid.v4(),
      type: OfflineActionType.tripOfferResponse,
      tripId: offer.id,
      payload: {'accept': accept, 'reason': reason},
      createdAt: DateTime.now(),
    );
    await ref.read(offlineQueueProvider.notifier).enqueue(action);
    if (!_online()) return (outcome: MutationOutcome.queued, message: null);
    try {
      final Trip updated =
          await ref.read(tripRepositoryProvider).respondToOffer(
                tripId: offer.id,
                accept: accept,
                reason: reason,
              );
      await _markDone(action.id);
      state = AsyncData(
        cur.copyWith(
          offer: () => null,
          activeTrip: accept ? () => updated : () => null,
        ),
      );
      return (outcome: MutationOutcome.done, message: null);
    } on TripConflictException catch (e) {
      await _markRejected(action.id, e.message);
      await refresh();
      return (outcome: MutationOutcome.conflict, message: e.message);
    } catch (_) {
      return (outcome: MutationOutcome.queued, message: null);
    }
  }

  Future<MutationResult> completeStep({
    required TripStepType step,
    String? photoPath,
    String? note,
  }) async {
    final DriverTripState? cur = state.valueOrNull;
    final Trip? trip = cur?.activeTrip;
    if (cur == null || trip == null) {
      return (outcome: MutationOutcome.error, message: null);
    }
    final ({double lat, double lng})? fix =
        await ref.read(locationServiceProvider).currentPosition();
    final double lat = fix?.lat ?? trip.pickupLat;
    final double lng = fix?.lng ?? trip.pickupLng;
    final Trip optimistic = trip.copyWith(
      status: statusAfterStep(step),
      steps: [
        ...trip.steps,
        TripStep(
          type: step,
          at: DateTime.now(),
          lat: lat,
          lng: lng,
          photoPath: photoPath,
          note: note,
        ),
      ],
    );
    state = AsyncData(cur.copyWith(activeTrip: () => optimistic));
    final OfflineAction action = OfflineAction(
      id: _uuid.v4(),
      type: OfflineActionType.tripStatus,
      tripId: trip.id,
      payload: {
        'step': step.name,
        'photoPath': photoPath,
        'lat': lat,
        'lng': lng,
        'note': note,
      },
      createdAt: DateTime.now(),
      attachments: [if (photoPath != null) photoPath],
    );
    await ref.read(offlineQueueProvider.notifier).enqueue(action);
    if (!_online()) return (outcome: MutationOutcome.queued, message: null);
    try {
      final Trip updated =
          await ref.read(tripRepositoryProvider).updateStatus(
                tripId: trip.id,
                step: step,
                photoPath: photoPath,
                lat: lat,
                lng: lng,
                note: note,
              );
      await _markDone(action.id);
      state = AsyncData(cur.copyWith(activeTrip: () => updated));
      if (step == TripStepType.startTrip) {
        unawaited(ref.read(gpsTrackerProvider.notifier).start(updated));
      }
      if (step == TripStepType.unloaded) {
        unawaited(ref.read(gpsTrackerProvider.notifier).stop());
      }
      return (outcome: MutationOutcome.done, message: null);
    } on TripConflictException catch (e) {
      await _markRejected(action.id, e.message);
      await refresh();
      return (outcome: MutationOutcome.conflict, message: e.message);
    } catch (_) {
      return (outcome: MutationOutcome.queued, message: null);
    }
  }

  Future<MutationResult> submitPod(PodSubmission pod) async {
    final DriverTripState? cur = state.valueOrNull;
    final Trip? trip = cur?.activeTrip;
    if (cur == null || trip == null) {
      return (outcome: MutationOutcome.error, message: null);
    }
    final Trip optimistic = trip.copyWith(
      status: TripStatus.delivered,
      podStatus: PodStatus.submitted,
    );
    state = AsyncData(cur.copyWith(activeTrip: () => optimistic));
    final OfflineAction action = OfflineAction(
      id: _uuid.v4(),
      type: OfflineActionType.podSubmit,
      tripId: trip.id,
      payload: pod.toJson(),
      createdAt: DateTime.now(),
      attachments: [
        pod.lrPhotoPath,
        ...pod.damagePhotos,
      ],
    );
    await ref.read(offlineQueueProvider.notifier).enqueue(action);
    if (!_online()) return (outcome: MutationOutcome.queued, message: null);
    try {
      final Trip updated = await ref.read(tripRepositoryProvider).submitPod(
            tripId: trip.id,
            lrPhotoPath: pod.lrPhotoPath,
            method: pod.method.name,
            consigneeName: pod.consigneeName,
            hasDamageOrShortage: pod.hasDamageOrShortage,
            damageRemark: pod.damageRemark,
            damageQty: pod.damageQty,
            damagePhotos: pod.damagePhotos,
          );
      await _markDone(action.id);
      state = AsyncData(cur.copyWith(activeTrip: () => updated));
      return (outcome: MutationOutcome.done, message: null);
    } on TripConflictException catch (e) {
      await _markRejected(action.id, e.message);
      await refresh();
      return (outcome: MutationOutcome.conflict, message: e.message);
    } catch (_) {
      return (outcome: MutationOutcome.queued, message: null);
    }
  }
}
