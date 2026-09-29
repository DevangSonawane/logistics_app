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
    final AppColorTokens tokens = context.tokens;
    final AsyncValue<List<Order>> orders =
        ref.watch(ordersByStatusProvider(OrderStatus.pending));
    final int count = orders.value?.length ?? 0;
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.planTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge,
                        ),
                        Text(
                          '$count ${l10n.orderPending.toLowerCase()}',
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
                  IconButton.filled(
                    onPressed: () => context.push('/ops/market'),
                    icon: const Icon(Icons.add),
                    tooltip: l10n.marketTitle,
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
                AppSpacing.lg,
              ),
              child: orders.when(
                loading: () => const SkeletonList(),
                error: (e, _) => ErrorState(
                  message: l10n.commonError,
                  onRetry: () => ref.invalidate(
                    ordersByStatusProvider(OrderStatus.pending),
                  ),
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
                    separatorBuilder: (_, _) => const SizedBox(
                      height: AppSpacing.sm,
                    ),
                    itemBuilder: (context, index) {
                      final Order order = items[index];
                      return GestureDetector(
                        onTap: () =>
                            context.push('/ops/plan/${order.id}'),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding:
                              const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: tokens.surface,
                            borderRadius: AppSpacing.cardRadius,
                            border: Border.all(
                              color: tokens.border,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: tokens.primary
                                      .withValues(alpha: 0.1),
                                ),
                                child: Icon(
                                  Icons.local_shipping_outlined,
                                  size: 20,
                                  color: tokens.primary,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
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
                                      maxLines: 1,
                                      overflow:
                                          TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${order.vehicleType} · ${Formatters.inr(order.rate)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: tokens.inkMuted,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: tokens.primary,
                                  borderRadius:
                                      AppSpacing.chipRadius,
                                ),
                                child: Text(
                                  l10n.planTripAction,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: tokens.onPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
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
          ),
        ],
      ),
    );
  }
}
