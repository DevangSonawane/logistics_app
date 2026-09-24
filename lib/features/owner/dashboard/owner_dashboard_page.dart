import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/kpi_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/mock/mock_users.dart';
import '../../../data/models/dashboard.dart';
import '../application/owner_providers.dart';

/// O1. Owner dashboard: hero header, KPI grid, trend, lanes, attention,
/// brief teaser and ask-your-data.
class OwnerDashboardPage extends ConsumerStatefulWidget {
  const OwnerDashboardPage({super.key});

  @override
  ConsumerState<OwnerDashboardPage> createState() =>
      _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends ConsumerState<OwnerDashboardPage> {
  String _branch = 'all';
  int _rangeDays = 30;
  final TextEditingController _ask = TextEditingController();
  DataAnswer? _answer;
  bool _asking = false;

  @override
  void dispose() {
    _ask.dispose();
    super.dispose();
  }

  Future<void> _pickBranch() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final List<(String, String)> branches = [
      ('all', l10n.branchAll),
      for (final b in MockCompany.company.branches) (b.id, b.name),
    ];
    final String? picked = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final (id, name) in branches)
              ListTile(
                title: Text(name),
                trailing: id == _branch
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () => Navigator.of(context).pop(id),
              ),
          ],
        ),
      ),
    );
    if (picked != null && mounted) setState(() => _branch = picked);
  }

  Future<void> _askData() async {
    final String query = _ask.text.trim();
    if (query.isEmpty || _asking) return;
    setState(() {
      _asking = true;
      _answer = null;
    });
    final DataAnswer answer =
        await ref.read(dashboardRepositoryProvider).ask(query);
    if (!mounted) return;
    setState(() {
      _asking = false;
      _answer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<DashboardKpis> kpis =
        ref.watch(ownerKpisProvider(_branch));
    final AsyncValue<List<TrendPoint>> trend =
        ref.watch(revenueTrendProvider);
    final int unread =
        ref.watch(unreadNotificationsCountProvider).valueOrNull ?? 0;
    return AppScaffold(
      padding: EdgeInsets.zero,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(gradient: AppColors.heroGradient),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xxl,
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _pickBranch,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: AppSpacing.chipRadius,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _branch == 'all'
                                    ? l10n.branchAll
                                    : MockCompany.company.branches
                                        .firstWhere((b) => b.id == _branch)
                                        .name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Badge(
                          isLabelVisible: unread > 0,
                          label: Text('$unread'),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => context.push('/owner/alerts'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    Formatters.inrShort(
                      kpis.valueOrNull?.revenueMonth ?? 0,
                    ),
                    style: AppTypography.kpiNumber(Colors.white).copyWith(
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    l10n.revenueMonth,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      for (final (days, label) in [
                        (1, l10n.todayLabel),
                        (7, l10n.range7d),
                        (30, l10n.rangeMonth),
                      ])
                        Padding(
                          padding:
                              const EdgeInsets.only(right: AppSpacing.sm),
                          child: ChoiceChip(
                            label: Text(label),
                            selected: _rangeDays == days,
                            selectedColor: AppColors.accent,
                            onSelected: (_) =>
                                setState(() => _rangeDays = days),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: kpis.when(
              loading: () => const SkeletonList(),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () =>
                    ref.invalidate(ownerKpisProvider(_branch)),
              ),
              data: (DashboardKpis k) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _KpiGrid(kpis: k, rangeDays: _rangeDays),
                  const SizedBox(height: AppSpacing.xl),
                  SectionHeader(title: l10n.trendTitle),
                  const SizedBox(height: AppSpacing.sm),
                  _TrendChart(
                    points: (trend.valueOrNull ?? const [])
                        .take(_rangeDays)
                        .toList(),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const _TopLanes(),
                  const SizedBox(height: AppSpacing.xl),
                  const _BottomCustomers(),
                  const SizedBox(height: AppSpacing.xl),
                  const _AttentionStrip(),
                  const SizedBox(height: AppSpacing.xl),
                  _BriefTeaser(),
                  const SizedBox(height: AppSpacing.xl),
                  SectionHeader(title: l10n.askTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ask,
                          decoration: InputDecoration(
                            hintText: l10n.askHint,
                          ),
                          onSubmitted: (_) => _askData(),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton.filled(
                        icon: _asking
                            ? const SizedBox(
                                width: AppSpacing.lg,
                                height: AppSpacing.lg,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.send_outlined),
                        onPressed: _askData,
                      ),
                    ],
                  ),
                  if (_answer != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    _AnswerCard(answer: _answer!),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.kpis, required this.rangeDays});

  final DashboardKpis kpis;
  final int rangeDays;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int total = kpis.running + kpis.delayed + kpis.delivered;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.05,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.tripsToday,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.tokens.inkMuted,
                    ),
              ),
              Text(
                '${kpis.tripsToday}',
                style: AppTypography.kpiNumber(context.tokens.ink),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Running / Delayed / Delivered segmented bar.
              ClipRRect(
                borderRadius: AppSpacing.chipRadius,
                child: Row(
                  children: [
                    Expanded(
                      flex: total == 0 ? 1 : kpis.running,
                      child: Container(
                        height: AppSpacing.sm,
                        color: AppColors.primary,
                      ),
                    ),
                    Expanded(
                      flex: total == 0 ? 1 : kpis.delayed,
                      child: Container(
                        height: AppSpacing.sm,
                        color: AppColors.danger,
                      ),
                    ),
                    Expanded(
                      flex: total == 0 ? 1 : kpis.delivered,
                      child: Container(
                        height: AppSpacing.sm,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${kpis.running} / ${kpis.delayed} / ${kpis.delivered}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        KpiCard(
          label: rangeDays == 1
              ? l10n.revenueToday
              : rangeDays == 7
                  ? l10n.revenueWeek
                  : l10n.revenueMonth,
          value: Formatters.inrShort(
            rangeDays == 1
                ? kpis.revenueToday
                : rangeDays == 7
                    ? kpis.revenueToday * 7
                    : kpis.revenueMonth,
          ),
          icon: Icons.currency_rupee_outlined,
        ),
        KpiCard(
          label: l10n.collectionsMonth,
          value: Formatters.inrShort(kpis.collectionsMonth),
          icon: Icons.payments_outlined,
          iconTint: AppColors.secondary,
        ),
        KpiCard(
          label: l10n.outstandingLabel,
          value: Formatters.inrShort(kpis.outstanding),
          icon: Icons.warning_amber_outlined,
          iconTint: AppColors.warning,
        ),
        KpiCard(
          label: l10n.cashBankLabel,
          value: Formatters.inrShort(kpis.cashBank),
          icon: Icons.account_balance_outlined,
          iconTint: AppColors.info,
        ),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.utilisationLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.tokens.inkMuted,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: AppSpacing.huge,
                    height: AppSpacing.huge,
                    child: CircularProgressIndicator(
                      value: kpis.utilisationPct / 100,
                      strokeWidth: AppSpacing.sm,
                      backgroundColor: context.tokens.surfaceAlt,
                      color: AppColors.secondary,
                    ),
                  ),
                  Text(
                    '${kpis.utilisationPct}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.points});

  final List<TrendPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) return const SizedBox(height: 120);
    final double maxY = points
            .map((p) => p.revenue)
            .reduce((a, b) => a > b ? a : b)
            .toDouble() *
        1.15;
    List<FlSpot> spots(Iterable<int> values) => [
          for (int i = 0; i < values.length; i++)
            FlSpot(i.toDouble(), values.elementAt(i).toDouble()),
        ];
    return AppCard(
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            maxY: maxY,
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots(points.map((p) => p.revenue)),
                isCurved: true,
                color: AppColors.primary,
                barWidth: 2.5,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
              LineChartBarData(
                spots: spots(points.map((p) => p.collection)),
                isCurved: true,
                color: AppColors.secondary,
                barWidth: 2,
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopLanes extends ConsumerWidget {
  const _TopLanes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<LaneMargin>> lanes =
        ref.watch(topLanesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: l10n.topLanesTitle),
        const SizedBox(height: AppSpacing.sm),
        lanes.when(
          loading: () => const SkeletonList(itemCount: 3),
          error: (e, _) => ErrorState(message: l10n.commonError),
          data: (List<LaneMargin> items) => Column(
            children: [
              for (final LaneMargin lane in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(lane.lane),
                      ),
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: AppSpacing.chipRadius,
                          child: LinearProgressIndicator(
                            value: lane.marginPct / 25,
                            minHeight: AppSpacing.sm,
                            backgroundColor:
                                context.tokens.surfaceAlt,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      SizedBox(
                        width: 44,
                        child: Text(
                          '${lane.marginPct}%',
                          textAlign: TextAlign.end,
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

class _BottomCustomers extends ConsumerWidget {
  const _BottomCustomers();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<CustomerMargin>> customers =
        ref.watch(bottomCustomersProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: l10n.bottomCustomersTitle),
        const SizedBox(height: AppSpacing.sm),
        customers.when(
          loading: () => const SkeletonList(itemCount: 2),
          error: (e, _) => ErrorState(message: l10n.commonError),
          data: (List<CustomerMargin> items) => Column(
            children: [
              for (final CustomerMargin c in items)
                AppCard(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.flag_outlined,
                        color: AppColors.danger,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: Text(c.name)),
                      Text(
                        '${c.marginPct}%',
                        style: const TextStyle(color: AppColors.danger),
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

class _AttentionStrip extends ConsumerWidget {
  const _AttentionStrip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<AttentionItem>> items =
        ref.watch(attentionProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: l10n.attentionTitle),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 96,
          child: items.when(
            loading: () => const SkeletonList(itemCount: 2),
            error: (e, _) => ErrorState(message: l10n.commonError),
            data: (List<AttentionItem> list) => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(
                width: AppSpacing.sm,
              ),
              itemBuilder: (context, index) {
                final AttentionItem item = list[index];
                return AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: SizedBox(
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.count}',
                          style: AppTypography.kpiNumber(
                            AppColors.warning,
                          ).copyWith(fontSize: AppSpacing.xl),
                        ),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BriefTeaser extends ConsumerWidget {
  const _BriefTeaser();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<String> brief = ref.watch(dailyBriefProvider);
    return AppCard(
      onTap: () => context.push('/owner/brief'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.briefTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              TextButton(
                onPressed: () => context.push('/owner/brief'),
                child: Text(l10n.readFullBrief),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          brief.when(
            loading: () => const SkeletonList(itemCount: 2),
            error: (e, _) => Text(l10n.commonError),
            data: (String text) => Text(
              text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({required this.answer});

  final DataAnswer answer;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TypingText(text: answer.text),
          if (answer.series.length >= 2) ...[
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 64,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (int i = 0; i < answer.series.length; i++)
                          FlSpot(i.toDouble(), answer.series[i].toDouble()),
                      ],
                      isCurved: true,
                      color: AppColors.secondary,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Types the answer out progressively.
class _TypingText extends StatefulWidget {
  const _TypingText({required this.text});

  final String text;

  @override
  State<_TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<_TypingText> {
  Timer? _timer;
  int _chars = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 12), (_) {
      if (!mounted) return;
      if (_chars >= widget.text.length) {
        _timer?.cancel();
        return;
      }
      setState(() => _chars += 3);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.text.substring(0, _chars.clamp(0, widget.text.length)));
  }
}
