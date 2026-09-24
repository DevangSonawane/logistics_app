/// App-wide numeric constants. Widgets must reference these (or theme
/// tokens) instead of inventing their own numbers.
class AppConstants {
  const AppConstants._();

  // OTP
  static const int otpLength = 6;
  static const int otpResendSeconds = 30;
  static const int otpMaxAttempts = 5;
  static const int otpLockoutMinutes = 5;

  // Splash
  static const Duration splashDuration = Duration(milliseconds: 1200);

  // Driver GPS (background_gps_service, Phase 3)
  static const int gpsIntervalSeconds = 60;
  static const int gpsLowBatteryIntervalSeconds = 180;
  static const int gpsCriticalBatteryIntervalSeconds = 300;
  static const int lowBatteryPercent = 20;
  static const int criticalBatteryPercent = 10;
  static const double maxGpsAccuracyMeters = 100;

  // Images queued for upload
  static const int imageMaxEdge = 1280;
  static const int imageJpegQuality = 70;
  static const int maxActionAttachmentMb = 10;

  // Offline sync engine
  static const int syncPollSeconds = 60;
  static const int syncMaxRetries = 8;

  // Staff session security
  static const int staffLockAfterMinutes = 2;
  static const int accountantIdleTimeoutMinutes = 5;
  static const int appPinLength = 4;
}
