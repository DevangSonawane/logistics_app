import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/kpi_card.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/dashboard.dart';
import '../../../data/models/finance.dart';
import '../application/accountant_providers.dart';

/// A1. Summary: receivables, payables, cash/bank, GST tiles,
/// "ready to bill" count (delivered POD-submitted trips).
class AccountsSummaryPage extends ConsumerWidget {
  const AccountsSummaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<DashboardKpis> kpis = ref.watch(accountKpisProvider);
    final AsyncValue<GstSummary> gst = ref.watch(accountGstProvider);
    return AppScaffold(
      title: l10n.acctSummaryTitle,
      body: ListView(
        children: [
          kpis.when(
            loading: () => const SkeletonList(itemCount: 4),
            error: (e, _) => ErrorState(
              message: l10n.commonError,
              onRetry: () => ref.invalidate(accountKpisProvider),
            ),
            data: (DashboardKpis k) => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.1,
              children: [
                KpiCard(
                  label: l10n.receivablesLabel,
                  value: Formatters.inrShort(k.outstanding),
                  icon: Icons.arrow_downward_outlined,
                ),
                KpiCard(
                  label: l10n.payablesLabel,
                  value: Formatters.inrShort(112000),
                  icon: Icons.arrow_upward_outlined,
                ),
                KpiCard(
                  label: l10n.cashBankLabel,
                  value: Formatters.inrShort(k.cashBank),
                  icon: Icons.account_balance_outlined,
                ),
                AppCard(
                  onTap: () =>
                      context.push('/accountant/invoices'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.readyToBill,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: context.tokens.inkMuted,
                            ),
                      ),
                      Text(
                        '5',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          gst.when(
            loading: () => const SkeletonList(itemCount: 1),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (GstSummary g) => AppCard(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${l10n.gstSummaryTitle} · ${g.month}',
                      style:
                          Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    Formatters.inrShort(
                      g.cgst + g.sgst + g.igst,
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
