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
    final AppColorTokens tokens = context.tokens;
    final AsyncValue<List<HubTask>> tasks =
        ref.watch(hubTasksProvider);
    final List<HubTask> all = tasks.value ?? const [];
    final int loadings = all
        .where((t) => t.type == HubTaskType.loading)
        .length;
    final int arrivals = all
        .where((t) => t.type == HubTaskType.arrival)
        .length;
    return AppScaffold(
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          Container(
            color: tokens.surface,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.todayTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontSize: 22),
                    ),
                  ),
                  _TabToggle(
                    label: l10n.loadingsTab,
                    count: loadings,
                    selected: !_arrivals,
                    onTap: () =>
                        setState(() => _arrivals = false),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  _TabToggle(
                    label: l10n.arrivalsTab,
                    count: arrivals,
                    selected: _arrivals,
                    onTap: () =>
                        setState(() => _arrivals = true),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: tasks.when(
                loading: () => const SkeletonList(),
                error: (e, _) => ErrorState(
                  message: l10n.commonError,
                  onRetry: () =>
                      ref.invalidate(hubTasksProvider),
                ),
                data: (List<HubTask> items) {
                  final List<HubTask> visible = items
                      .where(
                        (t) => (_arrivals
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
                    padding: EdgeInsets.zero,
                    itemCount: visible.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(
                      height: AppSpacing.sm,
                    ),
                    itemBuilder: (context, index) =>
                        _TaskCard(
                      task: visible[index],
                      statusLabel: _statusLabel(
                        l10n,
                        visible[index].status,
                      ),
                      onTap: () => context.push(
                        '/supervisor/loading/${visible[index].id}',
                      ),
                    ),
                  );
                },
              ),
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

/// Compact count toggle for loadings/arrivals.
class _TabToggle extends StatelessWidget {
  const _TabToggle({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
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
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? tokens.primary : tokens.surfaceAlt,
          borderRadius: AppSpacing.chipRadius,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        selected ? tokens.onPrimary : tokens.inkMuted,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withValues(alpha: 0.25)
                    : tokens.primary.withValues(alpha: 0.12),
                borderRadius: AppSpacing.chipRadius,
              ),
              child: Text(
                '$count',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                      color: selected
                          ? tokens.onPrimary
                          : tokens.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact task row: icon bubble, vehicle semibold, customer + ETA
/// muted, status chip.
class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.statusLabel,
    required this.onTap,
  });

  final HubTask task;
  final String statusLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final bool loading = task.type == HubTaskType.loading;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tokens.surface,
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(color: tokens.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tokens.primary.withValues(alpha: 0.1),
              ),
              child: Icon(
                loading
                    ? Icons.upload_outlined
                    : Icons.download_outlined,
                size: 20,
                color: tokens.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.vehicleNo,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    task.eta == null
                        ? task.customer
                        : '${task.customer} · ETA ${Formatters.time(task.eta!)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: tokens.inkMuted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            StatusChip(
              label: statusLabel,
              color: task.status == HubTaskStatus.done
                  ? AppColors.success
                  : AppColors.warning,
            ),
          ],
        ),
      ),
    );
  }
}
