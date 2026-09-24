import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/customer.dart';
import '../application/accountant_providers.dart';

/// A5. Reminders: overdue customers by priority with an AI likelihood
/// badge, WhatsApp template preview, mock send.
class SendReminderPage extends ConsumerWidget {
  const SendReminderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Customer>> overdue =
        ref.watch(overdueCustomersProvider);
    return AppScaffold(
      title: l10n.remindersTitle,
      body: overdue.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(overdueCustomersProvider),
        ),
        data: (List<Customer> items) => ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final Customer customer = items[index];
            return AppCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          customer.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                      ),
                      Text(
                        Formatters.inr(customer.outstanding),
                        style:
                            Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  if (index < 2)
                    Container(
                      margin: const EdgeInsets.only(top: AppSpacing.xs),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.2),
                        borderRadius: AppSpacing.chipRadius,
                      ),
                      child: Text(
                        l10n.payLikely,
                        style:
                            Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  const SizedBox(height: AppSpacing.sm),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton.icon(
                      icon: const Icon(
                        Icons.send_outlined,
                        size: 18,
                      ),
                      label: Text(l10n.remindPayment),
                      onPressed: () =>
                          _preview(context, customer),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _preview(BuildContext context, Customer customer) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String text = l10n.reminderTemplate(
      customer.name,
      Formatters.inr(customer.outstanding),
    );
    final bool? send = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.remindPayment),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.sendWhatsapp),
          ),
        ],
      ),
    );
    if (send == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reminderSent)),
      );
    }
  }
}
