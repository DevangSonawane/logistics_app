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
import '../../../data/models/lead.dart';
import '../application/sales_providers.dart';

/// S3. Visit plan: day route list with check-in state.
class VisitPlanPage extends ConsumerWidget {
  const VisitPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final AsyncValue<List<Visit>> visits =
        ref.watch(plannedVisitsProvider);
    final int count = visits.value?.length ?? 0;
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
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.primaryDark,
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.md),
                    ),
                    child: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.visitsTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontSize: 22),
                        ),
                        Text(
                          '$count ${l10n.visitsTitle.toLowerCase()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: tokens.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
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
                0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: visits.when(
                      loading: () => const SkeletonList(),
                      error: (e, _) => ErrorState(
                        message: l10n.commonError,
                        onRetry: () =>
                            ref.invalidate(plannedVisitsProvider),
                      ),
                      data: (List<Visit> items) {
                        if (items.isEmpty) {
                          return EmptyState(
                            title: l10n.commonEmpty,
                            message: '',
                            icon:
                                Icons.calendar_today_outlined,
                          );
                        }
                        return ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(
                            height: AppSpacing.sm,
                          ),
                          itemBuilder: (context, index) =>
                              _VisitCard(
                            visit: items[index],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SafeArea(
                    top: false,
                    child: _CheckInCta(
                      label: l10n.checkInAction,
                      onTap: () =>
                          context.push('/sales/visits/checkin'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Visit row: state bubble, semibold title, muted date, status chip.
class _VisitCard extends StatelessWidget {
  const _VisitCard({required this.visit});

  final Visit visit;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final bool done = visit.checkedOutAt != null;
    final bool active = visit.checkedInAt != null && !done;
    final Color tint = done
        ? AppColors.success
        : active
            ? AppColors.primary
            : AppColors.warning;
    final IconData icon = done
        ? Icons.check_circle_outline
        : active
            ? Icons.location_on_outlined
            : Icons.schedule_outlined;
    return Container(
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
              color: tint.withValues(alpha: 0.12),
            ),
            child: Icon(icon, size: 20, color: tint),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visit.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (visit.plannedAt != null)
                  Text(
                    Formatters.dateTime(visit.plannedAt!),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: tokens.inkMuted),
                  ),
                if (visit.outcome != null)
                  Text(
                    visit.outcome!,
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
            label: done
                ? l10n.visitDone
                : active
                    ? l10n.visitActive
                    : l10n.visitPlanned,
            color: tint,
          ),
        ],
      ),
    );
  }
}

/// Sticky gradient CTA pinned above the nav dock.
class _CheckInCta extends StatelessWidget {
  const _CheckInCta({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: AppSpacing.buttonHeightMd,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          borderRadius:
              BorderRadius.circular(AppSpacing.radiusButton),
          boxShadow: [
            BoxShadow(
              color: tokens.primary.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
