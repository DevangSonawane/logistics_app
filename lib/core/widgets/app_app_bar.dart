import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Custom app bar (Rule 1: no default AppBar in feature screens).
/// Left-aligned oversized title with an accent tab; 64dp with 48dp+ actions.
class RoadAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RoadAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions = const [],
    this.accent = AppColors.primary,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Color accent;

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return SafeArea(
      bottom: false,
      child: Container(
        height: 68,
        padding: const EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: tokens.background,
          border: Border(bottom: BorderSide(color: tokens.border)),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: AppSpacing.chipRadius,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: tokens.inkMuted),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            ...actions,
          ],
        ),
      ),
    );
  }
}
