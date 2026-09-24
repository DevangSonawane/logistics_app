import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/invoice.dart';
import '../application/accountant_providers.dart';

/// A3. Invoices: status filter, IRN chip, PDF view/share per invoice.
class InvoiceListPage extends ConsumerStatefulWidget {
  const InvoiceListPage({super.key});

  @override
  ConsumerState<InvoiceListPage> createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends ConsumerState<InvoiceListPage> {
  InvoiceStatus? _filter;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Invoice>> invoices =
        ref.watch(invoicesProvider);
    return AppScaffold(
      title: l10n.invoicesTitle,
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: AppSpacing.sm),
                  child: ChoiceChip(
                    label: Text(l10n.filterAll),
                    selected: _filter == null,
                    onSelected: (_) =>
                        setState(() => _filter = null),
                  ),
                ),
                for (final InvoiceStatus s in InvoiceStatus.values)
                  Padding(
                    padding:
                        const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(_statusLabel(l10n, s)),
                      selected: _filter == s,
                      onSelected: (_) =>
                          setState(() => _filter = s),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: invoices.when(
              loading: () => const SkeletonList(),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () => ref.invalidate(invoicesProvider),
              ),
              data: (List<Invoice> items) {
                final List<Invoice> visible = items
                    .where((i) => _filter == null || i.status == _filter)
                    .toList();
                if (visible.isEmpty) {
                  return EmptyState(
                    title: l10n.commonEmpty,
                    message: '',
                    icon: Icons.request_quote_outlined,
                  );
                }
                return ListView.separated(
                  itemCount: visible.length,
                  separatorBuilder: (_, __) => const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  itemBuilder: (context, index) {
                    final Invoice inv = visible[index];
                    final (String label, Color color) =
                        _status(l10n, inv.status);
                    return Container(
                      padding:
                          const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: context.tokens.surface,
                        borderRadius: AppSpacing.cardRadius,
                        border: Border.all(
                          color: context.tokens.border,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => context.push(
                          '/accountant/invoices/${inv.id}',
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${inv.no} · ${inv.customerName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  Row(
                                    children: [
                                      StatusChip(
                                        label: label,
                                        color: color,
                                      ),
                                      if (inv.irn != null) ...[
                                        const SizedBox(
                                          width: AppSpacing.xs,
                                        ),
                                        StatusChip(
                                          label: 'IRN',
                                          color: AppColors.info,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Formatters.inr(inv.amount),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                                Text(
                                  '${l10n.dueLabel} ${Formatters.date(inv.dueDate)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n, InvoiceStatus status) {
    return switch (status) {
      InvoiceStatus.draft => l10n.invDraft,
      InvoiceStatus.sent => l10n.invSent,
      InvoiceStatus.partPaid => l10n.invPartPaid,
      InvoiceStatus.paid => l10n.invPaid,
      InvoiceStatus.overdue => l10n.invOverdue,
    };
  }

  (String, Color) _status(AppLocalizations l10n, InvoiceStatus status) {
    return switch (status) {
      InvoiceStatus.draft => (_statusLabel(l10n, status), AppColors.inkFaint),
      InvoiceStatus.sent => (_statusLabel(l10n, status), AppColors.info),
      InvoiceStatus.partPaid => (
          _statusLabel(l10n, status),
          AppColors.warning
        ),
      InvoiceStatus.paid => (_statusLabel(l10n, status), AppColors.success),
      InvoiceStatus.overdue => (
          _statusLabel(l10n, status),
          AppColors.danger
        ),
    };
  }
}
