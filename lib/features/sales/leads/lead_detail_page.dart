import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/lead.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/sales_providers.dart';

/// Lead detail: facts, notes, stage advancement.
class LeadDetailPage extends ConsumerWidget {
  const LeadDetailPage({super.key, required this.leadId});

  final String leadId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Lead>> leads = ref.watch(salesLeadsProvider);
    return leads.when(
      loading: () => AppScaffold(
        title: l10n.leadsTitle,
        body: const SkeletonList(),
      ),
      error: (e, _) => AppScaffold(
        title: l10n.leadsTitle,
        body: ErrorState(message: l10n.commonError),
      ),
      data: (List<Lead> items) {
        Lead? lead;
        for (final Lead l in items) {
          if (l.id == leadId) lead = l;
        }
        if (lead == null) {
          return AppScaffold(
            title: l10n.leadsTitle,
            body: ErrorState(message: l10n.commonError),
          );
        }
        final Lead current = lead;
        final LeadStage? next = _nextStage(current.stage);
        return AppScaffold(
          title: current.company,
          body: ListView(
            children: [
              StatusChip(
                label: _stageLabel(l10n, current.stage),
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: AppSpacing.md),
              _Row(label: l10n.contactLabel, value: current.contact),
              _Row(
                label: l10n.phoneLabel,
                value: '+91 ${current.phone}',
              ),
              _Row(
                label: l10n.stepRoute,
                value: '${current.from} → ${current.to}',
              ),
              _Row(
                label: l10n.vehicleTypeLabel,
                value: current.vehicleType ?? '-',
              ),
              _Row(
                label: l10n.tripsPerMonth,
                value: '${current.expectedTrips}',
              ),
              _Row(
                label: l10n.targetRateLabel,
                value: '${current.targetRate}',
              ),
              if (current.notes != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(current.notes!),
              ],
              if (next != null) ...[
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label:
                      '${l10n.moveToStage}: ${_stageLabel(l10n, next!)}',
                  onPressed: () async {
                    await ref
                        .read(leadRepositoryProvider)
                        .setStage(current.id, next);
                    ref.invalidate(salesLeadsProvider);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  LeadStage? _nextStage(LeadStage stage) {
    return switch (stage) {
      LeadStage.fresh => LeadStage.contacted,
      LeadStage.contacted => LeadStage.quoted,
      LeadStage.quoted => LeadStage.negotiation,
      LeadStage.negotiation => LeadStage.won,
      LeadStage.won || LeadStage.lost => null,
    };
  }

  String _stageLabel(AppLocalizations l10n, LeadStage stage) {
    return switch (stage) {
      LeadStage.fresh => l10n.stageFresh,
      LeadStage.contacted => l10n.stageContacted,
      LeadStage.quoted => l10n.stageQuoted,
      LeadStage.negotiation => l10n.stageNegotiation,
      LeadStage.won => l10n.stageWon,
      LeadStage.lost => l10n.stageLost,
    };
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
