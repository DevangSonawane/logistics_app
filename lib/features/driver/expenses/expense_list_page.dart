import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/error_state.dart';
import '../../../core/widgets/skeleton_list.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../data/models/expense.dart';
import '../application/driver_providers.dart';
import '../application/driver_trip_controller.dart';
import '../../auth/application/session_provider.dart';

/// D3 (list). Per-trip expenses with the running advance-balance chip.
class ExpenseListPage extends ConsumerWidget {
  const ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String? driverId = ref.watch(
      sessionProvider.select((s) => s.user?.id),
    );
    if (driverId == null) {
      return AppScaffold(body: ErrorState(message: l10n.commonError));
    }
    final AsyncValue<DriverTripState> tripState =
        ref.watch(driverTripProvider(driverId));
    return tripState.when(
      loading: () => AppScaffold(
        title: l10n.expensesTitle,
        body: const SkeletonList(),
      ),
      error: (e, _) => AppScaffold(
        title: l10n.expensesTitle,
        body: ErrorState(message: l10n.commonError),
      ),
      data: (DriverTripState data) {
        final trip = data.activeTrip;
        if (trip == null) {
          return AppScaffold(
            title: l10n.expensesTitle,
            body: EmptyState(
              title: l10n.noTripTitle,
              message: '',
              icon: Icons.receipt_outlined,
            ),
          );
        }
        final AsyncValue<List<Expense>> expenses =
            ref.watch(tripExpensesProvider(trip.id));
        final AsyncValue<int> balance =
            ref.watch(advanceBalanceProvider(driverId));
        return AppScaffold(
          title: l10n.expensesTitle,
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'add-expense',
            onPressed: () => context.push(
              RouteNames.driverAddExpense,
              extra: trip,
            ),
            icon: const Icon(Icons.add),
            label: Text(l10n.addExpenseAction),
          ),
          body: Column(
            children: [
              balance.when(
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
                data: (int value) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: AppSpacing.cardRadius,
                    border: Border.all(color: AppColors.accent),
                  ),
                  child: Text(
                    '${l10n.advanceBalance}: ${Formatters.inr(value)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: expenses.when(
                  loading: () => const SkeletonList(),
                  error: (e, _) => ErrorState(
                    message: l10n.commonError,
                    onRetry: () =>
                        ref.invalidate(tripExpensesProvider(trip.id)),
                  ),
                  data: (List<Expense> items) => items.isEmpty
                      ? EmptyState(
                          title: l10n.commonEmpty,
                          message: '',
                          icon: Icons.receipt_outlined,
                        )
                      : ListView.separated(
                          itemCount: items.length,
                          separatorBuilder: (_, _) => const SizedBox(
                            height: AppSpacing.sm,
                          ),
                          itemBuilder: (context, index) =>
                              _ExpenseTile(expense: items[index]),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  const _ExpenseTile({required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
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
                  _typeLabel(l10n, expense.type),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  Formatters.dateTime(expense.createdAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.tokens.inkMuted,
                      ),
                ),
                if (expense.normFlag)
                  Text(
                    l10n.aboveNorm,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.warning),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                Formatters.inr(expense.amount),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              StatusChip(
                label: _statusLabel(l10n, expense.status),
                color: expense.status == ExpenseStatus.approved
                    ? AppColors.success
                    : AppColors.warning,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _typeLabel(AppLocalizations l10n, ExpenseType type) {
    return switch (type) {
      ExpenseType.diesel => l10n.expenseDiesel,
      ExpenseType.toll => l10n.expenseToll,
      ExpenseType.repair => l10n.expenseRepair,
      ExpenseType.loading => l10n.expenseLoading,
      ExpenseType.police => l10n.expensePolice,
      ExpenseType.food => l10n.expenseFood,
      ExpenseType.other => l10n.expenseOther,
    };
  }

  String _statusLabel(AppLocalizations l10n, ExpenseStatus status) {
    return switch (status) {
      ExpenseStatus.queued => l10n.statusPending,
      ExpenseStatus.submitted => l10n.statusRequested,
      ExpenseStatus.approved => l10n.statusApproved,
      ExpenseStatus.rejected => l10n.statusRejected,
    };
  }
}
