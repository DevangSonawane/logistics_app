import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/trip_labels.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/map_placeholder.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/trip.dart';
import '../application/ops_providers.dart';

/// P4. Live trips: list + map toggle with ETA vs planned.
class LiveTripsPage extends ConsumerStatefulWidget {
  const LiveTripsPage({super.key});

  @override
  ConsumerState<LiveTripsPage> createState() => _LiveTripsPageState();
}

class _LiveTripsPageState extends ConsumerState<LiveTripsPage> {
  bool _mapMode = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Trip>> trips = ref.watch(opsLiveTripsProvider);
    return AppScaffold(
      title: l10n.liveTripsTitle,
      body: Column(
        children: [
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(
                value: false,
                label: Text(l10n.listTab),
                icon: const Icon(Icons.list_outlined),
              ),
              ButtonSegment(
                value: true,
                label: Text(l10n.mapTab),
                icon: const Icon(Icons.map_outlined),
              ),
            ],
            selected: {_mapMode},
            onSelectionChanged: (s) =>
                setState(() => _mapMode = s.first),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: trips.when(
              loading: () => const SkeletonList(),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () => ref.invalidate(opsLiveTripsProvider),
              ),
              data: (List<Trip> items) {
                if (items.isEmpty) {
                  return EmptyState(
                    title: l10n.commonEmpty,
                    message: '',
                    icon: Icons.local_shipping_outlined,
                  );
                }
                return Column(
                  children: [
                    if (_mapMode)
                      MapPlaceholder(
                        message: l10n.noGpsKey,
                        height: 200,
                      ),
                    if (_mapMode)
                      const SizedBox(height: AppSpacing.md),
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(
                          height: AppSpacing.sm,
                        ),
                        itemBuilder: (context, index) {
                          final Trip trip = items[index];
                          final bool late =
                              trip.liveEta != null &&
                                  trip.plannedEta != null &&
                                  trip.liveEta!.isAfter(trip.plannedEta!);
                          return Container(
                            padding:
                                const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: context.tokens.surface,
                              borderRadius: AppSpacing.cardRadius,
                              border: Border.all(
                                color: context.tokens.border,
                              ),
                            ),
                            child: InkWell(
                              onTap: () => context.push(
                                '${RouteNames.opsTrips}/${trip.id}',
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${trip.no} · ${trip.vehicleReg}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                          '${trip.customer} · ETA ${trip.liveEta != null ? Formatters.time(trip.liveEta!) : '-'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  StatusChip(
                                    label: tripStatusLabel(
                                      l10n,
                                      trip.status,
                                    ),
                                    color: late
                                        ? AppColors.danger
                                        : AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
