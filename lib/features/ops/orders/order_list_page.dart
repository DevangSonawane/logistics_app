import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_search_bar.dart';
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
      OrderStatus.cancelled => AppColors.inkFaint,
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

    return AppScaffold(
      title: l10n.ordersTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () => context.push(RouteNames.search),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'new-order',
        onPressed: () => context.push(RouteNames.opsOrderNew),
        icon: const Icon(Icons.add),
        label: Text(l10n.newOrder),
      ),
      refresh: () async {
        ref.invalidate(ordersByStatusProvider(_tab));
      },
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final OrderStatus s in [
                  OrderStatus.pending,
                  OrderStatus.planned,
                  OrderStatus.running,
                  OrderStatus.completed,
                ])
                  Padding(
                    padding:
                        const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(tabLabel(s)),
                      selected: _tab == s,
                      onSelected: (_) => setState(() => _tab = s),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppSearchBar(
            controller: _search,
            hint: l10n.searchHint,
            onChanged: (v) =>
                setState(() => _query = v.toLowerCase()),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: orders.when(
              loading: () => const SkeletonList(),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () =>
                    ref.invalidate(ordersByStatusProvider(_tab)),
              ),
              data: (List<Order> items) {
                final List<Order> visible = items
                    .where(
                      (o) =>
                          o.no.toLowerCase().contains(_query) ||
                          o.customerName.toLowerCase().contains(_query),
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
                  separatorBuilder: (_, __) => const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  itemBuilder: (context, index) {
                    final Order order = visible[index];
                    return Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: context.tokens.surface,
                        borderRadius: AppSpacing.cardRadius,
                        border:
                            Border.all(color: context.tokens.border),
                      ),
                      child: InkWell(
                        onTap: () => context.push(
                          '${RouteNames.opsOrders}/${order.id}',
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${order.no} · ${order.customerName}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                  Text(
                                    '${order.stops.isNotEmpty ? order.stops.first.address : ''} → '
                                    '${order.stops.length > 1 ? order.stops.last.address : ''}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                  Text(
                                    '${order.vehicleType} · ${Formatters.inr(order.rate)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            StatusChip(
                              label: tabLabel(order.status),
                              color: _statusColor(order.status),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
