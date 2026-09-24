import '../../mock/mock_business_data.dart';
import '../../mock/mock_delay.dart';
import '../models/notification.dart';
import 'notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  MockNotificationRepository() {
    _items.addAll(MockBusinessData.notifications());
  }

  final List<AppNotification> _items = [];

  @override
  Future<List<AppNotification>> list() async {
    await mockDelay();
    final List<AppNotification> sorted = List.of(_items);
    sorted.sort((a, b) => b.at.compareTo(a.at));
    return sorted;
  }

  @override
  Future<int> unreadCount() async {
    await mockDelay();
    return _items.where((n) => !n.read).length;
  }

  @override
  Future<void> markRead(String id) async {
    await mockDelay();
    final int i = _items.indexWhere((n) => n.id == id);
    if (i >= 0) _items[i] = _items[i].copyWith(read: true);
  }

  @override
  Future<void> markAllRead() async {
    await mockDelay();
    for (int i = 0; i < _items.length; i++) {
      _items[i] = _items[i].copyWith(read: true);
    }
  }
}
