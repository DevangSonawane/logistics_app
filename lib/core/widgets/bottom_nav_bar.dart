import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Bottom navigation item (icon + label).
class AppNavItem {
  const AppNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Icons-only floating dock (Rule 1: no default NavigationBar).
/// Active destination: solid accent tile with a white icon; inactive:
/// muted icon. Labels survive as semantics for accessibility.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.accent = AppColors.primary,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final double bottomInset = MediaQuery.paddingOf(context).bottom;
    final double bottomGap =
        bottomInset + (bottomInset == 0 ? AppSpacing.xs : AppSpacing.sm);
    return SizedBox(
      height: 64 + bottomGap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.xs,
          AppSpacing.lg,
          bottomGap,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: tokens.surface,
                borderRadius: AppSpacing.chipRadius,
                border: Border.all(color: tokens.border),
                boxShadow: [
                  BoxShadow(
                    color: tokens.ink.withValues(alpha: 0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double textScale = MediaQuery.textScalerOf(
                      context,
                    ).scale(1);
                    final bool compact =
                        items.length > 5 ||
                        (items.length >= 5 && constraints.maxWidth < 380) ||
                        textScale > 1.1;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: compact
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: GNav(
                          selectedIndex: currentIndex.clamp(
                            0,
                            items.length - 1,
                          ),
                          onTabChange: onTap,
                          gap: compact ? 0 : AppSpacing.xs,
                          iconSize: 22,
                          haptic: true,
                          duration: AppSpacing.motionNormal,
                          curve: AppSpacing.motionCurve,
                          mainAxisAlignment: compact
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.spaceBetween,
                          backgroundColor: Colors.transparent,
                          color: tokens.inkMuted,
                          activeColor: Colors.white,
                          tabBackgroundColor: accent,
                          tabBorderRadius: AppSpacing.radiusChip,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.md,
                          ),
                          textStyle: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                          tabs: [
                            for (final AppNavItem item in items)
                              GButton(
                                icon: item.icon,
                                text: compact ? '' : item.label,
                                semanticLabel: item.label,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
