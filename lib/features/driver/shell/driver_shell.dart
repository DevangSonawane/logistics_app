import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/driver_theme.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../application/driver_settings.dart';

/// Driver tab shell: My Trip, Earnings, Documents, Profile.
/// Wrapped in the oversized driver theme (1.15x text, 64 dp buttons).
/// TODO(Phase 8): lazy-load staff modules so driver builds never parse
/// staff code paths.
class DriverShell extends ConsumerWidget {
  const DriverShell({super.key, required this.navigationShell});

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
    final double textScale =
        ref.watch(driverSettingsProvider.select((s) => s.textScale));
    final MediaQueryData media = MediaQuery.of(context);
    return Theme(
      data: DriverTheme.themed(context),
      child: MediaQuery(
        data: media.copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: Scaffold(
          body: navigationShell,
          bottomNavigationBar: AppBottomNavBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _goBranch,
          items: [
            AppNavItem(
              icon: Icons.local_shipping_outlined,
              label: l10n.tabMyTrip,
            ),
            AppNavItem(
              icon: Icons.account_balance_wallet_outlined,
              label: l10n.tabEarnings,
            ),
            AppNavItem(
              icon: Icons.folder_outlined,
              label: l10n.tabDocuments,
            ),
            AppNavItem(
              icon: Icons.person_outline,
              label: l10n.tabProfile,
            ),
          ],
          ),
        ),
      ),
    );
  }
}
