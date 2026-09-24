import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../utils/extensions.dart';

/// Pill with the status color at 12% background.
/// Color mapping per Section 4 (Pending=warning, Running=primary,
/// Delayed=danger, Delivered/Approved=success, POD Pending=orange...).
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.pillBackground,
        borderRadius: AppSpacing.chipRadius,
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
