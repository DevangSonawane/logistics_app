import '../models/order.dart';

/// Order store: ops list/create/plan.
abstract class OrderRepository {
  Future<List<Order>> list([OrderStatus? status]);
  Future<Order?> get(String id);
  Future<Order> create(Order order);
  Future<Order> markPlanned(String orderId, String tripId);
}
