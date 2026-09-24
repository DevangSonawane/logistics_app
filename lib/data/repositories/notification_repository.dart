import '../models/notification.dart';

/// Notifications: badge counts now, centre page in Phase 6.
abstract class NotificationRepository {
  Future<List<AppNotification>> list();
  Future<int> unreadCount();
  Future<void> markRead(String id);
  Future<void> markAllRead();
}
