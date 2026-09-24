import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/advance.dart';
import '../../auth/application/session_provider.dart';
import '../application/driver_providers.dart';
import '../application/driver_trip_controller.dart';

/// D4 (ledger). Advance history with status + request entry point.
class AdvanceLedgerPage extends ConsumerWidget {
  const AdvanceLedgerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String? driverId = ref.watch(
      sessionProvider.select((s) => s.user?.id),
    );
    if (driverId == null) {
      return AppScaffold(body: ErrorState(message: l10n.commonError));
    }
    final AsyncValue<DriverTripState> tripState =
        ref.watch(driverTripProvider(driverId));
    return tripState.when(
      loading: () => AppScaffold(
        title: l10n.advancesTitle,
        body: const SkeletonList(),
      ),
      error: (e, _) => AppScaffold(
        title: l10n.advancesTitle,
        body: ErrorState(message: l10n.commonError),
      ),
      data: (DriverTripState data) {
        final trip = data.activeTrip;
        if (trip == null) {
          return AppScaffold(
            title: l10n.advancesTitle,
            body: EmptyState(
              title: l10n.noTripTitle,
              message: '',
              icon: Icons.account_balance_wallet_outlined,
            ),
          );
        }
        final AsyncValue<List<Advance>> advances =
            ref.watch(tripAdvancesProvider(trip.id));
        return AppScaffold(
          title: l10n.advancesTitle,
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'request-advance',
            onPressed: () => context.push(
              RouteNames.driverRequestAdvance,
              extra: trip,
            ),
            icon: const Icon(Icons.add),
            label: Text(l10n.requestAdvanceAction),
          ),
          body: advances.when(
            loading: () => const SkeletonList(),
            error: (e, _) => ErrorState(
              message: l10n.commonError,
              onRetry: () => ref.invalidate(tripAdvancesProvider(trip.id)),
            ),
            data: (List<Advance> items) => items.isEmpty
                ? EmptyState(
                    title: l10n.commonEmpty,
                    message: '',
                    icon: Icons.account_balance_wallet_outlined,
                  )
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: AppSpacing.sm,
                    ),
                    itemBuilder: (context, index) {
                      final Advance advance = items[index];
                      final (String label, Color color) =
                          _status(l10n, advance.status);
                      return Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: context.tokens.surface,
                          borderRadius: AppSpacing.cardRadius,
                          border:
                              Border.all(color: context.tokens.border),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _purpose(l10n, advance.purpose),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  Text(
                                    Formatters.dateTime(
                                      advance.requestedAt,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color:
                                              context.tokens.inkMuted,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Formatters.inr(advance.amount),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                StatusChip(label: label, color: color),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  String _purpose(AppLocalizations l10n, AdvancePurpose purpose) {
    return switch (purpose) {
      AdvancePurpose.fuel => l10n.purposeFuel,
      AdvancePurpose.toll => l10n.purposeToll,
      AdvancePurpose.repair => l10n.purposeRepair,
      AdvancePurpose.food => l10n.purposeFood,
      AdvancePurpose.other => l10n.purposeOther,
    };
  }

  (String, Color) _status(AppLocalizations l10n, AdvanceStatus status) {
    return switch (status) {
      AdvanceStatus.requested => (l10n.statusRequested, AppColors.warning),
      AdvanceStatus.approved => (l10n.statusApproved, AppColors.info),
      AdvanceStatus.paid => (l10n.statusPaid, AppColors.success),
      AdvanceStatus.rejected => (l10n.statusRejected, AppColors.danger),
    };
  }
}
