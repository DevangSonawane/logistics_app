import '../../data/models/trip.dart';
import 'app_localizations.dart';

/// Localized trip status + step names shared by driver and ops.
String tripStatusLabel(AppLocalizations l10n, TripStatus status) {
  return switch (status) {
    TripStatus.offered => l10n.offerTitle,
    TripStatus.assigned => l10n.tripAssigned,
    TripStatus.reachedPickup => l10n.stepReachedPickup,
    TripStatus.loadingDone => l10n.stepLoadingDone,
    TripStatus.started => l10n.stepStartTrip,
    TripStatus.reachedDrop => l10n.stepReachedDrop,
    TripStatus.unloaded => l10n.stepUnloaded,
    TripStatus.podSubmitted || TripStatus.delivered => l10n.tripDelivered,
    TripStatus.closed => l10n.tripClosed,
    TripStatus.cancelled => l10n.tripCancelled,
  };
}

String tripStepLabel(AppLocalizations l10n, TripStepType step) {
  return switch (step) {
    TripStepType.reachedPickup => l10n.stepReachedPickup,
    TripStepType.loadingDone => l10n.stepLoadingDone,
    TripStepType.startTrip => l10n.stepStartTrip,
    TripStepType.reachedDrop => l10n.stepReachedDrop,
    TripStepType.unloaded => l10n.stepUnloaded,
  };
}
