import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/finance.dart';
import '../../owner/application/owner_providers.dart';

/// GST summary (shared finance read, accountant route).
class AccountGstPage extends ConsumerWidget {
  const AccountGstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<GstSummary> gst = ref.watch(gstSummaryProvider);
    return AppScaffold(
      title: l10n.gstSummaryTitle,
      body: gst.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(message: l10n.commonError),
        data: (GstSummary g) => AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                g.month,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              _Row(label: 'CGST', amount: g.cgst),
              _Row(label: 'SGST', amount: g.sgst),
              _Row(label: 'IGST', amount: g.igst),
              const Divider(),
              _Row(
                label: l10n.balanceLabel,
                amount: g.cgst + g.sgst + g.igst,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.amount});

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(Formatters.inr(amount)),
        ],
      ),
    );
  }
}
