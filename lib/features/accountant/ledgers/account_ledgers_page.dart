import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';

/// Ledgers home: links into the shared ledger/ageing/P&L/day-book views.
class AccountLedgersPage extends ConsumerWidget {
  const AccountLedgersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<(String, String)> links = [
      (l10n.customerLedgerTitle, '/accountant/ledger/customer'),
      (l10n.vendorLedgerTitle, '/accountant/ledger/vendor'),
      (l10n.ageingTitle, '/accountant/ageing'),
      (l10n.pnlTitle, '/accountant/pnl'),
      (l10n.daybookTitle, '/accountant/daybook'),
      (l10n.gstSummaryTitle, '/accountant/gst'),
      (l10n.remindersTitle, '/accountant/reminders'),
      (l10n.recordReceiptTitle, '/accountant/receipts'),
    ];
    return AppScaffold(
      title: l10n.acctTabLedgers,
      body: ListView.separated(
        itemCount: links.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) => AppCard(
          onTap: () => context.push(links[index].$2),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(child: Text(links[index].$1)),
              const Icon(Icons.chevron_right_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
