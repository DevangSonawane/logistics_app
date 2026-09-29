import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/models/approval.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/owner_providers.dart';

/// Bottom-sheet detail for an approval: attachments, history, comment,
/// Approve / Reject (comment required) / Ask for info.
class ApprovalDetailSheet extends ConsumerStatefulWidget {
  const ApprovalDetailSheet({super.key, required this.item});

  final ApprovalItem item;

  static Future<void> show(
    BuildContext context, {
    required ApprovalItem item,
  }) {
    // Content-sized sheet (no fixed 85% height): wraps the content and
    // lifts above the keyboard when the comment field focuses.
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: ApprovalDetailSheet(item: item),
      ),
    );
  }

  /// Shared reject-comment dialog (also used by swipe-to-reject).
  static Future<String?> commentDialog(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.rejectAction),
        content: AppTextField(
          controller: controller,
          label: l10n.commentHint,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.commentRequired)),
                );
                return;
              }
              Navigator.of(context).pop(controller.text.trim());
            },
            child: Text(l10n.rejectAction),
          ),
        ],
      ),
    );
  }

  @override
  ConsumerState<ApprovalDetailSheet> createState() =>
      _ApprovalDetailSheetState();
}

class _ApprovalDetailSheetState
    extends ConsumerState<ApprovalDetailSheet> {
  final TextEditingController _comment = TextEditingController();
  bool _working = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _decide(bool approve) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (!approve && _comment.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commentRequired)),
      );
      return;
    }
    setState(() => _working = true);
    try {
      await ref.read(approvalRepositoryProvider).decide(
            id: widget.item.id,
            approve: approve,
            comment:
                _comment.text.trim().isEmpty ? null : _comment.text.trim(),
          );
    } catch (_) {
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.commonError)),
      );
      return;
    }
    ref.invalidate(approvalInboxProvider);
    ref.invalidate(pendingApprovalsCountProvider);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(approve ? l10n.approvedMsg : l10n.rejectedMsg),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final ApprovalItem item = widget.item;
    // Hierarchy: requester (title, semibold) + amount (title, primary,
    // bold) -> reason (body, muted) -> risk (semibold, danger) ->
    // timestamp (caption, faint) -> comment -> actions.
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    item.requester,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  Formatters.inr(item.amount),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        color: tokens.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              item.reason,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: tokens.inkMuted,
                  ),
            ),
            if (item.riskFlag != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  const Icon(
                    Icons.warning_amber_outlined,
                    size: 16,
                    color: AppColors.danger,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      item.riskFlag!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            color: AppColors.danger,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${l10n.createdLabel} · ${Formatters.dateTime(item.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: tokens.inkFaint,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _comment,
              label: l10n.commentHint,
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: l10n.approveAction,
              loading: _working,
              onPressed: _working ? null : () => _decide(true),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: l10n.rejectAction,
              variant: AppButtonVariant.danger,
              onPressed: _working ? null : () => _decide(false),
            ),
            AppButton(
              label: l10n.askInfoAction,
              variant: AppButtonVariant.text,
              onPressed: _working
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.infoAskedMsg)),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
