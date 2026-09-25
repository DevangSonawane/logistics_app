import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/order.dart';
import '../application/ops_providers.dart';

/// Plan tab landing: pending orders with a direct Plan action.
class PlanLandingPage extends ConsumerWidget {
  const PlanLandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Order>> orders =
        ref.watch(ordersByStatusProvider(OrderStatus.pending));
    return AppScaffold(
      title: l10n.planTitle,
      body: Column(
        children: [
          OutlinedButton.icon(
            icon: const Icon(Icons.storefront_outlined),
            label: Text(l10n.marketTitle),
            onPressed: () => context.push('/ops/market'),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: orders.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () =>
              ref.invalidate(ordersByStatusProvider(OrderStatus.pending)),
        ),
        data: (List<Order> items) {
          if (items.isEmpty) {
            return EmptyState(
              title: l10n.commonEmpty,
              message: '',
              icon: Icons.route_outlined,
            );
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final Order order = items[index];
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
                          Text(
                            '${order.no} · ${order.customerName}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                          Text(
                            '${order.vehicleType} · ${Formatters.inr(order.rate)}',
                            style:
                                Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          context.push('/ops/plan/${order.id}'),
                      child: Text(l10n.planTripAction),
                    ),
                  ],
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
