import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/order.dart';
import '../../../data/repositories/repository_providers.dart';

/// Order detail: parties, stops, cargo, rate, linked trip + Plan action.
class OrderDetailPage extends ConsumerWidget {
  const OrderDetailPage({super.key, required this.orderId});

  final String orderId;

  String _statusLabel(AppLocalizations l10n, OrderStatus status) {
    return switch (status) {
      OrderStatus.pending => l10n.orderPending,
      OrderStatus.planned => l10n.orderPlanned,
      OrderStatus.running => l10n.orderRunning,
      OrderStatus.completed => l10n.orderCompleted,
      OrderStatus.cancelled => l10n.orderCancelled,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return FutureBuilder<Order?>(
      future: ref.watch(orderRepositoryProvider).get(orderId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppScaffold(
            title: l10n.ordersTitle,
            body: const SkeletonList(),
          );
        }
        final Order? order = snapshot.data;
        if (order == null) {
          return AppScaffold(
            title: l10n.ordersTitle,
            body: ErrorState(message: l10n.commonError),
          );
        }
        return AppScaffold(
          title: order.no,
          body: ListView(
            children: [
              Row(
                children: [
                  StatusChip(
                    label: _statusLabel(l10n, order.status),
                    color: AppColors.info,
                  ),
                  const Spacer(),
                  Text(
                    Formatters.inr(order.rate),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _Row(
                label: l10n.customerLabel,
                value: order.customerName,
              ),
              _Row(
                label: l10n.orderTypeLabel,
                value: order.type == OrderType.ftl
                    ? l10n.orderTypeFtl
                    : l10n.orderTypePtl,
              ),
              _Row(label: l10n.vehicleTypeLabel, value: order.vehicleType),
              _Row(
                label: l10n.commodityLabel,
                value: order.commodity,
              ),
              _Row(
                label: l10n.weightLabel,
                value: '${order.weightKg} kg',
              ),
              const Divider(height: AppSpacing.xxl),
              Text(
                l10n.stopsLabel,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              for (final OrderStop stop in order.stops)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.place_outlined),
                  title: Text(stop.address),
                  subtitle: stop.windowStart == null
                      ? null
                      : Text(Formatters.dateTime(stop.windowStart!)),
                ),
              if (order.status == OrderStatus.pending) ...[
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: l10n.planTripAction,
                  variant: AppButtonVariant.accent,
                  large: true,
                  onPressed: () =>
                      context.push('/ops/plan/${order.id}'),
                ),
              ],
            ],
          ),
        );
      },
    );
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
