import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/customer.dart';
import '../../../data/models/dashboard.dart';
import '../../../data/models/finance.dart';
import '../../../data/models/invoice.dart';
import '../../../data/repositories/repository_providers.dart';

part 'accountant_providers.g.dart';

@riverpod
Future<DashboardKpis> accountKpis(Ref ref) {
  return ref.watch(dashboardRepositoryProvider).kpis('all');
}

@riverpod
Future<GstSummary> accountGst(Ref ref) {
  return ref.watch(financeRepositoryProvider).gstSummary();
}

@riverpod
Future<List<Invoice>> invoices(Ref ref) {
  return ref.watch(invoiceRepositoryProvider).list();
}

@riverpod
Future<List<Customer>> accountCustomers(Ref ref) {
  return ref.watch(customerRepositoryProvider).list();
}

/// Overdue customers sorted by outstanding (reminder priority).
@riverpod
Future<List<Customer>> overdueCustomers(Ref ref) async {
  final List<Customer> customers =
      await ref.watch(accountCustomersProvider.future);
  final List<Customer> sorted = List.of(customers);
  sorted.sort((a, b) => b.outstanding.compareTo(a.outstanding));
  return sorted.where((c) => c.outstanding > 0).toList();
}
