import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final SalesTarget t in items)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      child: AppCard(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: AppSpacing.huge,
                                  height: AppSpacing.huge,
                                  child: CircularProgressIndicator(
                                    value: t.target == 0
                                        ? 0
                                        : (t.achieved / t.target)
                                            .clamp(0.0, 1.0),
                                    strokeWidth: AppSpacing.sm,
                                    backgroundColor:
                                        context.tokens.surfaceAlt,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  '${t.achieved}',
                                  style: AppTypography.kpiNumber(
                                    context.tokens.ink,
                                  ).copyWith(fontSize: AppSpacing.xl),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              label(t.label),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '/ ${t.target}',
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
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            SectionHeader(title: l10n.leaderboardTitle),
            const SizedBox(height: AppSpacing.sm),
            for (int i = 0; i < _board.length; i++)
              Padding(
                padding:
                    const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      SizedBox(
                        width: AppSpacing.xxl,
                        child: Text(
                          '#${i + 1}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                      ),
                      Expanded(child: Text(_board[i].$1)),
                      Text(
                        Formatters.inrShort(_board[i].$2),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
