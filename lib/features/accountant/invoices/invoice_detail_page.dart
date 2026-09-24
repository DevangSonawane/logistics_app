import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/pdf_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../data/models/invoice.dart';
import '../application/accountant_providers.dart';

/// Invoice detail with PDF view/share and receipt shortcut.
class InvoiceDetailPage extends ConsumerWidget {
  const InvoiceDetailPage({super.key, required this.invoiceId});

  final String invoiceId;

  Future<void> _openPdf(
    BuildContext context,
    WidgetRef ref,
    Invoice inv,
  ) async {
    final Uint8List bytes = await PdfService().statement(
      title: '${inv.no} · ${inv.customerName}',
      rows: [
        ('Amount', Formatters.inr(inv.amount)),
        ('GST', Formatters.inr(inv.gst)),
        ('Paid', Formatters.inr(inv.paidAmount)),
        ('Due', Formatters.date(inv.dueDate)),
        if (inv.irn != null) ('IRN', inv.irn!),
      ],
    );
    if (!context.mounted) return;
    context.push(
      '/pdf',
      extra: {'title': inv.no, 'bytes': bytes},
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Invoice>> invoices =
        ref.watch(invoicesProvider);
    return invoices.when(
      loading: () => AppScaffold(
        title: l10n.invoicesTitle,
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => AppScaffold(
        title: l10n.invoicesTitle,
        body: ErrorState(message: l10n.commonError),
      ),
      data: (List<Invoice> items) {
        Invoice? inv;
        for (final Invoice i in items) {
          if (i.id == invoiceId) inv = i;
        }
        if (inv == null) {
          return AppScaffold(
            title: l10n.invoicesTitle,
            body: ErrorState(message: l10n.commonError),
          );
        }
        final Invoice current = inv;
        return AppScaffold(
          title: current.no,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Row(
                label: l10n.customerLabel,
                value: current.customerName,
              ),
              _Row(
                label: l10n.amountLabel,
                value: Formatters.inr(current.amount),
              ),
              _Row(
                label: 'GST',
                value: Formatters.inr(current.gst),
              ),
              _Row(
                label: l10n.paidLabel,
                value: Formatters.inr(current.paidAmount),
              ),
              _Row(
                label: l10n.dueLabel,
                value: Formatters.date(current.dueDate),
              ),
              if (current.irn != null)
                _Row(label: 'IRN', value: current.irn!),
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: l10n.viewPdf,
                variant: AppButtonVariant.secondary,
                icon: Icons.picture_as_pdf_outlined,
                onPressed: () => _openPdf(context, ref, current),
              ),
              if (current.status != InvoiceStatus.paid) ...[
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: l10n.recordReceiptTitle,
                  onPressed: () =>
                      context.push('/accountant/receipts'),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.tokens.inkMuted,
                  ),
            ),
          ),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
