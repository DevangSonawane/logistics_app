import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import 'ops_providers.dart';

/// Ops shell: Orders, Plan, Live Trips, Exceptions (badge), More.
class OpsShell extends ConsumerWidget {
  const OpsShell({super.key, required this.navigationShell});

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
    final int open =
        ref.watch(openExceptionsCountProvider).valueOrNull ?? 0;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: [
          AppNavItem(
            icon: Icons.list_alt_outlined,
            label: l10n.opsTabOrders,
          ),
          AppNavItem(
            icon: Icons.route_outlined,
            label: l10n.opsTabPlan,
          ),
          AppNavItem(
            icon: Icons.local_shipping_outlined,
            label: l10n.opsTabTrips,
          ),
          AppNavItem(
            icon: open > 0
                ? Icons.warning_amber_outlined
                : Icons.check_circle_outline,
            label: open > 0
                ? '${l10n.opsTabExceptions} ($open)'
                : l10n.opsTabExceptions,
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
