import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/config/app_config.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/map_placeholder.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/exception.dart';
import '../../../data/models/trip.dart';
import '../application/owner_providers.dart';

/// O4. Live map: status-coloured markers, exceptions filter, bottom
/// carousel with call action. Without a Maps key the static fallback
/// renders and nothing crashes.
class LiveMapPage extends ConsumerStatefulWidget {
  const LiveMapPage({super.key});

  @override
  ConsumerState<LiveMapPage> createState() => _LiveMapPageState();
}

class _LiveMapPageState extends ConsumerState<LiveMapPage> {
  bool _exceptionsOnly = false;
  Trip? _selected;

  Color _colorFor(TripStatus status) {
    return switch (status) {
      TripStatus.started => AppColors.primary,
      TripStatus.reachedDrop ||
      TripStatus.reachedPickup ||
      TripStatus.loadingDone =>
        AppColors.warning,
      TripStatus.unloaded || TripStatus.delivered => AppColors.success,
      _ => context.tokens.inkFaint,
    };
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Trip>> trips = ref.watch(liveTripsProvider);
    final AsyncValue<List<ExceptionItem>> exceptions =
        ref.watch(openExceptionsProvider);
    final Set<String> exceptionTripIds = {
      for (final e in exceptions.value ?? const <ExceptionItem>[])
        if (!e.resolved) e.tripId,
    };
    return AppScaffold(
      title: l10n.liveMapTitle,
      padding: EdgeInsets.zero,
      body: trips.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: SkeletonList(),
        ),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(liveTripsProvider),
        ),
        data: (List<Trip> all) {
          final List<Trip> visible = _exceptionsOnly
              ? all.where((t) => exceptionTripIds.contains(t.id)).toList()
              : all;
          final Trip? selected = _selected != null &&
                  visible.any((t) => t.id == _selected!.id)
              ? visible.firstWhere((t) => t.id == _selected!.id)
              : (visible.isEmpty ? null : visible.first);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    FilterChip(
                      label: Text(l10n.exceptionsFilter),
                      selected: _exceptionsOnly,
                      onSelected: (v) =>
                          setState(() => _exceptionsOnly = v),
                    ),
                    const Spacer(),
                    Text(
                      '${visible.length} ${l10n.tripsLabel}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AppConfig.mapsEnabled
                    ? GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(18.5204, 73.8567),
                          zoom: 5,
                        ),
                        markers: {
                          for (final Trip trip in visible)
                            Marker(
                              markerId: MarkerId(trip.id),
                              position: LatLng(
                                trip.dropLat,
                                trip.dropLng,
                              ),
                              infoWindow: InfoWindow(title: trip.no),
                              onTap: () =>
                                  setState(() => _selected = trip),
                            ),
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: MapPlaceholder(
                          message: l10n.noGpsKey,
                          height: double.infinity,
                        ),
                      ),
              ),
              if (selected != null)
                SizedBox(
                  height: 132,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: AppCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Container(
                            width: AppSpacing.md,
                            decoration: BoxDecoration(
                              color: _colorFor(selected.status),
                              borderRadius: AppSpacing.chipRadius,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${selected.no} · ${selected.vehicleReg}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                                Text(
                                  '${selected.customer} · ETA ${selected.liveEta != null ? Formatters.time(selected.liveEta!) : '-'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.phone_outlined),
                            onPressed: () => LaunchHelpers.call(
                              selected.dropPhone,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
