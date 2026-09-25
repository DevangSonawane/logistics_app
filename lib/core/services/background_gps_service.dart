import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_gps_service.g.dart';

@Riverpod(keepAlive: true)
BackgroundGpsService backgroundGpsService(Ref ref) => BackgroundGpsService();

/// Entry-point for the background isolate. Point logging itself runs
/// main-isolate (gps_controller); the handler keeps the persistent
/// notification fresh.
/// TODO(Phase 8): harden isolate-side logging + iOS background tracking.
@pragma('vm:entry-point')
void gpsTaskHandler() {
  FlutterForegroundTask.setTaskHandler(_GpsTaskHandler());
}

class _GpsTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {}
}

/// Driver GPS foreground service. Started only while a trip is Started,
/// stopped on Unloaded/Delivered, with a persistent notification.
///
/// Every call is timeout-guarded: service binding must never block UI
/// flows (and never hang tests without a platform implementation).
class BackgroundGpsService {
  static const Duration _timeout = Duration(seconds: 3);

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    try {
      FlutterForegroundTask.init(
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'roadops_trip',
          channelName: 'Trip in progress',
          channelDescription:
              'Keeps trip tracking running while you drive.',
          channelImportance: NotificationChannelImportance.LOW,
          priority: NotificationPriority.LOW,
        ),
        iosNotificationOptions: const IOSNotificationOptions(
          showNotification: true,
          playSound: false,
        ),
        foregroundTaskOptions: ForegroundTaskOptions(
          eventAction: ForegroundTaskEventAction.repeat(60000),
          autoRunOnBoot: false,
          allowWakeLock: true,
          allowWifiLock: true,
        ),
      );
      _initialized = true;
    } catch (_) {}
  }

  Future<void> start(String tripNo) async {
    try {
      await _ensureInitialized();
      if (await FlutterForegroundTask.isRunningService
          .timeout(_timeout)) {
        await update(tripNo);
        return;
      }
      await FlutterForegroundTask.startService(
        notificationTitle: 'RoadOps: Trip in progress',
        notificationText: tripNo,
        callback: gpsTaskHandler,
      ).timeout(_timeout);
    } catch (_) {}
  }

  Future<void> update(String tripNo) async {
    try {
      if (!await FlutterForegroundTask.isRunningService
          .timeout(_timeout)) {
        return;
      }
      await FlutterForegroundTask.updateService(
        notificationTitle: 'RoadOps: Trip in progress',
        notificationText: tripNo,
      ).timeout(_timeout);
    } catch (_) {}
  }

  Future<void> stop() async {
    try {
      await FlutterForegroundTask.stopService().timeout(_timeout);
    } catch (_) {}
  }
}
