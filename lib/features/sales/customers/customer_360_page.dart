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
        final AppColorTokens tokens = context.tokens;
        return AppScaffold(
          title: current.name,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
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
                child: Row(
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
                        current.name.isEmpty
                            ? '?'
                            : current.name[0].toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            current.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${l10n.outstandingLabel}: '
                            '${Formatters.inr(current.outstanding)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Colors.white.withValues(
                                    alpha: 0.9,
                                  ),
                                ),
                          ),
                          Text(
                            'GSTIN ${current.gstin} · ${current.creditDays} days',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.white.withValues(
                                    alpha: 0.75,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    for (int i = 0;
                        i < current.contacts.length;
                        i++) ...[
                      if (i > 0)
                        Divider(
                          height: AppSpacing.lg,
                          thickness: 1,
                          color: tokens.border,
                        ),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 18,
                            color: tokens.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              current.contacts[i].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ),
                          Text(
                            '+91 ${current.contacts[i].phone}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: tokens.inkMuted,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize:
                        const Size(0, AppSpacing.buttonHeightMd),
                  ),
                  icon: const Icon(
                    Icons.notifications_outlined,
                    size: 18,
                  ),
                  label: Text(l10n.remindPayment),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.reminderSent),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.ordersTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 15),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      o.no,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      o.vehicleType,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color:
                                                tokens.inkMuted,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                Formatters.inr(o.rate),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight:
                                          FontWeight.w700,
                                    ),
                              ),
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
          padding: EdgeInsets.zero,
          itemCount: list.length,
          separatorBuilder: (_, _) => const SizedBox(
            height: AppSpacing.sm,
          ),
          itemBuilder: (context, index) {
            final Customer c = list[index];
            final bool overLimit = c.outstanding > c.creditLimit;
            return AppCard(
              onTap: () => context.push('/sales/customers/${c.id}'),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.tokens.primary
                          .withValues(alpha: 0.1),
                    ),
                    child: Text(
                      c.name.isEmpty
                          ? '?'
                          : c.name[0].toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                            color: context.tokens.primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${l10n.outstandingLabel}: '
                          '${Formatters.inrShort(c.outstanding)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: overLimit
                                    ? AppColors.danger
                                    : context.tokens.inkMuted,
                                fontWeight: overLimit
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: context.tokens.inkFaint,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
