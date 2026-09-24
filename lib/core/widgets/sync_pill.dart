import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../offline/sync_engine.dart';
import '../offline/sync_status_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Pending-sync count pill. Taps open the offline queue page (Phase 3).
/// Hidden when nothing is pending and no sync is running.
class SyncPill extends ConsumerWidget {
  const SyncPill({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SyncPillState pill = ref.watch(syncPillStateProvider);
    if (pill.pending == 0 && pill.activity != SyncActivity.syncing) {
      return const SizedBox.shrink();
    }
    final bool syncing = pill.activity == SyncActivity.syncing;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.2),
          borderRadius: AppSpacing.chipRadius,
          border: Border.all(color: AppColors.accent),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (syncing)
              const SizedBox(
                width: AppSpacing.lg,
                height: AppSpacing.lg,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              const Icon(
                Icons.cloud_upload_outlined,
                size: AppSpacing.lg,
                color: AppColors.accent,
              ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '${pill.pending}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
