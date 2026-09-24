import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/approval.dart';
import '../../auth/application/session_provider.dart';
import '../application/owner_providers.dart';
import 'approval_detail_sheet.dart';

/// O2. Approvals inbox: filter chips, risk flags, swipe to decide with
/// a 5-second undo toast, bulk mode for small items.
class ApprovalsInboxPage extends ConsumerStatefulWidget {
  const ApprovalsInboxPage({super.key});

  @override
  ConsumerState<ApprovalsInboxPage> createState() =>
      _ApprovalsInboxPageState();
}

class _ApprovalsInboxPageState extends ConsumerState<ApprovalsInboxPage> {
  ApprovalType? _filter;
  bool _bulk = false;
  final Set<String> _selected = {};

  Future<void> _decide(ApprovalItem item, bool approve) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    String? comment;
    if (!approve) {
      comment = await ApprovalDetailSheet.commentDialog(context);
      if (comment == null || !mounted) return;
    }
    try {
      await ref.read(approvalRepositoryProvider).decide(
            id: item.id,
            approve: approve,
            comment: comment,
          );
    } on Exception {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
      return;
    }
    ref.invalidate(approvalInboxProvider);
    ref.invalidate(pendingApprovalsCountProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(approve ? l10n.approvedMsg : l10n.rejectedMsg),
        action: SnackBarAction(
          label: l10n.undoAction,
          onPressed: () async {
            await ref.read(approvalRepositoryProvider).reopen(item.id);
            ref.invalidate(approvalInboxProvider);
            ref.invalidate(pendingApprovalsCountProvider);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Future<void> _bulkApprove(List<ApprovalItem> items) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    for (final String id in _selected) {
      try {
        await ref.read(approvalRepositoryProvider).decide(
              id: id,
              approve: true,
            );
      } catch (_) {}
    }
    setState(() {
      _selected.clear();
      _bulk = false;
    });
    ref.invalidate(approvalInboxProvider);
    ref.invalidate(pendingApprovalsCountProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.approvedMsg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<ApprovalItem>> inbox =
        ref.watch(approvalInboxProvider);
    final bool canApprove = ref.watch(canProvider(AppPermission.approveExpense));
    return AppScaffold(
      title: l10n.approvalsTitle,
      actions: [
        IconButton(
          icon: Icon(_bulk ? Icons.close_outlined : Icons.checklist_outlined),
          onPressed: () => setState(() {
            _bulk = !_bulk;
            _selected.clear();
          }),
        ),
      ],
      floatingActionButton: _bulk && _selected.isNotEmpty
          ? FloatingActionButton.extended(
              heroTag: 'bulk-approve',
              onPressed: () => _bulkApprove(
                inbox.valueOrNull ?? const [],
              ),
              icon: const Icon(Icons.done_all_outlined),
              label: Text('${l10n.approveAction} (${_selected.length})'),
            )
          : null,
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FilterChip(
                  label: l10n.filterAll,
                  selected: _filter == null,
                  onTap: () => setState(() => _filter = null),
                ),
                for (final ApprovalType type in ApprovalType.values)
                  _FilterChip(
                    label: _typeLabel(l10n, type),
                    selected: _filter == type,
                    onTap: () => setState(() => _filter = type),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: inbox.when(
              loading: () => const SkeletonList(),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () => ref.invalidate(approvalInboxProvider),
              ),
              data: (List<ApprovalItem> items) {
                final List<ApprovalItem> visible = items
                    .where(
                      (a) =>
                          a.status == ApprovalStatus.pending &&
                          (_filter == null || a.type == _filter),
                    )
                    .toList();
                if (visible.isEmpty) {
                  return EmptyState(
                    title: l10n.emptyApprovals,
                    message: '',
                    icon: Icons.celebration_outlined,
                  );
                }
                return ListView.separated(
                  itemCount: visible.length,
                  separatorBuilder: (_, __) => const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  itemBuilder: (context, index) =>
                      _ApprovalCard(
                    item: visible[index],
                    bulk: _bulk,
                    selected: _selected.contains(visible[index].id),
                    onSelect: (v) => setState(() {
                      if (v) {
                        _selected.add(visible[index].id);
                      } else {
                        _selected.remove(visible[index].id);
                      }
                    }),
                    onTap: () => ApprovalDetailSheet.show(
                      context,
                      item: visible[index],
                    ),
                    onApprove: canApprove
                        ? () => _decide(visible[index], true)
                        : null,
                    onReject: canApprove
                        ? () => _decide(visible[index], false)
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(AppLocalizations l10n, ApprovalType type) {
    return switch (type) {
      ApprovalType.advance => l10n.approvalAdvance,
      ApprovalType.expense => l10n.approvalExpense,
      ApprovalType.rate => l10n.approvalRate,
      ApprovalType.credit => l10n.approvalCredit,
      ApprovalType.vendor => l10n.approvalVendor,
      ApprovalType.purchase => l10n.approvalPurchase,
    };
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _ApprovalCard extends StatelessWidget {
  const _ApprovalCard({
    required this.item,
    required this.bulk,
    required this.selected,
    required this.onSelect,
    required this.onTap,
    required this.onApprove,
    required this.onReject,
  });

  final ApprovalItem item;
  final bool bulk;
  final bool selected;
  final ValueChanged<bool> onSelect;
  final VoidCallback onTap;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final Widget card = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: context.tokens.border),
      ),
      child: Row(
        children: [
          if (bulk)
            Checkbox(value: selected, onChanged: (v) => onSelect(v ?? false)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.requester,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      Formatters.inr(item.amount),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Text(
                  item.reason,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.tokens.inkMuted,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    StatusChip(
                      label: _age(item.createdAt),
                      color: AppColors.warning,
                    ),
                    if (item.riskFlag != null) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          item.riskFlag!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.danger),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    if (bulk || (onApprove == null && onReject == null)) return card;
    return Slidable(
      key: ValueKey(item.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onApprove?.call(),
            backgroundColor: AppColors.success,
            foregroundColor: Colors.white,
            icon: Icons.check,
            label: l10n.approveAction,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onReject?.call(),
            backgroundColor: AppColors.danger,
            foregroundColor: Colors.white,
            icon: Icons.close,
            label: l10n.rejectAction,
          ),
        ],
      ),
      child: GestureDetector(onTap: onTap, child: card),
    );
  }

  String _age(DateTime at) {
    final Duration diff = DateTime.now().difference(at);
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}
