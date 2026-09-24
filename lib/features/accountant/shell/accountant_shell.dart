import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../owner/application/owner_providers.dart';

/// Accountant shell: Summary, Ledgers, Invoices, Approvals (badge), More.
class AccountantShell extends ConsumerWidget {
  const AccountantShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int pending =
        ref.watch(pendingApprovalsCountProvider).value ?? 0;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: [
          AppNavItem(
            icon: Icons.dashboard_outlined,
            label: l10n.acctTabSummary,
          ),
          AppNavItem(
            icon: Icons.book_outlined,
            label: l10n.acctTabLedgers,
          ),
          AppNavItem(
            icon: Icons.request_quote_outlined,
            label: l10n.acctTabInvoices,
          ),
          AppNavItem(
            icon: pending > 0
                ? Icons.mark_as_unread_outlined
                : Icons.check_circle_outline,
            label: pending > 0
                ? '${l10n.acctTabApprovals} ($pending)'
                : l10n.acctTabApprovals,
          ),
          AppNavItem(
            icon: Icons.person_outline,
            label: l10n.tabProfile,
          ),
        ],
      ),
    );
  }
}
