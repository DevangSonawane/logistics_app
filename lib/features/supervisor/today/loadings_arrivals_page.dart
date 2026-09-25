import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/hub.dart';
import '../application/supervisor_providers.dart';

/// V1. Today: Loadings and Arrivals tabs for the supervisor's hub.
class LoadingsArrivalsPage extends ConsumerStatefulWidget {
  const LoadingsArrivalsPage({super.key});

  @override
  ConsumerState<LoadingsArrivalsPage> createState() =>
      _LoadingsArrivalsPageState();
}

class _LoadingsArrivalsPageState extends ConsumerState<LoadingsArrivalsPage> {
  bool _arrivals = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<HubTask>> tasks =
        ref.watch(hubTasksProvider);
    return AppScaffold(
      title: l10n.todayTitle,
      body: Column(
        children: [
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(
                value: false,
                label: Text(l10n.loadingsTab),
                icon: const Icon(Icons.upload_outlined),
              ),
              ButtonSegment(
                value: true,
                label: Text(l10n.arrivalsTab),
                icon: const Icon(Icons.download_outlined),
              ),
            ],
            selected: {_arrivals},
            onSelectionChanged: (s) =>
                setState(() => _arrivals = s.first),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: tasks.when(
              loading: () => const SkeletonList(),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () => ref.invalidate(hubTasksProvider),
              ),
              data: (List<HubTask> items) {
                final List<HubTask> visible = items
                    .where(
                      (t) =>
                          (_arrivals
                              ? t.type == HubTaskType.arrival
                              : t.type == HubTaskType.loading),
                    )
                    .toList();
                if (visible.isEmpty) {
                  return EmptyState(
                    title: l10n.commonEmpty,
                    message: '',
                    icon: Icons.warehouse_outlined,
                  );
                }
                return ListView.separated(
                  itemCount: visible.length,
                  separatorBuilder: (_, _) => const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  itemBuilder: (context, index) {
                    final HubTask task = visible[index];
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
                          '/supervisor/loading/${task.id}',
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${task.vehicleNo} · ${task.customer}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  Text(
                                    task.eta == null
                                        ? ''
                                        : 'ETA ${Formatters.time(task.eta!)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            StatusChip(
                              label: _statusLabel(l10n, task.status),
                              color:
                                  task.status == HubTaskStatus.done
                                      ? AppColors.success
                                      : AppColors.warning,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n, HubTaskStatus status) {
    return switch (status) {
      HubTaskStatus.pending => l10n.hubPending,
      HubTaskStatus.inProgress => l10n.hubInProgress,
      HubTaskStatus.done => l10n.hubDone,
    };
  }
}
