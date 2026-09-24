import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/bottom_nav_bar.dart';

/// Supervisor shell: Today, Gate, Scan, Manifest, More.
class SupervisorShell extends ConsumerWidget {
  const SupervisorShell({super.key, required this.navigationShell});

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
            icon: Icons.today_outlined,
            label: l10n.superTabToday,
          ),
          AppNavItem(
            icon: Icons.door_front_door_outlined,
            label: l10n.superTabGate,
          ),
          AppNavItem(
            icon: Icons.qr_code_scanner_outlined,
            label: l10n.superTabScan,
          ),
          AppNavItem(
            icon: Icons.list_alt_outlined,
            label: l10n.superTabManifest,
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
