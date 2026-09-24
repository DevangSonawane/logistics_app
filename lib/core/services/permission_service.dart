import 'package:permission_handler/permission_handler.dart';

import '../config/app_config.dart';

/// Role-based permission request used by the permissions page (Phase 2).
enum AppPermissionRequest {
  notifications,
  camera,
  locationInUse,
  locationAlways,
  microphone,
  battery,
}

/// Demo builds simulate the grant so the auth flow never blocks on OS
/// dialogs. Real devices use permission_handler (hardened in Phase 8).
class PermissionService {
  const PermissionService();

  Future<bool> request(AppPermissionRequest which) async {
    if (AppConfig.demo) return true;
    try {
      return switch (which) {
        AppPermissionRequest.notifications =>
          (await Permission.notification.request()).isGranted,
        AppPermissionRequest.camera =>
          (await Permission.camera.request()).isGranted,
        AppPermissionRequest.locationInUse =>
          (await Permission.locationWhenInUse.request()).isGranted,
        AppPermissionRequest.locationAlways =>
          (await Permission.locationAlways.request()).isGranted,
        AppPermissionRequest.microphone =>
          (await Permission.microphone.request()).isGranted,
        AppPermissionRequest.battery => (await Permission
                .ignoreBatteryOptimizations
                .request())
            .isGranted,
      };
    } catch (_) {
      return false;
    }
  }
}
