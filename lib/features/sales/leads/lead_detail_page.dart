import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
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
        final AppColorTokens tokens = context.tokens;
        return AppScaffold(
          title: current.company,
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primaryDark,
                          ],
                        ),
                        borderRadius: AppSpacing.cardRadius,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white24,
                                ),
                                child: Text(
                                  current.company.isEmpty
                                      ? '?'
                                      : current.company[0]
                                          .toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                width: AppSpacing.md,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      current.company,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.w700,
                                          ),
                                      maxLines: 1,
                                      overflow:
                                          TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${current.from} → ${current.to}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.white
                                                .withValues(alpha: 0.85),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSpacing.md,
                          ),
                          StatusChip(
                            label:
                                _stageLabel(l10n, current.stage),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _FactsCard(lead: current),
                    if (current.notes != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: tokens.surface,
                          borderRadius: AppSpacing.cardRadius,
                          border: Border.all(
                            color: tokens.border,
                          ),
                        ),
                        child: Text(
                          current.notes!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: tokens.inkMuted),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (next != null) ...[
                const SizedBox(height: AppSpacing.md),
                SafeArea(
                  top: false,
                  child: AppButton(
                    label:
                        '${l10n.moveToStage}: ${_stageLabel(l10n, next)}',
                    onPressed: () async {
                      await ref
                          .read(leadRepositoryProvider)
                          .setStage(current.id, next);
                      ref.invalidate(salesLeadsProvider);
                    },
                  ),
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

/// Two-column fact grid: contact, phone, vehicle, trips, rate.
class _FactsCard extends StatelessWidget {
  const _FactsCard({required this.lead});

  final Lead lead;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final List<(String, String)> facts = [
      (l10n.contactLabel, lead.contact),
      (l10n.phoneLabel, '+91 ${lead.phone}'),
      (l10n.vehicleTypeLabel, lead.vehicleType ?? '-'),
      (l10n.tripsPerMonth, '${lead.expectedTrips}'),
      (l10n.targetRateLabel, '${lead.targetRate}'),
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: tokens.border),
      ),
      child: Column(
        children: [
          for (int i = 0; i < facts.length; i++) ...[
            if (i > 0)
              Divider(
                height: AppSpacing.lg,
                thickness: 1,
                color: tokens.border,
              ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    facts[i].$1,
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: tokens.inkMuted,
                            ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Flexible(
                  child: Text(
                    facts[i].$2,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
