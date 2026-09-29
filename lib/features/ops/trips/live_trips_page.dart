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
    final AppColorTokens tokens = context.tokens;
    final int count = trips.value?.length ?? 0;
    return AppScaffold(
      title: l10n.liveTripsTitle,
      actions: [
        Container(
          decoration: BoxDecoration(
            color: tokens.surfaceAlt,
            borderRadius: AppSpacing.chipRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ViewToggle(
                icon: Icons.list_outlined,
                label: l10n.listTab,
                selected: !_mapMode,
                onTap: () => setState(() => _mapMode = false),
              ),
              _ViewToggle(
                icon: Icons.map_outlined,
                label: l10n.mapTab,
                selected: _mapMode,
                onTap: () => setState(() => _mapMode = true),
              ),
            ],
          ),
        ),
      ],
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$count ${l10n.tripsLabel}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: tokens.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
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
                    if (_mapMode) ...[
                      MapPlaceholder(
                        message: l10n.noGpsKey,
                        height: 160,
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(
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
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${trip.customer} · ETA ${trip.liveEta != null ? Formatters.time(trip.liveEta!) : '-'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: context
                                                    .tokens.inkMuted,
                                              ),
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,
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

/// Compact list/map toggle for the app-bar actions.
class _ViewToggle extends StatelessWidget {
  const _ViewToggle({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppSpacing.motionFast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: selected ? tokens.surface : Colors.transparent,
          borderRadius: AppSpacing.chipRadius,
          boxShadow: selected ? tokens.cardShadow : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected ? tokens.primary : tokens.inkFaint,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color:
                        selected ? tokens.primary : tokens.inkFaint,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
