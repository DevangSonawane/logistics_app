import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Vertical stepper row for trip timelines: dot + connector line,
/// title, optional detail/time, colored by step status.
class TimelineTile extends StatelessWidget {
  const TimelineTile({
    super.key,
    required this.title,
    this.detail,
    this.time,
    required this.color,
    this.icon,
    this.isFirst = false,
    this.isLast = false,
  });

  final String title;
  final String? detail;
  final String? time;
  final Color color;
  final IconData? icon;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: AppSpacing.xxl,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: isFirst ? Colors.transparent : tokens.border,
                  ),
                ),
                Container(
                  width: AppSpacing.xxxl,
                  height: AppSpacing.xxxl,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withValues(alpha: 0.12),
                    border: Border.all(color: color, width: 2),
                  ),
                  child: icon == null
                      ? null
                      : Icon(icon, size: AppSpacing.lg, color: color),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? Colors.transparent : tokens.border,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      if (time != null)
                        Text(
                          time!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: tokens.inkMuted),
                        ),
                    ],
                  ),
                  if (detail != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      detail!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: tokens.inkMuted),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
