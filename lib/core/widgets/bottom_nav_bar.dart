import 'package:flutter/material.dart';

/// Bottom navigation item (icon + label).
class AppNavItem {
  const AppNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Shared bottom navigation. Role shells pass their tab lists
/// (Driver: My Trip, Earnings, Documents, Profile ...).
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        for (final AppNavItem item in items)
          NavigationDestination(icon: Icon(item.icon), label: item.label),
      ],
    );
  }
}
