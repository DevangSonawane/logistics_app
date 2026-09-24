/// Hive box names. Single source so bootstrap, stores and tests agree.
abstract final class HiveBoxes {
  static const String session = 'session';
  static const String cache = 'cache';
  static const String offlineQueue = 'offline_queue';
  static const String gpsTrack = 'gps_track';

  /// Keys inside the [session] box.
  static const String keySessionJson = 'session_json';
  static const String keyLocale = 'locale';
  static const String keyThemeMode = 'theme_mode';
  static const String keyOnboardingDone = 'onboarding_done';

  /// Keys inside the [cache] box.
  static const String keyDocuments = 'documents';

  /// Key holding the JSON list inside the [offlineQueue] box.
  static const String keyActions = 'actions';
}
