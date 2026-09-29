import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_filter_chip.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/lead.dart';
import '../application/sales_providers.dart';

/// S1. Leads: list <-> kanban toggle, source filter, SLA timer chip.
class LeadListPage extends ConsumerStatefulWidget {
  const LeadListPage({super.key});

  @override
  ConsumerState<LeadListPage> createState() => _LeadListPageState();
}

class _LeadListPageState extends ConsumerState<LeadListPage> {
  bool _kanban = false;
  LeadSource? _source;

  String _slaText(AppLocalizations l10n, DateTime? slaDue) {
    if (slaDue == null) return '';
    final Duration diff = slaDue.difference(DateTime.now());
    if (diff.isNegative) {
      return l10n.slaOverdue(_slaAgo(diff));
    }
    return l10n.slaDueIn(_slaAgo(diff));
  }

  String _slaAgo(Duration diff) {
    final Duration abs = diff.abs();
    if (abs.inMinutes < 60) return '${abs.inMinutes}m';
    if (abs.inHours < 24) return '${abs.inHours}h';
    return '${abs.inDays}d';
  }

  Color _slaColor(DateTime? slaDue) {
    if (slaDue == null) return context.tokens.inkFaint;
    final Duration diff = slaDue.difference(DateTime.now());
    if (diff.isNegative) return AppColors.danger;
    if (diff.inMinutes < 30) return AppColors.warning;
    return AppColors.success;
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

  String _sourceLabel(AppLocalizations l10n, LeadSource source) {
    return switch (source) {
      LeadSource.website => l10n.srcWebsite,
      LeadSource.whatsapp => l10n.srcWhatsapp,
      LeadSource.indiamart => l10n.srcIndiamart,
      LeadSource.justdial => l10n.srcJustdial,
      LeadSource.ivr => l10n.srcIvr,
      LeadSource.email => l10n.srcEmail,
      LeadSource.walkin => l10n.srcWalkin,
      LeadSource.referral => l10n.srcReferral,
    };
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Lead>> leads = ref.watch(salesLeadsProvider);
    final AppColorTokens tokens = context.tokens;
    final int count = leads.value?.length ?? 0;
    return AppScaffold(
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          Container(
            color: tokens.surface,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primary,
                              AppColors.primaryDark,
                            ],
                          ),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.md),
                        ),
                        child: const Icon(
                          Icons.trending_up_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.leadsTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontSize: 22),
                            ),
                            Text(
                              '$count ${l10n.salesTabLeads.toLowerCase()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: tokens.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _kanban
                              ? Icons.view_list_outlined
                              : Icons.view_kanban_outlined,
                          color: tokens.ink,
                        ),
                        onPressed: () =>
                            setState(() => _kanban = !_kanban),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppFilterRow(
                    children: [
                      AppFilterChip(
                        label: l10n.filterAll,
                        selected: _source == null,
                        onTap: () =>
                            setState(() => _source = null),
                      ),
                      for (final LeadSource s in LeadSource.values)
                        AppFilterChip(
                          label: _sourceLabel(l10n, s),
                          selected: _source == s,
                          onTap: () =>
                              setState(() => _source = s),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: leads.when(
                      loading: () => const SkeletonList(),
                      error: (e, _) => ErrorState(
                        message: l10n.commonError,
                        onRetry: () =>
                            ref.invalidate(salesLeadsProvider),
                      ),
                      data: (List<Lead> items) {
                        final List<Lead> visible = items
                            .where(
                              (l) =>
                                  _source == null ||
                                  l.source == _source,
                            )
                            .toList();
                        if (visible.isEmpty) {
                          return EmptyState(
                            title: l10n.commonEmpty,
                            message: '',
                            icon: Icons.person_add_outlined,
                          );
                        }
                        if (_kanban) {
                          return _Kanban(
                            leads: visible,
                            stageLabel: (s) => _stageLabel(l10n, s),
                            slaText: (d) => _slaText(l10n, d),
                            slaColor: _slaColor,
                          );
                        }
                        return ListView.separated(
                          itemCount: visible.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(
                            height: AppSpacing.sm,
                          ),
                          itemBuilder: (context, index) =>
                              _LeadTile(
                            lead: visible[index],
                            stageLabel: _stageLabel(
                              l10n,
                              visible[index].stage,
                            ),
                            slaText: _slaText(
                              l10n,
                              visible[index].slaDue,
                            ),
                            slaColor: _slaColor(
                              visible[index].slaDue,
                            ),
                            sourceLabel: _sourceLabel(
                              l10n,
                              visible[index].source,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SafeArea(
                    top: false,
                    child: _AddLeadCta(
                      label: l10n.addLeadAction,
                      onTap: () =>
                          context.push(RouteNames.salesLeadNew),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sticky gradient CTA pinned above the nav dock.
class _AddLeadCta extends StatelessWidget {
  const _AddLeadCta({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: AppSpacing.buttonHeightMd,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          borderRadius:
              BorderRadius.circular(AppSpacing.radiusButton),
          boxShadow: [
            BoxShadow(
              color: tokens.primary.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.white, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeadTile extends StatelessWidget {
  const _LeadTile({
    required this.lead,
    required this.stageLabel,
    required this.slaText,
    required this.slaColor,
    required this.sourceLabel,
  });

  final Lead lead;
  final String stageLabel;
  final String slaText;
  final Color slaColor;
  final String sourceLabel;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: () => context.push('/sales/leads/${lead.id}'),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tokens.surface,
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(color: tokens.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tokens.primary.withValues(alpha: 0.1),
              ),
              child: Text(
                lead.company.isEmpty ? '?' : lead.company[0].toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: tokens.primary,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lead.company,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      StatusChip(
                        label: stageLabel,
                        color: AppColors.info,
                      ),
                    ],
                  ),
                  Text(
                    '${lead.from} → ${lead.to} · ${lead.expectedTrips}/mo',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: tokens.inkMuted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        sourceLabel,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: tokens.inkFaint,
                              fontSize: 11,
                            ),
                      ),
                      const Spacer(),
                      if (slaText.isNotEmpty)
                        StatusChip(
                          label: slaText,
                          color: slaColor,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Kanban extends StatelessWidget {
  const _Kanban({
    required this.leads,
    required this.stageLabel,
    required this.slaText,
    required this.slaColor,
  });

  final List<Lead> leads;
  final String Function(LeadStage) stageLabel;
  final String Function(DateTime?) slaText;
  final Color Function(DateTime?) slaColor;

  static const List<LeadStage> columns = [
    LeadStage.fresh,
    LeadStage.contacted,
    LeadStage.quoted,
    LeadStage.negotiation,
    LeadStage.won,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (final LeadStage stage in columns)
          Container(
            width: 240,
            margin: const EdgeInsets.only(right: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stageLabel(stage),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: ListView(
                    children: [
                      for (final Lead lead in leads.where(
                        (l) => l.stage == stage,
                      ))
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.sm,
                          ),
                          child: _LeadTile(
                            lead: lead,
                            stageLabel: stageLabel(lead.stage),
                            slaText: slaText(lead.slaDue),
                            slaColor: slaColor(lead.slaDue),
                            sourceLabel: lead.contact,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
