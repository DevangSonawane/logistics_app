import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/lead.dart';
import '../application/sales_providers.dart';

/// S6. Targets: revenue / customers / trips rings + leaderboard.
class TargetsPage extends ConsumerWidget {
  const TargetsPage({super.key});

  static const List<(String, int)> _board = [
    ('Karan Shah', 4200000),
    ('Priya Nair', 3800000),
    ('Amit Verma', 3100000),
    ('Sneha Rao', 2700000),
    ('Rahul Jain', 2200000),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<SalesTarget>> targets =
        ref.watch(salesTargetsProvider);

    String label(String key) {
      return switch (key) {
        'revenue' => l10n.targetRevenue,
        'customers' => l10n.targetCustomers,
        'trips' => l10n.targetTrips,
        _ => key,
      };
    }

    return AppScaffold(
      title: l10n.targetsTitle,
      body: targets.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(salesTargetsProvider),
        ),
        data: (List<SalesTarget> items) => ListView(
          padding: EdgeInsets.zero,
          children: [
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.82,
              children: [
                for (final SalesTarget t in items)
                  _TargetRing(
                    label: label(t.label),
                    achieved: t.achieved,
                    target: t.target,
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            SectionHeader(title: l10n.leaderboardTitle),
            const SizedBox(height: AppSpacing.sm),
            AppCard(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                children: [
                  for (int i = 0; i < _board.length; i++) ...[
                    if (i > 0)
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: context.tokens.border,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i == 0
                                  ? AppColors.warning
                                      .withValues(alpha: 0.15)
                                  : context.tokens.primary
                                      .withValues(alpha: 0.1),
                            ),
                            child: Text(
                              '${i + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: i == 0
                                        ? AppColors.warning
                                        : context.tokens.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              _board[i].$1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            Formatters.inrShort(_board[i].$2),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact target ring card: pct in the ring, label + target below.
class _TargetRing extends StatelessWidget {
  const _TargetRing({
    required this.label,
    required this.achieved,
    required this.target,
  });

  final String label;
  final int achieved;
  final int target;

  @override
  Widget build(BuildContext context) {
    final double fraction =
        target == 0 ? 0 : (achieved / target).clamp(0.0, 1.0);
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: CircularProgressIndicator(
                  value: fraction,
                  strokeWidth: 7,
                  backgroundColor: context.tokens.surfaceAlt,
                  color: context.tokens.primary,
                ),
              ),
              Text(
                '${(fraction * 100).round()}%',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.tokens.inkMuted,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '$achieved / $target',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.tokens.inkFaint,
                  fontSize: 11,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
