import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

/// In-app notification with a deep link (roadops://trip/{id} ...).
/// The notification centre page lands in Phase 6; badges + settings now.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String title,
    required String body,
    required String type,
    String? deeplink,
    @Default(false) bool read,
    required DateTime at,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
