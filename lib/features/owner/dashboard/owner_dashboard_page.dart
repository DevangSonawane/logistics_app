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
import '../../../core/widgets/app_filter_chip.dart';
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
  ConsumerState<OwnerDashboardPage> createState() => _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends ConsumerState<OwnerDashboardPage> {
  String _branch = 'all';
  int _rangeDays = 30;

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

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final AsyncValue<DashboardKpis> kpis = ref.watch(
      ownerKpisProvider(_branch),
    );
    final AsyncValue<List<TrendPoint>> trend = ref.watch(revenueTrendProvider);
    final int unread = ref.watch(unreadNotificationsCountProvider).value ?? 0;
    final String branchName = _branch == 'all'
        ? l10n.branchAll
        : MockCompany.company.branches.firstWhere((b) => b.id == _branch).name;
    return AppScaffold(
      padding: EdgeInsets.zero,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: tokens.surface,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.ownerTabDashboard,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            GestureDetector(
                              onTap: _pickBranch,
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    branchName,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: tokens.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 18,
                                    color: tokens.primary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search_outlined, color: tokens.ink),
                        onPressed: () => context.push(RouteNames.search),
                      ),
                      IconButton(
                        icon: Badge(
                          isLabelVisible: unread > 0,
                          label: Text('$unread'),
                          child: Icon(
                            Icons.notifications_outlined,
                            color: tokens.ink,
                          ),
                        ),
                        onPressed: () => context.push(RouteNames.notifications),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Hero revenue card: lavender tint, big primary numeral,
                  // range pills switch the KPI grid + chart below.
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: AppSpacing.cardRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.revenueMonth,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: tokens.inkMuted,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          Formatters.inrShort(kpis.value?.revenueMonth ?? 0),
                          style: AppTypography.kpiNumber(
                            tokens.primary,
                          ).copyWith(fontSize: 30),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: [
                            for (final (days, label) in [
                              (1, l10n.todayLabel),
                              (7, l10n.range7d),
                              (30, l10n.rangeMonth),
                            ])
                              AppFilterChip(
                                label: label,
                                selected: _rangeDays == days,
                                onTap: () => setState(
                                  () => _rangeDays = days,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: kpis.when(
              loading: () => const SkeletonList(),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () => ref.invalidate(ownerKpisProvider(_branch)),
              ),
              data: (DashboardKpis k) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _KpiGrid(kpis: k, rangeDays: _rangeDays),
                  const _SectionDivider(),
                  SectionHeader(title: l10n.trendTitle),
                  const SizedBox(height: AppSpacing.sm),
                  _TrendChart(
                    points: (trend.value ?? const []).take(_rangeDays).toList(),
                  ),
                  const _SectionDivider(),
                  const _TopLanes(),
                  const _SectionDivider(),
                  const _BottomCustomers(),
                  const _SectionDivider(),
                  const _AttentionStrip(),
                  const _SectionDivider(),
                  _BriefTeaser(),
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
    final AppColorTokens tokens = context.tokens;
    final int total = kpis.running + kpis.delayed + kpis.delivered;
    final int revenue = rangeDays == 1
        ? kpis.revenueToday
        : rangeDays == 7
        ? kpis.revenueToday * 7
        : kpis.revenueMonth;
    // Relative bars: each money card scales against the largest figure.
    final int maxMoney = [
      revenue,
      kpis.collectionsMonth,
      kpis.outstanding,
      kpis.cashBank,
    ].reduce((a, b) => a > b ? a : b);
    double rel(int v) => maxMoney == 0 ? 0 : v / maxMoney;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.0,
      children: [
        // Trips card: same embossed shell, segmented status bar.
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: tokens.surfaceAlt,
            borderRadius: AppSpacing.cardRadius,
            boxShadow: [
              const BoxShadow(
                color: Colors.white,
                blurRadius: 12,
                offset: Offset(-6, -6),
              ),
              BoxShadow(
                color: tokens.inkFaint.withValues(alpha: 0.45),
                blurRadius: 12,
                offset: const Offset(6, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.tripsToday,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: tokens.inkMuted,
                      height: 1.2,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${kpis.tripsToday}',
                style: AppTypography.kpiNumber(
                  tokens.ink,
                ).copyWith(fontSize: 24),
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
            ],
          ),
        ),
        KpiCard(
          label: rangeDays == 1
              ? l10n.revenueToday
              : rangeDays == 7
              ? l10n.revenueWeek
              : l10n.revenueMonth,
          value: Formatters.inrShort(revenue),
          icon: Icons.currency_rupee_outlined,
          fraction: rel(revenue),
        ),
        KpiCard(
          label: l10n.collectionsMonth,
          value: Formatters.inrShort(kpis.collectionsMonth),
          icon: Icons.payments_outlined,
          iconTint: AppColors.secondary,
          fraction: rel(kpis.collectionsMonth),
        ),
        KpiCard(
          label: l10n.outstandingLabel,
          value: Formatters.inrShort(kpis.outstanding),
          icon: Icons.warning_amber_outlined,
          iconTint: AppColors.warning,
          fraction: rel(kpis.outstanding),
        ),
        KpiCard(
          label: l10n.cashBankLabel,
          value: Formatters.inrShort(kpis.cashBank),
          icon: Icons.account_balance_outlined,
          iconTint: AppColors.info,
          fraction: rel(kpis.cashBank),
        ),
        KpiCard(
          label: l10n.utilisationLabel,
          value: '${kpis.utilisationPct}%',
          icon: Icons.local_shipping_outlined,
          iconTint: AppColors.secondary,
          fraction: kpis.utilisationPct / 100,
          progressLabel: '${kpis.utilisationPct}%',
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
    final AppColorTokens tokens = context.tokens;
    if (points.length < 2) return const SizedBox(height: 120);
    final double maxY =
        points
            .map((p) => p.revenue)
            .reduce((a, b) => a > b ? a : b)
            .toDouble() *
        1.2;
    List<FlSpot> spots(Iterable<int> values) => [
      for (int i = 0; i < values.length; i++)
        FlSpot(i.toDouble(), values.elementAt(i).toDouble()),
    ];
    final TextStyle axisStyle =
        Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: tokens.inkFaint, fontSize: 10) ??
        const TextStyle(fontSize: 10);
    final int step = (points.length / 4).ceil();
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              _LegendDot(
                color: AppColors.primary,
                label: AppLocalizations.of(context).legendRevenue,
              ),
              const SizedBox(width: AppSpacing.lg),
              _LegendDot(
                color: AppColors.secondary,
                label: AppLocalizations.of(context).legendCollection,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 210,
            child: LineChart(
              LineChartData(
                maxY: maxY,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) =>
                      FlLine(color: tokens.border, strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 44,
                      getTitlesWidget: (value, _) => Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xs),
                        child: Text(
                          Formatters.inrShort(value.round()),
                          style: axisStyle,
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: step.toDouble(),
                      getTitlesWidget: (value, _) {
                        final int i = value.round();
                        if (i < 0 || i >= points.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xs),
                          child: Text(points[i].day, style: axisStyle),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots(points.map((p) => p.revenue)),
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: AppColors.primary,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.28),
                          AppColors.primary.withValues(alpha: 0.02),
                        ],
                      ),
                    ),
                  ),
                  LineChartBarData(
                    spots: spots(points.map((p) => p.collection)),
                    isCurved: true,
                    curveSmoothness: 0.35,
                    color: AppColors.secondary,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.secondary.withValues(alpha: 0.18),
                          AppColors.secondary.withValues(alpha: 0.02),
                        ],
                      ),
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

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.tokens.inkMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _TopLanes extends ConsumerWidget {
  const _TopLanes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<LaneMargin>> lanes = ref.watch(topLanesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: l10n.topLanesTitle),
        const SizedBox(height: AppSpacing.sm),
        lanes.when(
          loading: () => const SkeletonList(itemCount: 3),
          error: (e, _) => ErrorState(message: l10n.commonError),
          data: (List<LaneMargin> items) => AppCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: context.tokens.border,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.tokens.primary.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          child: Text(
                            '${i + 1}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: context.tokens.primary,
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
                                      items[i].lane,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Text(
                                    '${items[i].marginPct}%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.success,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: AppSpacing.chipRadius,
                                child: LinearProgressIndicator(
                                  value: (items[i].marginPct / 25).clamp(
                                    0.0,
                                    1.0,
                                  ),
                                  minHeight: 6,
                                  backgroundColor: context.tokens.surfaceAlt,
                                  valueColor: const AlwaysStoppedAnimation(
                                    AppColors.success,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
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
    final AsyncValue<List<CustomerMargin>> customers = ref.watch(
      bottomCustomersProvider,
    );
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
                      const Icon(Icons.flag_outlined, color: AppColors.danger),
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
    final AsyncValue<List<AttentionItem>> items = ref.watch(attentionProvider);
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
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
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
    return GestureDetector(
      onTap: () => context.push('/owner/brief'),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          borderRadius: AppSpacing.cardRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                  ),
                  child: const Icon(
                    Icons.auto_awesome_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    l10n.briefTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            brief.when(
              loading: () => const SkeletonList(itemCount: 2),
              error: (e, _) => Text(
                l10n.commonError,
                style: const TextStyle(color: Colors.white),
              ),
              data: (String text) => Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.readFullBrief,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Gray divider between dashboard sections.
class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Divider(height: 1, thickness: 1, color: context.tokens.border),
    );
  }
}
