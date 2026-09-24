import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../application/owner_providers.dart';

/// Owner shell: Dashboard, Approvals (badge), Accounts, Live Map, More.
class OwnerShell extends ConsumerWidget {
  const OwnerShell({super.key, required this.navigationShell});

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
        ref.watch(pendingApprovalsCountProvider).valueOrNull ?? 0;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: [
          AppNavItem(
            icon: Icons.dashboard_outlined,
            label: l10n.ownerTabDashboard,
          ),
          AppNavItem(
            icon: pending > 0
                ? Icons.mark_as_unread_outlined
                : Icons.check_circle_outline,
            label: pending > 0
                ? '${l10n.ownerTabApprovals} ($pending)'
                : l10n.ownerTabApprovals,
          ),
          AppNavItem(
            icon: Icons.account_balance_outlined,
            label: l10n.ownerTabAccounts,
          ),
          AppNavItem(
            icon: Icons.map_outlined,
            label: l10n.ownerTabMap,
          ),
          AppNavItem(
            icon: Icons.more_horiz_outlined,
            label: l10n.tabProfile,
          ),
        ],
      ),
    );
  }
}
