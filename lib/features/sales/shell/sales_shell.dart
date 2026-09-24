import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/bottom_nav_bar.dart';

/// Sales shell: Leads, Visits, Quote, Customers, More.
class SalesShell extends ConsumerWidget {
  const SalesShell({super.key, required this.navigationShell});

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
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: [
          AppNavItem(
            icon: Icons.person_add_outlined,
            label: l10n.salesTabLeads,
          ),
          AppNavItem(
            icon: Icons.calendar_today_outlined,
            label: l10n.salesTabVisits,
          ),
          AppNavItem(
            icon: Icons.request_quote_outlined,
            label: l10n.salesTabQuote,
          ),
          AppNavItem(
            icon: Icons.business_outlined,
            label: l10n.salesTabCustomers,
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
