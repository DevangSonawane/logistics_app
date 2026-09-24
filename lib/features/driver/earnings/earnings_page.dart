import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/kpi_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/driver.dart';
import '../../auth/application/session_provider.dart';
import '../application/driver_providers.dart';

/// D5. Earnings: month total, allowances, incentives, settlement balance,
/// trips/on-time stats and salary slips with PDF preview.
class EarningsPage extends ConsumerWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String? driverId = ref.watch(
      sessionProvider.select((s) => s.user?.id),
    );
    if (driverId == null) {
      return AppScaffold(body: ErrorState(message: l10n.commonError));
    }
    final AsyncValue<EarningsSummary> earnings =
        ref.watch(driverEarningsProvider(driverId));
    return AppScaffold(
      title: l10n.earningsTitle,
      body: earnings.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(driverEarningsProvider(driverId)),
        ),
        data: (EarningsSummary summary) => ListView(
          children: [
            KpiCard(
              label: l10n.monthTotal,
              value: Formatters.inrShort(summary.monthTotal),
              icon: Icons.account_balance_wallet_outlined,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _StatTile(
                    label: l10n.tripsDoneLabel,
                    value: '${summary.tripsDone}',
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _StatTile(
                    label: l10n.onTimeLabel,
                    value: '${summary.onTimePct}%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            SectionHeader(title: l10n.settlementTitle),
            const SizedBox(height: AppSpacing.sm),
            AppCard(
              child: Column(
                children: [
                  _MoneyRow(
                    label: l10n.incentivesLabel,
                    amount: summary.incentives,
                  ),
                  _MoneyRow(
                    label: l10n.advanceBalance,
                    amount: -summary.advanceTaken,
                  ),
                  const Divider(),
                  _MoneyRow(
                    label: summary.settlementBalance >= 0
                        ? l10n.payableLabel
                        : l10n.recoverableLabel,
                    amount: summary.settlementBalance,
                    bold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SectionHeader(title: l10n.allowancesTitle),
            const SizedBox(height: AppSpacing.sm),
            for (final AllowanceEntry entry in summary.allowances)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.tripNo,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '${entry.lane} · ${Formatters.date(entry.date)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: context.tokens.inkMuted,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        Formatters.inr(entry.amount),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
            SectionHeader(title: l10n.slipsTitle),
            const SizedBox(height: AppSpacing.sm),
            for (final SalarySlip slip in summary.slips)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  onTap: () => context.push(
                    RouteNames.driverPayslip,
                    extra: {'slip': slip},
                  ),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      const Icon(Icons.picture_as_pdf_outlined),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          slip.month,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(Formatters.inr(slip.amount)),
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

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Text(value, style: AppTypography.kpiNumber(context.tokens.ink)),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.tokens.inkMuted,
                ),
          ),
        ],
      ),
    );
  }
}

class _MoneyRow extends StatelessWidget {
  const _MoneyRow({
    required this.label,
    required this.amount,
    this.bold = false,
  });

  final String label;
  final int amount;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = bold
        ? Theme.of(context).textTheme.bodyMedium
        : Theme.of(context).textTheme.bodyLarge;
    final Color color = amount < 0 ? AppColors.danger : context.tokens.ink;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(
            Formatters.inr(amount),
            style: style?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
