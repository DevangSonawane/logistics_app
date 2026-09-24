import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/finance.dart';
import '../application/owner_providers.dart';

/// O3. Accounts home (view-only): ledgers, ageing, P&L, day book, banks,
/// GST and trip P&L with Share PDF on each.
class AccountsHomePage extends ConsumerWidget {
  const AccountsHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.accountsTitle,
      body: ListView(
        children: [
          _NavCard(
            title: l10n.customerLedgerTitle,
            subtitle: l10n.viewDetails,
            onTap: () => context.push(
              '/owner/accounts/ledger',
              extra: 'customer',
            ),
          ),
          _NavCard(
            title: l10n.vendorLedgerTitle,
            subtitle: l10n.viewDetails,
            onTap: () => context.push(
              '/owner/accounts/ledger',
              extra: 'vendor',
            ),
          ),
          _NavCard(
            title: l10n.ageingTitle,
            subtitle: l10n.viewDetails,
            onTap: () => context.push('/owner/accounts/ageing'),
          ),
          _NavCard(
            title: l10n.pnlTitle,
            subtitle: l10n.viewDetails,
            onTap: () => context.push('/owner/accounts/pnl'),
          ),
          _NavCard(
            title: l10n.daybookTitle,
            subtitle: l10n.viewDetails,
            onTap: () => context.push('/owner/accounts/daybook'),
          ),
          const SizedBox(height: AppSpacing.md),
          _BanksCard(),
          const SizedBox(height: AppSpacing.md),
          _GstCard(),
          const SizedBox(height: AppSpacing.md),
          _TripPnlCard(),
        ],
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  const _NavCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        onTap: onTap,
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}

class _BanksCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<BankAccount>> banks =
        ref.watch(bankBalancesProvider);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.bankBalancesTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () => ShareService().sharePdf(
                  l10n.bankBalancesTitle,
                  [
                    for (final b
                        in banks.valueOrNull ?? const <BankAccount>[])
                      (b.name, Formatters.inr(b.balance)),
                  ],
                ),
              ),
            ],
          ),
          banks.when(
            loading: () => const SkeletonList(itemCount: 2),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (List<BankAccount> list) => Column(
              children: [
                for (final BankAccount b in list)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                    child: Row(
                      children: [
                        Expanded(child: Text(b.name)),
                        Text(Formatters.inr(b.balance)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GstCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<GstSummary> gst = ref.watch(gstSummaryProvider);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.gstSummaryTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () async {
                  final GstSummary? g = gst.valueOrNull;
                  await ShareService().sharePdf(
                    l10n.gstSummaryTitle,
                    g == null
                        ? const []
                        : [
                            ('CGST', Formatters.inr(g.cgst)),
                            ('SGST', Formatters.inr(g.sgst)),
                            ('IGST', Formatters.inr(g.igst)),
                          ],
                  );
                },
              ),
            ],
          ),
          gst.when(
            loading: () => const SkeletonList(itemCount: 2),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (GstSummary g) => Column(
              children: [
                Text(
                  g.month,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _GstTile(
                        label: 'CGST',
                        amount: g.cgst,
                      ),
                    ),
                    Expanded(
                      child: _GstTile(
                        label: 'SGST',
                        amount: g.sgst,
                      ),
                    ),
                    Expanded(
                      child: _GstTile(
                        label: 'IGST',
                        amount: g.igst,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GstTile extends StatelessWidget {
  const _GstTile({required this.label, required this.amount});

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          Text(
            Formatters.inrShort(amount),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _TripPnlCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<TripPnl>> pnl = ref.watch(tripPnlProvider);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.tripPnlTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () => ShareService().sharePdf(
                  l10n.tripPnlTitle,
                  [
                    for (final t
                        in pnl.valueOrNull ?? const <TripPnl>[])
                      (
                        '${t.tripNo} ${t.lane}',
                        '${Formatters.inr(t.revenue)} / ${Formatters.inr(t.margin)}'
                      ),
                  ],
                ),
              ),
            ],
          ),
          pnl.when(
            loading: () => const SkeletonList(itemCount: 3),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (List<TripPnl> list) => Column(
              children: [
                for (final TripPnl t in list)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t.tripNo),
                              Text(
                                t.lane,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          Formatters.inr(t.margin),
                          style: TextStyle(
                            color: t.margin < 0
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
