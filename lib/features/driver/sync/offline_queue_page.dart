import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/offline/sync_engine.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/status_chip.dart';

/// D8. Offline queue: pending actions with type, time, retry count and
/// status. Sync now drains; failed items show the reason with Retry.
class OfflineQueuePage extends ConsumerStatefulWidget {
  const OfflineQueuePage({super.key});

  @override
  ConsumerState<OfflineQueuePage> createState() => _OfflineQueuePageState();
}

class _OfflineQueuePageState extends ConsumerState<OfflineQueuePage> {
  bool _working = false;

  Future<void> _syncNow() async {
    setState(() => _working = true);
    final SyncReport report =
        await ref.read(syncControllerProvider.notifier).syncNow();
    if (!mounted) return;
    setState(() => _working = false);
    final AppLocalizations l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${report.uploaded} ${l10n.statusDone} · '
          '${report.failed} ${l10n.statusFailed} · '
          '${report.rejected} ${l10n.statusRejected}',
        ),
      ),
    );
  }

  Future<void> _retry(OfflineAction action) async {
    await ref.read(offlineQueueProvider.notifier).update(
          action.id,
          (a) => a.copyWith(
            status: OfflineActionStatus.pending,
            retryCount: 0,
            failureReason: null,
            payload: Map<String, dynamic>.from(a.payload)
              ..remove('nextTryAt'),
          ),
        );
    await _syncNow();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<OfflineAction> actions = ref.watch(offlineQueueProvider);
    final List<OfflineAction> visible = actions
        .where((a) => a.status != OfflineActionStatus.done)
        .toList();
    return AppScaffold(
      title: l10n.queueTitle,
      body: visible.isEmpty
          ? EmptyState(
              title: l10n.queueEmpty,
              message: '',
              icon: Icons.cloud_done_outlined,
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: visible.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      final OfflineAction action = visible[index];
                      return _QueueTile(
                        action: action,
                        onRetry: action.status == OfflineActionStatus.failed
                            ? () => _retry(action)
                            : null,
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: l10n.syncNow,
                  loading: _working,
                  onPressed: _working ? null : _syncNow,
                ),
              ],
            ),
    );
  }
}

class _QueueTile extends StatelessWidget {
  const _QueueTile({required this.action, this.onRetry});

  final OfflineAction action;
  final VoidCallback? onRetry;

  IconData get _icon {
    return switch (action.type) {
      OfflineActionType.tripStatus => Icons.flag_outlined,
      OfflineActionType.tripOfferResponse => Icons.local_shipping_outlined,
      OfflineActionType.podSubmit => Icons.receipt_long_outlined,
      OfflineActionType.expenseAdd => Icons.payments_outlined,
      OfflineActionType.advanceRequest => Icons.account_balance_wallet_outlined,
      OfflineActionType.sos => Icons.sos_outlined,
      OfflineActionType.gpsBatch => Icons.location_on_outlined,
      _ => Icons.cloud_upload_outlined,
    };
  }

  String _typeLabel(AppLocalizations l10n) {
    return switch (action.type) {
      OfflineActionType.tripStatus => l10n.actionTripStatus,
      OfflineActionType.tripOfferResponse => l10n.actionOffer,
      OfflineActionType.podSubmit => l10n.actionPod,
      OfflineActionType.expenseAdd => l10n.actionExpense,
      OfflineActionType.advanceRequest => l10n.actionAdvance,
      OfflineActionType.sos => l10n.actionSos,
      OfflineActionType.gpsBatch => l10n.actionGps,
      _ => l10n.actionOther,
    };
  }

  (String, Color) _status(AppLocalizations l10n) {
    return switch (action.status) {
      OfflineActionStatus.pending => (l10n.statusPending, AppColors.warning),
      OfflineActionStatus.uploading =>
        (l10n.statusUploading, AppColors.info),
      OfflineActionStatus.failed => (l10n.statusFailed, AppColors.danger),
      OfflineActionStatus.done => (l10n.statusDone, AppColors.success),
      OfflineActionStatus.rejected =>
        (l10n.statusRejected, AppColors.danger),
    };
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final (String label, Color color) = _status(l10n);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: context.tokens.border),
      ),
      child: Row(
        children: [
          Icon(_icon, color: context.tokens.inkMuted),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _typeLabel(l10n),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${Formatters.dateTime(action.createdAt)} · '
                  'retry ${action.retryCount}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.tokens.inkMuted,
                      ),
                ),
                if (action.failureReason != null)
                  Text(
                    action.failureReason!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.danger),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatusChip(label: label, color: color),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.xs),
                TextButton(
                  onPressed: onRetry,
                  child: Text(l10n.retryAction),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
