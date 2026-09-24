import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/finance.dart';
import '../application/owner_providers.dart';

/// Ageing buckets (0-30 / 31-60 / 61-90 / 90+) with a stacked bar.
class AgeingPage extends ConsumerWidget {
  const AgeingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<AgeingBucket>> buckets =
        ref.watch(ageingBucketsProvider);
    return AppScaffold(
      title: l10n.ageingTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () => ShareService().sharePdf(
            l10n.ageingTitle,
            [
              for (final b in buckets.value ?? const <AgeingBucket>[])
                (b.label, Formatters.inr(b.amount)),
            ],
          ),
        ),
      ],
      body: buckets.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(ageingBucketsProvider),
        ),
        data: (List<AgeingBucket> list) {
          final int total =
              list.fold(0, (sum, b) => sum + b.amount);
          final List<Color> colors = [
            AppColors.success,
            AppColors.warning,
            AppColors.podPending,
            AppColors.danger,
          ];
          return Column(
            children: [
              AppCard(
                child: SizedBox(
                  height: 120,
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: total.toDouble(),
                              width: 48,
                              borderRadius: AppSpacing.cardRadius,
                              rodStackItems: [
                                for (int i = 0; i < list.length; i++)
                                  BarChartRodStackItem(
                                    _prefix(list, i).toDouble(),
                                    _prefix(list, i + 1).toDouble(),
                                    colors[i % colors.length],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (int i = 0; i < list.length; i++)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: AppCard(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: AppSpacing.lg,
                          height: AppSpacing.lg,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors[i % colors.length],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(child: Text(list[i].label)),
                        Text(Formatters.inr(list[i].amount)),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  int _prefix(List<AgeingBucket> list, int upTo) {
    int sum = 0;
    for (int i = 0; i < upTo && i < list.length; i++) {
      sum += list[i].amount;
    }
    return sum;
  }
}
