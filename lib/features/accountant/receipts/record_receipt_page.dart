import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/invoice.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../auth/application/session_provider.dart';
import '../application/accountant_providers.dart';

/// A6. Record receipt (permission-gated): customer, invoices, amount,
/// mode, UTR, TDS, short-pay reason.
class RecordReceiptPage extends ConsumerStatefulWidget {
  const RecordReceiptPage({super.key});

  @override
  ConsumerState<RecordReceiptPage> createState() =>
      _RecordReceiptPageState();
}

class _RecordReceiptPageState extends ConsumerState<RecordReceiptPage> {
  String? _customerId;
  final Set<String> _invoiceIds = {};
  final TextEditingController _amount = TextEditingController();
  String _mode = 'UPI';
  final TextEditingController _utr = TextEditingController();
  final TextEditingController _tds = TextEditingController();
  final TextEditingController _shortPay = TextEditingController();
  bool _working = false;
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _utr.dispose();
    _tds.dispose();
    _shortPay.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int amount = int.tryParse(_amount.text.trim()) ?? 0;
    if (_customerId == null || amount <= 0) {
      setState(() => _error = l10n.fillAllFields);
      return;
    }
    setState(() {
      _error = null;
      _working = true;
    });
    try {
      await ref.read(financeRepositoryProvider).recordReceipt(
            Receipt(
              id: 'local',
              customerId: _customerId!,
              invoiceIds: _invoiceIds.toList(),
              amount: amount,
              mode: _mode,
              utr: _utr.text.trim().isEmpty
                  ? null
                  : _utr.text.trim(),
              tds: int.tryParse(_tds.text.trim()) ?? 0,
              shortPayReason: _shortPay.text.trim().isEmpty
                  ? null
                  : _shortPay.text.trim(),
              at: DateTime.now(),
            ),
          );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _working = false;
        _error = l10n.commonError;
      });
      return;
    }
    if (!mounted) return;
    setState(() => _working = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.receiptSaved)),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final bool allowed =
        ref.watch(canProvider(AppPermission.recordReceipt));
    if (!allowed) {
      return AppScaffold(
        title: l10n.recordReceiptTitle,
        body: EmptyState(
          title: l10n.receiptNotAllowed,
          message: '',
          icon: Icons.lock_outline,
        ),
      );
    }
    final AsyncValue<List<Customer>> customers =
        ref.watch(accountCustomersProvider);
    final AsyncValue<List<Invoice>> invoices =
        ref.watch(invoicesProvider);
    return AppScaffold(
      title: l10n.recordReceiptTitle,
      body: ListView(
        children: [
          customers.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (List<Customer> list) => DropdownButtonFormField<String>(
              initialValue: _customerId,
              decoration: InputDecoration(
                labelText: l10n.customerLabel,
              ),
              items: [
                for (final Customer c in list)
                  DropdownMenuItem(
                    value: c.id,
                    child: Text(c.name),
                  ),
              ],
              onChanged: (v) => setState(() {
                _customerId = v;
                _invoiceIds.clear();
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          invoices.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (List<Invoice> list) {
              final List<Invoice> unpaid = list
                  .where(
                    (i) =>
                        i.customerId == _customerId &&
                        i.status != InvoiceStatus.paid,
                  )
                  .toList();
              if (_customerId == null) {
                return Text(
                  l10n.selectCustomer,
                  style: Theme.of(context).textTheme.bodySmall,
                );
              }
              return Column(
                children: [
                  for (final Invoice inv in unpaid)
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('${inv.no} · ${inv.amount}'),
                      value: _invoiceIds.contains(inv.id),
                      onChanged: (v) => setState(() {
                        if (v == true) {
                          _invoiceIds.add(inv.id);
                        } else {
                          _invoiceIds.remove(inv.id);
                        }
                      }),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _amount,
            label: l10n.amountLabel,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.md),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Cash', label: Text('Cash')),
              ButtonSegment(value: 'UPI', label: Text('UPI')),
              ButtonSegment(value: 'NEFT', label: Text('NEFT')),
            ],
            selected: {_mode},
            onSelectionChanged: (s) =>
                setState(() => _mode = s.first),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(controller: _utr, label: l10n.utrLabel),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _tds,
            label: l10n.tdsLabel,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _shortPay,
            label: l10n.shortPayLabel,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(_error!),
          ],
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: l10n.saveAction,
            variant: AppButtonVariant.accent,
            large: true,
            loading: _working,
            onPressed: _working ? null : _save,
          ),
        ],
      ),
    );
  }
}
