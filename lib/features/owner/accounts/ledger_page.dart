import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/search_bar.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/finance.dart';
import '../application/owner_providers.dart';

/// Customer / vendor ledger with search + running balance + Share PDF.
/// [kind] is 'customer' or 'vendor'.
class LedgerPage extends ConsumerStatefulWidget {
  const LedgerPage({super.key, required this.kind});

  final String kind;

  @override
  ConsumerState<LedgerPage> createState() => _LedgerPageState();
}

class _LedgerPageState extends ConsumerState<LedgerPage> {
  final TextEditingController _search = TextEditingController();
  String _query = '';
  String _accountId = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool get _isCustomer => widget.kind == 'customer';

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: _isCustomer ? l10n.customerLedgerTitle : l10n.vendorLedgerTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () => ShareService().sharePdf(
            _isCustomer ? l10n.customerLedgerTitle : l10n.vendorLedgerTitle,
            const [],
          ),
        ),
      ],
      body: Column(
        children: [
          if (_isCustomer) _AccountPicker(onPick: (id) => setState(() => _accountId = id)),
          AppSearchBar(
            controller: _search,
            hint: l10n.searchHint,
            onChanged: (v) => setState(() => _query = v.toLowerCase()),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: _isCustomer
                ? _CustomerEntries(
                    accountId: _accountId,
                    query: _query,
                  )
                : _VendorEntries(query: _query),
          ),
        ],
      ),
    );
  }
}

class _AccountPicker extends ConsumerWidget {
  const _AccountPicker({required this.onPick});

  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Customer>> customers =
        ref.watch(customersProvider);
    return customers.when(
      loading: () => const SizedBox.shrink(),
      error: (e, _) => const SizedBox.shrink(),
      data: (List<Customer> list) => DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: l10n.customerLabel),
        items: [
          for (final Customer c in list)
            DropdownMenuItem(value: c.id, child: Text(c.name)),
        ],
        onChanged: (v) {
          if (v != null) onPick(v);
        },
      ),
    );
  }
}

class _CustomerEntries extends ConsumerWidget {
  const _CustomerEntries({required this.accountId, required this.query});

  final String accountId;
  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (accountId.isEmpty) {
      return EmptyState(
        title: l10n.selectCustomer,
        message: '',
        icon: Icons.business_outlined,
      );
    }
    final AsyncValue<List<LedgerEntry>> entries =
        ref.watch(customerLedgerProvider(accountId));
    return entries.when(
      loading: () => const SkeletonList(),
      error: (e, _) => ErrorState(
        message: l10n.commonError,
        onRetry: () => ref.invalidate(customerLedgerProvider(accountId)),
      ),
      data: (List<LedgerEntry> list) => _EntryList(
        entries: list.where((e) => e.particulars.toLowerCase().contains(query)).toList(),
      ),
    );
  }
}

class _VendorEntries extends ConsumerWidget {
  const _VendorEntries({required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<LedgerEntry>> entries =
        ref.watch(vendorLedgerProvider('Shinde Transport'));
    return entries.when(
      loading: () => const SkeletonList(),
      error: (e, _) => ErrorState(message: l10n.commonError),
      data: (List<LedgerEntry> list) => _EntryList(
        entries: list.where((e) => e.particulars.toLowerCase().contains(query)).toList(),
      ),
    );
  }
}

class _EntryList extends StatelessWidget {
  const _EntryList({required this.entries});

  final List<LedgerEntry> entries;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (entries.isEmpty) {
      return EmptyState(
        title: l10n.commonEmpty,
        message: '',
        icon: Icons.receipt_long_outlined,
      );
    }
    return ListView.separated(
      itemCount: entries.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final LedgerEntry e = entries[index];
        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.tokens.surface,
            borderRadius: AppSpacing.cardRadius,
            border: Border.all(color: context.tokens.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.particulars),
                    Text(
                      Formatters.date(e.date),
                      style:
                          Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (e.debit > 0)
                    Text(
                      Formatters.inr(e.debit),
                      style: const TextStyle(color: Colors.red),
                    ),
                  if (e.credit > 0)
                    Text(
                      Formatters.inr(e.credit),
                      style: const TextStyle(color: Colors.green),
                    ),
                  Text(
                    '${l10n.balanceLabel}: ${Formatters.inr(e.balance)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
