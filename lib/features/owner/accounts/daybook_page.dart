import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/finance.dart';
import '../application/owner_providers.dart';

/// Day book: today's money movement with Share PDF.
class DaybookPage extends ConsumerWidget {
  const DaybookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<LedgerEntry>> entries =
        ref.watch(daybookProvider);
    return AppScaffold(
      title: l10n.daybookTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () => ShareService().sharePdf(
            l10n.daybookTitle,
            [
              for (final e in entries.valueOrNull ?? const <LedgerEntry>[])
                (
                  '${Formatters.date(e.date)} ${e.particulars}',
                  Formatters.inr(e.credit > 0 ? e.credit : -e.debit)
                ),
            ],
          ),
        ),
      ],
      body: entries.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(daybookProvider),
        ),
        data: (List<LedgerEntry> list) => ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            final LedgerEntry e = list[index];
            final bool incoming = e.credit > 0;
            return Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: context.tokens.surface,
                borderRadius: AppSpacing.cardRadius,
                border: Border.all(color: context.tokens.border),
              ),
              child: Row(
                children: [
                  Icon(
                    incoming
                        ? Icons.arrow_downward_outlined
                        : Icons.arrow_upward_outlined,
                    color: incoming ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.particulars),
                        Text(
                          Formatters.dateTime(e.date),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    Formatters.inr(incoming ? e.credit : -e.debit),
                    style: TextStyle(
                      color: incoming ? Colors.green : Colors.red,
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
}
