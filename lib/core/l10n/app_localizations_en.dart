// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'RoadOps';

  @override
  String get splashTagline => 'Your logistics companion';

  @override
  String get languageTitle => 'Choose your language';

  @override
  String get languageSubtitle => 'You can change this later in Settings';

  @override
  String get continueAction => 'Continue';

  @override
  String get langEnglish => 'English';

  @override
  String get langHindi => 'Hindi';

  @override
  String get langMarathi => 'Marathi';

  @override
  String get langTamil => 'Tamil';

  @override
  String get langTelugu => 'Telugu';

  @override
  String get langKannada => 'Kannada';

  @override
  String get langBengali => 'Bengali';

  @override
  String get langPunjabi => 'Punjabi';

  @override
  String get loginTitle => 'Log in with your phone number';

  @override
  String get loginSubtitle =>
      'Users are created by your admin. No sign-up needed.';

  @override
  String get phoneLabel => 'Mobile number';

  @override
  String get phoneHint => '10-digit number';

  @override
  String get phoneError => 'Enter a valid 10-digit mobile number';

  @override
  String get getOtp => 'Get OTP';

  @override
  String get demoAccounts => 'Demo accounts';

  @override
  String get demoAccountsHint => 'Tap a role to autofill the demo number';

  @override
  String get invalidPhone =>
      'This number is not registered. Contact your admin.';

  @override
  String get blockedAccount =>
      'Your account is not active. Contact your admin.';

  @override
  String otpTitle(String phone) {
    return 'Enter OTP sent to +91 $phone';
  }

  @override
  String get otpSubtitle => '6-digit code. It expires in a few minutes.';

  @override
  String get otpError => 'Wrong OTP, please try again';

  @override
  String get otpExpired => 'This OTP has expired. Request a new one.';

  @override
  String get otpResend => 'Resend OTP';

  @override
  String otpResendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String otpAttemptsLeft(int count) {
    return '$count attempts left';
  }

  @override
  String get verifyAction => 'Verify';

  @override
  String get roleDriver => 'Driver';

  @override
  String get roleOwner => 'Owner';

  @override
  String get roleOps => 'Ops';

  @override
  String get roleSales => 'Sales';

  @override
  String get roleSupervisor => 'Supervisor';

  @override
  String get roleAccountant => 'Accountant';

  @override
  String get rolePickerTitle => 'Choose your role';

  @override
  String get rolePickerSubtitle =>
      'You have more than one role. Pick where to go today.';

  @override
  String get permissionsTitle => 'We need a few permissions';

  @override
  String get permissionsSubtitle =>
      'Each one helps RoadOps do its job for your role.';

  @override
  String get permissionAllow => 'Allow';

  @override
  String get permissionDeny => 'Deny';

  @override
  String get permNotificationsTitle => 'Notifications';

  @override
  String get permNotificationsWhy =>
      'To alert you about trips, approvals and payments.';

  @override
  String get permCameraTitle => 'Camera';

  @override
  String get permCameraWhy =>
      'To capture POD, bills, loading photos and scans.';

  @override
  String get permLocationTitle => 'Location';

  @override
  String get permLocationWhy =>
      'To show navigation and record trip checkpoints.';

  @override
  String get permLocationAlwaysTitle => 'Background location';

  @override
  String get permLocationAlwaysWhy =>
      'To track your trip even when the app is closed.';

  @override
  String get permBatteryTitle => 'Battery optimisation';

  @override
  String get permBatteryWhy => 'So trip tracking keeps running on long routes.';

  @override
  String get permMicrophoneTitle => 'Microphone';

  @override
  String get permMicrophoneWhy => 'For voice commands and voice notes.';

  @override
  String get locationDisclosure =>
      'RoadOps collects location data to track your trip even when the app is closed or not in use.';

  @override
  String get acceptAction => 'Accept';

  @override
  String get denyAction => 'Deny';

  @override
  String get rejectAction => 'Reject';

  @override
  String get navigateAction => 'Navigate';

  @override
  String get biometricTitle => 'Lock your app';

  @override
  String get biometricSubtitle =>
      'Use fingerprint or face unlock, or a 4-digit PIN.';

  @override
  String get biometricEnable => 'Enable';

  @override
  String get biometricSkip => 'Use PIN instead';

  @override
  String get lockTitle => 'Welcome back';

  @override
  String get lockSubtitle => 'Unlock to continue';

  @override
  String get useDemoPin => 'Use demo PIN 1234';

  @override
  String get logoutTitle => 'Log out?';

  @override
  String get logoutMessage => 'You will need an OTP to log back in.';

  @override
  String get logoutAction => 'Log out';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get retryAction => 'Retry';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonEmpty => 'Nothing here yet';

  @override
  String get commonError => 'Something went wrong';

  @override
  String get offlineMessage =>
      'You are offline. Updates will sync automatically.';

  @override
  String pendingSync(int count) {
    return '$count items waiting to sync';
  }

  @override
  String get syncNow => 'Sync now';

  @override
  String get viewQueue => 'View queue';

  @override
  String get forbiddenTitle => 'Not allowed';

  @override
  String get forbiddenMessage => 'Your role cannot open this screen.';

  @override
  String get goBackAction => 'Go back';

  @override
  String phaseComingSoon(String phase) {
    return 'Coming in $phase';
  }

  @override
  String greeting(String name) {
    return 'Namaste, $name';
  }
}
