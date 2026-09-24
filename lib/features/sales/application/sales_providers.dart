import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/customer.dart';
import '../../../data/models/lead.dart';
import '../../../data/models/order.dart';
import '../../../data/repositories/repository_providers.dart';

part 'sales_providers.g.dart';

@riverpod
Future<List<Lead>> salesLeads(Ref ref) {
  return ref.watch(leadRepositoryProvider).leads();
}

@riverpod
Future<List<Visit>> plannedVisits(Ref ref) {
  return ref.watch(leadRepositoryProvider).visits();
}

@riverpod
Future<List<SalesTarget>> salesTargets(Ref ref) {
  return ref.watch(leadRepositoryProvider).targets();
}

@riverpod
Future<int?> laneRate(
  Ref ref,
  String from,
  String to,
  String vehicle,
) {
  return ref.watch(dashboardRepositoryProvider).contractRate(
        from,
        to,
        vehicle,
      );
}

@riverpod
Future<List<Customer>> salesCustomers(Ref ref) {
  return ref.watch(customerRepositoryProvider).list();
}

@riverpod
Future<List<Order>> customerOrders(Ref ref, String customerId) async {
  final List<Order> all = await ref.watch(orderRepositoryProvider).list();
  return all.where((o) => o.customerId == customerId).toList();
}
