import 'package:uuid/uuid.dart';

import '../mock/mock_business_data.dart';
import '../mock/mock_delay.dart';
import '../models/order.dart';
import 'order_repository.dart';

class MockOrderRepository implements OrderRepository {
  MockOrderRepository() {
    _orders.addAll(MockBusinessData.orders());
  }

  final List<Order> _orders = [];
  final Uuid _uuid = const Uuid();

  @override
  Future<List<Order>> list([OrderStatus? status]) async {
    await mockDelay();
    throwIfChaos();
    if (status == null) return List.unmodifiable(_orders);
    return List.unmodifiable(_orders.where((o) => o.status == status));
  }

  @override
  Future<Order?> get(String id) async {
    await mockDelay();
    for (final Order o in _orders) {
      if (o.id == id) return o;
    }
    return null;
  }

  @override
  Future<Order> create(Order order) async {
    await mockDelay();
    throwIfChaos();
    final Order saved = order.copyWith(
      id: 'ord-${_uuid.v4().substring(0, 6)}',
      no: 'ORD-${1060 + _orders.length}',
    );
    _orders.insert(0, saved);
    return saved;
  }

  @override
  Future<Order> markPlanned(String orderId, String tripId) async {
    await mockDelay();
    final int i = _orders.indexWhere((o) => o.id == orderId);
    if (i < 0) throw const MockApiException('Order not found');
    final Order updated = _orders[i].copyWith(
      status: OrderStatus.planned,
      tripId: tripId,
    );
    _orders[i] = updated;
    return updated;
  }
}
