import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Single-select filter pill used app-wide (approvals, orders, P&L,
/// invoices, leads, dashboard ranges...).
///
/// Selected: solid primary fill with white 13px semibold label.
/// Unselected: white surface, 1px border, muted-ink label.
/// Replaces raw ChoiceChip/FilterChip so contrast is identical everywhere.
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    // No outer margin: rows/wraps own the gaps so spacing stays even.
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppSpacing.motionFast,
        curve: AppSpacing.motionCurve,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: selected ? tokens.primary : tokens.surface,
          borderRadius: AppSpacing.chipRadius,
          border: Border.all(
            color: selected ? tokens.primary : tokens.border,
          ),
          boxShadow: selected ? tokens.cardShadow : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13,
                height: 1.25,
                fontWeight: FontWeight.w600,
                color: selected ? tokens.onPrimary : tokens.inkMuted,
              ),
        ),
      ),
    );
  }
}

/// Horizontal scroll row wrapper for filter pills: even 8dp gaps,
/// vertically centered in a fixed 44dp strip.
class AppFilterRow extends StatelessWidget {
  const AppFilterRow({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, i) => Center(child: children[i]),
      ),
    );
  }
}
