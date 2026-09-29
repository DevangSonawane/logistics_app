import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/search_bar.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/order.dart';
import '../application/ops_providers.dart';

/// P1. Orders list: status tabs, search, FAB to create.
class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({super.key});

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
  OrderStatus _tab = OrderStatus.pending;
  final TextEditingController _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Color _statusColor(OrderStatus status) {
    return switch (status) {
      OrderStatus.pending => AppColors.warning,
      OrderStatus.planned => AppColors.info,
      OrderStatus.running => AppColors.primary,
      OrderStatus.completed => AppColors.success,
      OrderStatus.cancelled => context.tokens.inkFaint,
    };
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Order>> orders =
        ref.watch(ordersByStatusProvider(_tab));
    String tabLabel(OrderStatus s) {
      return switch (s) {
        OrderStatus.pending => l10n.orderPending,
        OrderStatus.planned => l10n.orderPlanned,
        OrderStatus.running => l10n.orderRunning,
        OrderStatus.completed => l10n.orderCompleted,
        OrderStatus.cancelled => l10n.orderPending,
      };
    }

    final AppColorTokens tokens = context.tokens;
    final int count = orders.value?.length ?? 0;
    final List<OrderStatus> tabs = const [
      OrderStatus.pending,
      OrderStatus.planned,
      OrderStatus.running,
      OrderStatus.completed,
    ];
    // Per-tab counts for the tappable KPI cards below.
    final Map<OrderStatus, int> counts = {
      for (final OrderStatus s in tabs)
        s: ref.watch(ordersByStatusProvider(s)).value?.length ?? 0,
    };
    return AppScaffold(
      padding: EdgeInsets.zero,
      refresh: () async {
        ref.invalidate(ordersByStatusProvider(_tab));
      },
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
                          Icons.list_alt_outlined,
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
                              l10n.ordersTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontSize: 22),
                            ),
                            Text(
                              '$count ${tabLabel(_tab).toLowerCase()}',
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
                          Icons.search_outlined,
                          color: tokens.ink,
                        ),
                        onPressed: () =>
                            context.push(RouteNames.search),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    height: 72,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      separatorBuilder: (_, _) => const SizedBox(
                        width: AppSpacing.sm,
                      ),
                      itemBuilder: (_, i) {
                        final OrderStatus s = tabs[i];
                        return SizedBox(
                          width: 152,
                          child: _TabKpi(
                            label: tabLabel(s),
                            count: counts[s] ?? 0,
                            tint: _statusColor(s),
                            selected: _tab == s,
                            onTap: () => setState(() => _tab = s),
                          ),
                        );
                      },
                    ),
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
                  AppSearchBar(
                    controller: _search,
                    hint: l10n.searchHint,
                    onChanged: (v) =>
                        setState(() => _query = v.toLowerCase()),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: orders.when(
                      loading: () => const SkeletonList(),
                      error: (e, _) => ErrorState(
                        message: l10n.commonError,
                        onRetry: () => ref.invalidate(
                          ordersByStatusProvider(_tab),
                        ),
                      ),
                      data: (List<Order> items) {
                        final List<Order> visible = items
                            .where(
                              (o) =>
                                  o.no
                                      .toLowerCase()
                                      .contains(_query) ||
                                  o.customerName
                                      .toLowerCase()
                                      .contains(_query),
                            )
                            .toList();
                        if (visible.isEmpty) {
                          return EmptyState(
                            title: l10n.commonEmpty,
                            message: '',
                            icon: Icons.list_alt_outlined,
                          );
                        }
                        return ListView.separated(
                          itemCount: visible.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(
                            height: AppSpacing.sm,
                          ),
                          itemBuilder: (context, index) {
                            final Order order = visible[index];
                            return _OrderCard(
                              order: order,
                              statusLabel: tabLabel(order.status),
                              statusColor:
                                  _statusColor(order.status),
                              onTap: () => context.push(
                                '${RouteNames.opsOrders}/${order.id}',
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SafeArea(
                    top: false,
                    child: _NewOrderCta(
                      label: l10n.newOrder,
                      onTap: () =>
                          context.push(RouteNames.opsOrderNew),
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

/// Compact tappable KPI driving the tab filter: icon bubble, label,
/// bold count, relative bar, selection ring.
class _TabKpi extends StatelessWidget {
  const _TabKpi({
    required this.label,
    required this.count,
    required this.tint,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final Color tint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppSpacing.motionFast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? tokens.primary.withValues(alpha: 0.08)
              : tokens.surfaceAlt,
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(
            color: selected ? tokens.primary : tokens.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tint,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$count',
                    style:
                        AppTypography.kpiNumber(tokens.ink).copyWith(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    label,
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: selected
                                  ? tokens.primary
                                  : tokens.inkMuted,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

/// Order row card: semibold title, muted route, bold rate + status chip.
class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    required this.statusLabel,
    required this.statusColor,
    required this.onTap,
  });

  final Order order;
  final String statusLabel;
  final Color statusColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: tokens.surface,
          borderRadius: AppSpacing.cardRadius,
          border: Border.all(color: tokens.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.no,
                    style:
                        Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                StatusChip(
                  label: statusLabel,
                  color: statusColor,
                ),
              ],
            ),
            Text(
              order.customerName,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: tokens.inkMuted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Icon(
                  Icons.route_outlined,
                  size: 14,
                  color: tokens.inkFaint,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    '${order.stops.isNotEmpty ? order.stops.first.address : ''} → '
                    '${order.stops.length > 1 ? order.stops.last.address : ''}',
                    style:
                        Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${order.vehicleType} · ${Formatters.inr(order.rate)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: tokens.primary),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sticky gradient CTA replacing the dated extended FAB.
class _NewOrderCta extends StatelessWidget {
  const _NewOrderCta({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
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
