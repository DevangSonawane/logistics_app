import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/lead.dart';
import '../application/sales_providers.dart';

/// S3. Visit plan: day route list with check-in state.
class VisitPlanPage extends ConsumerWidget {
  const VisitPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Visit>> visits =
        ref.watch(plannedVisitsProvider);
    return AppScaffold(
      title: l10n.visitsTitle,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'checkin',
        onPressed: () => context.push('/sales/visits/checkin'),
        icon: const Icon(Icons.location_on_outlined),
        label: Text(l10n.checkInAction),
      ),
      body: visits.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(plannedVisitsProvider),
        ),
        data: (List<Visit> items) {
          if (items.isEmpty) {
            return EmptyState(
              title: l10n.commonEmpty,
              message: '',
              icon: Icons.calendar_today_outlined,
            );
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final Visit visit = items[index];
              final bool done = visit.checkedOutAt != null;
              final bool active = visit.checkedInAt != null && !done;
              return Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: context.tokens.surface,
                  borderRadius: AppSpacing.cardRadius,
                  border: Border.all(color: context.tokens.border),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visit.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                          Text(
                            visit.plannedAt == null
                                ? ''
                                : Formatters.dateTime(visit.plannedAt!),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                          if (visit.outcome != null)
                            Text(
                              visit.outcome!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                        ],
                      ),
                    ),
                    StatusChip(
                      label: done
                          ? l10n.visitDone
                          : active
                              ? l10n.visitActive
                              : l10n.visitPlanned,
                      color: done
                          ? Colors.green
                          : active
                              ? Colors.blue
                              : Colors.orange,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
