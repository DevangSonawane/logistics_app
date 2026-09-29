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
import '../../../core/widgets/error_state.dart';
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
    final AsyncValue<EarningsSummary> earnings = ref.watch(
      driverEarningsProvider(driverId),
    );
    return earnings.when(
      loading: () =>
          AppScaffold(title: l10n.earningsTitle, body: const SkeletonList()),
      error: (e, _) => AppScaffold(
        title: l10n.earningsTitle,
        body: ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(driverEarningsProvider(driverId)),
        ),
      ),
      data: (EarningsSummary summary) => Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: context.tokens.surface,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.earningsTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primaryDark,
                          ],
                        ),
                        borderRadius: AppSpacing.cardRadius,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.monthTotal,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.white.withValues(
                                    alpha: 0.85,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            Formatters.inrShort(
                              summary.monthTotal,
                            ),
                            style: AppTypography.kpiNumber(
                              Colors.white,
                            ).copyWith(fontSize: 32),
                          ),
                          const SizedBox(
                            height: AppSpacing.sm,
                          ),
                          Row(
                            children: [
                              _HeroStat(
                                value: '${summary.tripsDone}',
                                label: l10n.tripsDoneLabel,
                              ),
                              const SizedBox(
                                width: AppSpacing.xl,
                              ),
                              _HeroStat(
                                value: '${summary.onTimePct}%',
                                label: l10n.onTimeLabel,
                              ),
                              const SizedBox(
                                width: AppSpacing.xl,
                              ),
                              _HeroStat(
                                value: Formatters.inrShort(
                                  summary.incentives,
                                ),
                                label: l10n.incentivesLabel,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SettlementOverlap(summary: summary),
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    '${entry.lane} · ${Formatters.date(entry.date)}',
                                    style: Theme.of(context).textTheme.bodySmall
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
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Settlement balance card overlapping the earnings header.
class _SettlementOverlap extends StatelessWidget {
  const _SettlementOverlap({required this.summary});

  final EarningsSummary summary;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          _MoneyRow(label: l10n.incentivesLabel, amount: summary.incentives),
          _MoneyRow(label: l10n.advanceBalance, amount: -summary.advanceTaken),
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
          Text(Formatters.inr(amount), style: style?.copyWith(color: color)),
        ],
      ),
    );
  }
}

/// Small white stat inside the balance hero.
class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 11,
              ),
        ),
      ],
    );
  }
}
