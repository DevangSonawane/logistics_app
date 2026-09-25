import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/order.dart';
import '../application/sales_providers.dart';

/// S5. Customer 360 (read-only): overview, outstanding, orders, rates,
/// contacts, payment nudge.
class Customer360Page extends ConsumerWidget {
  const Customer360Page({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Customer>> customers =
        ref.watch(salesCustomersProvider);
    return customers.when(
      loading: () => AppScaffold(
        title: l10n.customersTitle,
        body: const SkeletonList(),
      ),
      error: (e, _) => AppScaffold(
        title: l10n.customersTitle,
        body: ErrorState(message: l10n.commonError),
      ),
      data: (List<Customer> list) {
        Customer? customer;
        for (final Customer c in list) {
          if (c.id == customerId) customer = c;
        }
        if (customer == null) {
          return AppScaffold(
            title: l10n.customersTitle,
            body: ErrorState(message: l10n.commonError),
          );
        }
        final Customer current = customer;
        final AsyncValue<List<Order>> orders =
            ref.watch(customerOrdersProvider(customerId));
        return AppScaffold(
          title: current.name,
          body: ListView(
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${l10n.outstandingLabel}: '
                      '${Formatters.inr(current.outstanding)}',
                      style:
                          Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'GSTIN ${current.gstin} · ${current.creditDays} days',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final contact in current.contacts)
                      Text(
                        '${contact.name} · +91 ${contact.phone}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                icon: const Icon(Icons.notifications_outlined),
                label: Text(l10n.remindPayment),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.reminderSent)),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.ordersTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              orders.when(
                loading: () => const SkeletonList(itemCount: 2),
                error: (e, _) => ErrorState(
                  message: l10n.commonError,
                ),
                data: (List<Order> items) => Column(
                  children: [
                    for (final Order o in items)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.sm,
                        ),
                        child: AppCard(
                          padding:
                              const EdgeInsets.all(AppSpacing.md),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${o.no} · ${o.vehicleType}',
                                ),
                              ),
                              Text(Formatters.inr(o.rate)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Read-only customer list entry point for the Customers tab.
class CustomerListPage extends ConsumerWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Customer>> customers =
        ref.watch(salesCustomersProvider);
    return AppScaffold(
      title: l10n.customersTitle,
      body: customers.when(
        loading: () => const SkeletonList(),
        error: (e, _) => ErrorState(
          message: l10n.commonError,
          onRetry: () => ref.invalidate(salesCustomersProvider),
        ),
        data: (List<Customer> list) => ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, _) => const SizedBox(
            height: AppSpacing.sm,
          ),
          itemBuilder: (context, index) {
            final Customer c = list[index];
            return AppCard(
              onTap: () => context.push('/sales/customers/${c.id}'),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                        Text(
                          '${l10n.outstandingLabel}: '
                          '${Formatters.inrShort(c.outstanding)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: c.outstanding >
                                        c.creditLimit
                                    ? AppColors.danger
                                    : context.tokens.inkMuted,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_outlined),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
