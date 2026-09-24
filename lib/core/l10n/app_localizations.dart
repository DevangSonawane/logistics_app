import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
    Locale('mr'),
    Locale('pa'),
    Locale('ta'),
    Locale('te')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'RoadOps'**
  String get appName;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Your logistics companion'**
  String get splashTagline;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get languageTitle;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change this later in Settings'**
  String get languageSubtitle;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @langEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @langHindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get langHindi;

  /// No description provided for @langMarathi.
  ///
  /// In en, this message translates to:
  /// **'Marathi'**
  String get langMarathi;

  /// No description provided for @langTamil.
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get langTamil;

  /// No description provided for @langTelugu.
  ///
  /// In en, this message translates to:
  /// **'Telugu'**
  String get langTelugu;

  /// No description provided for @langKannada.
  ///
  /// In en, this message translates to:
  /// **'Kannada'**
  String get langKannada;

  /// No description provided for @langBengali.
  ///
  /// In en, this message translates to:
  /// **'Bengali'**
  String get langBengali;

  /// No description provided for @langPunjabi.
  ///
  /// In en, this message translates to:
  /// **'Punjabi'**
  String get langPunjabi;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in with your phone number'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Users are created by your admin. No sign-up needed.'**
  String get loginSubtitle;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get phoneLabel;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'10-digit number'**
  String get phoneHint;

  /// No description provided for @phoneError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 10-digit mobile number'**
  String get phoneError;

  /// No description provided for @getOtp.
  ///
  /// In en, this message translates to:
  /// **'Get OTP'**
  String get getOtp;

  /// No description provided for @demoAccounts.
  ///
  /// In en, this message translates to:
  /// **'Demo accounts'**
  String get demoAccounts;

  /// No description provided for @demoAccountsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a role to autofill the demo number'**
  String get demoAccountsHint;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'This number is not registered. Contact your admin.'**
  String get invalidPhone;

  /// No description provided for @blockedAccount.
  ///
  /// In en, this message translates to:
  /// **'Your account is not active. Contact your admin.'**
  String get blockedAccount;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP sent to +91 {phone}'**
  String otpTitle(String phone);

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'6-digit code. It expires in a few minutes.'**
  String get otpSubtitle;

  /// No description provided for @otpError.
  ///
  /// In en, this message translates to:
  /// **'Wrong OTP, please try again'**
  String get otpError;

  /// No description provided for @otpExpired.
  ///
  /// In en, this message translates to:
  /// **'This OTP has expired. Request a new one.'**
  String get otpExpired;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get otpResend;

  /// No description provided for @otpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String otpResendIn(int seconds);

  /// No description provided for @otpAttemptsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} attempts left'**
  String otpAttemptsLeft(int count);

  /// No description provided for @verifyAction.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyAction;

  /// No description provided for @roleDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get roleDriver;

  /// No description provided for @roleOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get roleOwner;

  /// No description provided for @roleOps.
  ///
  /// In en, this message translates to:
  /// **'Ops'**
  String get roleOps;

  /// No description provided for @roleSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get roleSales;

  /// No description provided for @roleSupervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get roleSupervisor;

  /// No description provided for @roleAccountant.
  ///
  /// In en, this message translates to:
  /// **'Accountant'**
  String get roleAccountant;

  /// No description provided for @rolePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your role'**
  String get rolePickerTitle;

  /// No description provided for @rolePickerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You have more than one role. Pick where to go today.'**
  String get rolePickerSubtitle;

  /// No description provided for @permissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'We need a few permissions'**
  String get permissionsTitle;

  /// No description provided for @permissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Each one helps RoadOps do its job for your role.'**
  String get permissionsSubtitle;

  /// No description provided for @permissionAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get permissionAllow;

  /// No description provided for @permissionDeny.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get permissionDeny;

  /// No description provided for @permNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permNotificationsTitle;

  /// No description provided for @permNotificationsWhy.
  ///
  /// In en, this message translates to:
  /// **'To alert you about trips, approvals and payments.'**
  String get permNotificationsWhy;

  /// No description provided for @permCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get permCameraTitle;

  /// No description provided for @permCameraWhy.
  ///
  /// In en, this message translates to:
  /// **'To capture POD, bills, loading photos and scans.'**
  String get permCameraWhy;

  /// No description provided for @permLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get permLocationTitle;

  /// No description provided for @permLocationWhy.
  ///
  /// In en, this message translates to:
  /// **'To show navigation and record trip checkpoints.'**
  String get permLocationWhy;

  /// No description provided for @permLocationAlwaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Background location'**
  String get permLocationAlwaysTitle;

  /// No description provided for @permLocationAlwaysWhy.
  ///
  /// In en, this message translates to:
  /// **'To track your trip even when the app is closed.'**
  String get permLocationAlwaysWhy;

  /// No description provided for @permBatteryTitle.
  ///
  /// In en, this message translates to:
  /// **'Battery optimisation'**
  String get permBatteryTitle;

  /// No description provided for @permBatteryWhy.
  ///
  /// In en, this message translates to:
  /// **'So trip tracking keeps running on long routes.'**
  String get permBatteryWhy;

  /// No description provided for @permMicrophoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Microphone'**
  String get permMicrophoneTitle;

  /// No description provided for @permMicrophoneWhy.
  ///
  /// In en, this message translates to:
  /// **'For voice commands and voice notes.'**
  String get permMicrophoneWhy;

  /// No description provided for @locationDisclosure.
  ///
  /// In en, this message translates to:
  /// **'RoadOps collects location data to track your trip even when the app is closed or not in use.'**
  String get locationDisclosure;

  /// No description provided for @acceptAction.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptAction;

  /// No description provided for @denyAction.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get denyAction;

  /// No description provided for @rejectAction.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectAction;

  /// No description provided for @navigateAction.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigateAction;

  /// No description provided for @biometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock your app'**
  String get biometricTitle;

  /// No description provided for @biometricSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint or face unlock, or a 4-digit PIN.'**
  String get biometricSubtitle;

  /// No description provided for @biometricEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get biometricEnable;

  /// No description provided for @biometricSkip.
  ///
  /// In en, this message translates to:
  /// **'Use PIN instead'**
  String get biometricSkip;

  /// No description provided for @lockTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get lockTitle;

  /// No description provided for @lockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock to continue'**
  String get lockSubtitle;

  /// No description provided for @useDemoPin.
  ///
  /// In en, this message translates to:
  /// **'Use demo PIN 1234'**
  String get useDemoPin;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutTitle;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'You will need an OTP to log back in.'**
  String get logoutMessage;

  /// No description provided for @logoutAction.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @retryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryAction;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get commonLoading;

  /// No description provided for @commonEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get commonEmpty;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonError;

  /// No description provided for @offlineMessage.
  ///
  /// In en, this message translates to:
  /// **'You are offline. Updates will sync automatically.'**
  String get offlineMessage;

  /// No description provided for @pendingSync.
  ///
  /// In en, this message translates to:
  /// **'{count} items waiting to sync'**
  String pendingSync(int count);

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync now'**
  String get syncNow;

  /// No description provided for @viewQueue.
  ///
  /// In en, this message translates to:
  /// **'View queue'**
  String get viewQueue;

  /// No description provided for @forbiddenTitle.
  ///
  /// In en, this message translates to:
  /// **'Not allowed'**
  String get forbiddenTitle;

  /// No description provided for @forbiddenMessage.
  ///
  /// In en, this message translates to:
  /// **'Your role cannot open this screen.'**
  String get forbiddenMessage;

  /// No description provided for @goBackAction.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBackAction;

  /// No description provided for @otpBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get otpBackToLogin;

  /// No description provided for @otpLockout.
  ///
  /// In en, this message translates to:
  /// **'Too many wrong attempts. Try again after {minutes} min'**
  String otpLockout(int minutes);

  /// No description provided for @permissionNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get permissionNext;

  /// No description provided for @permissionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get permissionDone;

  /// No description provided for @appPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a 4-digit app PIN'**
  String get appPinTitle;

  /// No description provided for @appPinConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get appPinConfirmTitle;

  /// No description provided for @appPinMismatch.
  ///
  /// In en, this message translates to:
  /// **'PINs don\'t match. Try again.'**
  String get appPinMismatch;

  /// No description provided for @pinHint.
  ///
  /// In en, this message translates to:
  /// **'4-digit PIN'**
  String get pinHint;

  /// No description provided for @biometricSetupHint.
  ///
  /// In en, this message translates to:
  /// **'Staff only. Drivers skip this step.'**
  String get biometricSetupHint;

  /// No description provided for @biometricEnrolled.
  ///
  /// In en, this message translates to:
  /// **'Biometrics enabled'**
  String get biometricEnrolled;

  /// No description provided for @unlockAction.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlockAction;

  /// No description provided for @wrongPin.
  ///
  /// In en, this message translates to:
  /// **'Wrong PIN, try again'**
  String get wrongPin;

  /// No description provided for @unlockWithBio.
  ///
  /// In en, this message translates to:
  /// **'Use fingerprint / face'**
  String get unlockWithBio;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @switchRole.
  ///
  /// In en, this message translates to:
  /// **'Switch role'**
  String get switchRole;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App version {version}'**
  String appVersion(String version);

  /// No description provided for @demoTools.
  ///
  /// In en, this message translates to:
  /// **'Demo tools'**
  String get demoTools;

  /// No description provided for @demoSampleNotification.
  ///
  /// In en, this message translates to:
  /// **'Trigger sample notification'**
  String get demoSampleNotification;

  /// No description provided for @demoAdvanceTrip.
  ///
  /// In en, this message translates to:
  /// **'Advance trip simulation'**
  String get demoAdvanceTrip;

  /// No description provided for @simulateOffline.
  ///
  /// In en, this message translates to:
  /// **'Simulate offline'**
  String get simulateOffline;

  /// No description provided for @resetDemoData.
  ///
  /// In en, this message translates to:
  /// **'Reset demo data'**
  String get resetDemoData;

  /// No description provided for @demoActionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get demoActionDone;

  /// No description provided for @logoutRunningTrip.
  ///
  /// In en, this message translates to:
  /// **'You have a running trip. Please complete it or ask Ops to close it before logging out.'**
  String get logoutRunningTrip;

  /// No description provided for @logoutPendingSync.
  ///
  /// In en, this message translates to:
  /// **'{count} items are not uploaded yet. Connect to the internet and sync before logging out.'**
  String logoutPendingSync(int count);

  /// No description provided for @forceLogout.
  ///
  /// In en, this message translates to:
  /// **'Force logout (demo)'**
  String get forceLogout;

  /// No description provided for @roleContinueAs.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get roleContinueAs;

  /// No description provided for @lastUsedRole.
  ///
  /// In en, this message translates to:
  /// **'Last used'**
  String get lastUsedRole;

  /// No description provided for @tabMyTrip.
  ///
  /// In en, this message translates to:
  /// **'My Trip'**
  String get tabMyTrip;

  /// No description provided for @tabEarnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get tabEarnings;

  /// No description provided for @tabDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get tabDocuments;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @noTripTitle.
  ///
  /// In en, this message translates to:
  /// **'No trip right now. We\'ll notify you.'**
  String get noTripTitle;

  /// No description provided for @offerTitle.
  ///
  /// In en, this message translates to:
  /// **'New trip offer'**
  String get offerTitle;

  /// No description provided for @pickupLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickupLabel;

  /// No description provided for @dropLabel.
  ///
  /// In en, this message translates to:
  /// **'Drop'**
  String get dropLabel;

  /// No description provided for @freightLabel.
  ///
  /// In en, this message translates to:
  /// **'Freight allowance'**
  String get freightLabel;

  /// No description provided for @pickupByLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup by'**
  String get pickupByLabel;

  /// No description provided for @rejectTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject trip'**
  String get rejectTitle;

  /// No description provided for @rejectReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason (required)'**
  String get rejectReasonLabel;

  /// No description provided for @rejectVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle issue'**
  String get rejectVehicle;

  /// No description provided for @rejectHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get rejectHealth;

  /// No description provided for @rejectPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get rejectPersonal;

  /// No description provided for @rejectRoute.
  ///
  /// In en, this message translates to:
  /// **'Route not known'**
  String get rejectRoute;

  /// No description provided for @rejectOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get rejectOther;

  /// No description provided for @rejectNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Details (optional)'**
  String get rejectNoteHint;

  /// No description provided for @submitAction.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitAction;

  /// No description provided for @lrEwayLabel.
  ///
  /// In en, this message translates to:
  /// **'LR / E-way bill'**
  String get lrEwayLabel;

  /// No description provided for @addExpenseAction.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpenseAction;

  /// No description provided for @requestAdvanceAction.
  ///
  /// In en, this message translates to:
  /// **'Request Advance'**
  String get requestAdvanceAction;

  /// No description provided for @stepReachedPickup.
  ///
  /// In en, this message translates to:
  /// **'Reached Pickup'**
  String get stepReachedPickup;

  /// No description provided for @stepLoadingDone.
  ///
  /// In en, this message translates to:
  /// **'Loading Done'**
  String get stepLoadingDone;

  /// No description provided for @stepStartTrip.
  ///
  /// In en, this message translates to:
  /// **'Start Trip'**
  String get stepStartTrip;

  /// No description provided for @stepReachedDrop.
  ///
  /// In en, this message translates to:
  /// **'Reached Drop'**
  String get stepReachedDrop;

  /// No description provided for @stepUnloaded.
  ///
  /// In en, this message translates to:
  /// **'Unloaded'**
  String get stepUnloaded;

  /// No description provided for @slideHint.
  ///
  /// In en, this message translates to:
  /// **'Slide to confirm'**
  String get slideHint;

  /// No description provided for @photoRequired.
  ///
  /// In en, this message translates to:
  /// **'A photo is required for this step'**
  String get photoRequired;

  /// No description provided for @stepDone.
  ///
  /// In en, this message translates to:
  /// **'Status updated'**
  String get stepDone;

  /// No description provided for @stepQueued.
  ///
  /// In en, this message translates to:
  /// **'Offline - will sync automatically'**
  String get stepQueued;

  /// No description provided for @conflictTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip changed'**
  String get conflictTitle;

  /// No description provided for @conflictMessage.
  ///
  /// In en, this message translates to:
  /// **'Ops changed this trip. Your action was rejected and the trip was refreshed.'**
  String get conflictMessage;

  /// No description provided for @okAction.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okAction;

  /// No description provided for @timelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timelineTitle;

  /// No description provided for @podPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip unloaded - capture POD'**
  String get podPromptTitle;

  /// No description provided for @podPromptAction.
  ///
  /// In en, this message translates to:
  /// **'Capture POD'**
  String get podPromptAction;

  /// No description provided for @callOps.
  ///
  /// In en, this message translates to:
  /// **'Call Ops'**
  String get callOps;

  /// No description provided for @opsAlerted.
  ///
  /// In en, this message translates to:
  /// **'Ops has been alerted'**
  String get opsAlerted;

  /// No description provided for @trackingOn.
  ///
  /// In en, this message translates to:
  /// **'GPS tracking on'**
  String get trackingOn;

  /// No description provided for @advanceBalance.
  ///
  /// In en, this message translates to:
  /// **'Advance balance'**
  String get advanceBalance;

  /// No description provided for @podTitle.
  ///
  /// In en, this message translates to:
  /// **'Proof of Delivery'**
  String get podTitle;

  /// No description provided for @podStep1.
  ///
  /// In en, this message translates to:
  /// **'Photo of the signed LR'**
  String get podStep1;

  /// No description provided for @podStep2.
  ///
  /// In en, this message translates to:
  /// **'Consignee confirmation'**
  String get podStep2;

  /// No description provided for @podOtpHint.
  ///
  /// In en, this message translates to:
  /// **'4-digit OTP with consignee'**
  String get podOtpHint;

  /// No description provided for @podOtpWrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong consignee OTP'**
  String get podOtpWrong;

  /// No description provided for @podOr.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get podOr;

  /// No description provided for @podSignHint.
  ///
  /// In en, this message translates to:
  /// **'Consignee e-signature'**
  String get podSignHint;

  /// No description provided for @podNameHint.
  ///
  /// In en, this message translates to:
  /// **'Consignee name'**
  String get podNameHint;

  /// No description provided for @podDamageToggle.
  ///
  /// In en, this message translates to:
  /// **'Any damage or shortage?'**
  String get podDamageToggle;

  /// No description provided for @podDamageRemark.
  ///
  /// In en, this message translates to:
  /// **'Remark'**
  String get podDamageRemark;

  /// No description provided for @podDamageQty.
  ///
  /// In en, this message translates to:
  /// **'Quantity affected'**
  String get podDamageQty;

  /// No description provided for @podSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit POD'**
  String get podSubmit;

  /// No description provided for @podDone.
  ///
  /// In en, this message translates to:
  /// **'POD submitted'**
  String get podDone;

  /// No description provided for @earningsPreview.
  ///
  /// In en, this message translates to:
  /// **'Earnings preview'**
  String get earningsPreview;

  /// No description provided for @demoOtpHint.
  ///
  /// In en, this message translates to:
  /// **'Demo consignee OTP: 4321'**
  String get demoOtpHint;

  /// No description provided for @expenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get expenseTitle;

  /// No description provided for @expenseDiesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get expenseDiesel;

  /// No description provided for @expenseToll.
  ///
  /// In en, this message translates to:
  /// **'Toll'**
  String get expenseToll;

  /// No description provided for @expenseRepair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get expenseRepair;

  /// No description provided for @expenseLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get expenseLoading;

  /// No description provided for @expensePolice.
  ///
  /// In en, this message translates to:
  /// **'Police/RTO'**
  String get expensePolice;

  /// No description provided for @expenseFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get expenseFood;

  /// No description provided for @expenseOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get expenseOther;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @litresLabel.
  ///
  /// In en, this message translates to:
  /// **'Litres'**
  String get litresLabel;

  /// No description provided for @rateLabel.
  ///
  /// In en, this message translates to:
  /// **'Rate (Rs.)'**
  String get rateLabel;

  /// No description provided for @billPhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Bill photo'**
  String get billPhotoLabel;

  /// No description provided for @photoCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get photoCamera;

  /// No description provided for @photoGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get photoGallery;

  /// No description provided for @billRequired.
  ///
  /// In en, this message translates to:
  /// **'Bill photo is required above Rs.100'**
  String get billRequired;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteHint;

  /// No description provided for @voiceNoteAction.
  ///
  /// In en, this message translates to:
  /// **'Voice note'**
  String get voiceNoteAction;

  /// No description provided for @voiceConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Record a voice note?'**
  String get voiceConsentTitle;

  /// No description provided for @voiceConsentMessage.
  ///
  /// In en, this message translates to:
  /// **'Voice notes are stored with the expense and uploaded on sync.'**
  String get voiceConsentMessage;

  /// No description provided for @agreeAction.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agreeAction;

  /// No description provided for @aboveNorm.
  ///
  /// In en, this message translates to:
  /// **'Above usual for this route. Ops may review.'**
  String get aboveNorm;

  /// No description provided for @saveAction.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveAction;

  /// No description provided for @expenseSaved.
  ///
  /// In en, this message translates to:
  /// **'Expense saved'**
  String get expenseSaved;

  /// No description provided for @expensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesTitle;

  /// No description provided for @advancesTitle.
  ///
  /// In en, this message translates to:
  /// **'Advances'**
  String get advancesTitle;

  /// No description provided for @requestAdvanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Request Advance'**
  String get requestAdvanceTitle;

  /// No description provided for @purposeLabel.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purposeLabel;

  /// No description provided for @purposeFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get purposeFuel;

  /// No description provided for @purposeToll.
  ///
  /// In en, this message translates to:
  /// **'Toll'**
  String get purposeToll;

  /// No description provided for @purposeRepair.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get purposeRepair;

  /// No description provided for @purposeFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get purposeFood;

  /// No description provided for @purposeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get purposeOther;

  /// No description provided for @requestAction.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get requestAction;

  /// No description provided for @advanceRequested.
  ///
  /// In en, this message translates to:
  /// **'Advance requested'**
  String get advanceRequested;

  /// No description provided for @statusRequested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get statusRequested;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @earningsTitle.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earningsTitle;

  /// No description provided for @monthTotal.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get monthTotal;

  /// No description provided for @allowancesTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip allowances'**
  String get allowancesTitle;

  /// No description provided for @incentivesLabel.
  ///
  /// In en, this message translates to:
  /// **'Incentives'**
  String get incentivesLabel;

  /// No description provided for @settlementTitle.
  ///
  /// In en, this message translates to:
  /// **'Settlement balance'**
  String get settlementTitle;

  /// No description provided for @payableLabel.
  ///
  /// In en, this message translates to:
  /// **'Payable to you'**
  String get payableLabel;

  /// No description provided for @recoverableLabel.
  ///
  /// In en, this message translates to:
  /// **'Recoverable from you'**
  String get recoverableLabel;

  /// No description provided for @slipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Salary slips'**
  String get slipsTitle;

  /// No description provided for @tripsDoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Trips done'**
  String get tripsDoneLabel;

  /// No description provided for @onTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'On-time'**
  String get onTimeLabel;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// No description provided for @docLicence.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence'**
  String get docLicence;

  /// No description provided for @docRc.
  ///
  /// In en, this message translates to:
  /// **'RC'**
  String get docRc;

  /// No description provided for @docInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get docInsurance;

  /// No description provided for @docFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get docFitness;

  /// No description provided for @docPermit.
  ///
  /// In en, this message translates to:
  /// **'Permit'**
  String get docPermit;

  /// No description provided for @docPuc.
  ///
  /// In en, this message translates to:
  /// **'PUC'**
  String get docPuc;

  /// No description provided for @expiresInDays.
  ///
  /// In en, this message translates to:
  /// **'{days} days left'**
  String expiresInDays(int days);

  /// No description provided for @expiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expiredLabel;

  /// No description provided for @docNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get docNumberLabel;

  /// No description provided for @sosTitle.
  ///
  /// In en, this message translates to:
  /// **'SOS'**
  String get sosTitle;

  /// No description provided for @sosPrompt.
  ///
  /// In en, this message translates to:
  /// **'Press and hold for 3 seconds to alert Ops'**
  String get sosPrompt;

  /// No description provided for @sosSelectType.
  ///
  /// In en, this message translates to:
  /// **'What happened?'**
  String get sosSelectType;

  /// No description provided for @sosBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Breakdown'**
  String get sosBreakdown;

  /// No description provided for @sosAccident.
  ///
  /// In en, this message translates to:
  /// **'Accident'**
  String get sosAccident;

  /// No description provided for @sosMedical.
  ///
  /// In en, this message translates to:
  /// **'Medical'**
  String get sosMedical;

  /// No description provided for @sosThreat.
  ///
  /// In en, this message translates to:
  /// **'Threat'**
  String get sosThreat;

  /// No description provided for @sosOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get sosOther;

  /// No description provided for @sosSent.
  ///
  /// In en, this message translates to:
  /// **'SOS sent. Ops has been alerted.'**
  String get sosSent;

  /// No description provided for @sosQueued.
  ///
  /// In en, this message translates to:
  /// **'Offline - SOS queued and will send automatically'**
  String get sosQueued;

  /// No description provided for @queueTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline queue'**
  String get queueTitle;

  /// No description provided for @queueEmpty.
  ///
  /// In en, this message translates to:
  /// **'Everything is synced'**
  String get queueEmpty;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading'**
  String get statusUploading;

  /// No description provided for @statusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get statusFailed;

  /// No description provided for @actionTripStatus.
  ///
  /// In en, this message translates to:
  /// **'Trip status'**
  String get actionTripStatus;

  /// No description provided for @actionOffer.
  ///
  /// In en, this message translates to:
  /// **'Trip offer'**
  String get actionOffer;

  /// No description provided for @actionPod.
  ///
  /// In en, this message translates to:
  /// **'POD'**
  String get actionPod;

  /// No description provided for @actionExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get actionExpense;

  /// No description provided for @actionAdvance.
  ///
  /// In en, this message translates to:
  /// **'Advance'**
  String get actionAdvance;

  /// No description provided for @actionSos.
  ///
  /// In en, this message translates to:
  /// **'SOS'**
  String get actionSos;

  /// No description provided for @actionGps.
  ///
  /// In en, this message translates to:
  /// **'GPS batch'**
  String get actionGps;

  /// No description provided for @actionOther.
  ///
  /// In en, this message translates to:
  /// **'Sync item'**
  String get actionOther;

  /// No description provided for @statusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get statusDone;

  /// No description provided for @listeningLabel.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listeningLabel;

  /// No description provided for @voiceConfirm.
  ///
  /// In en, this message translates to:
  /// **'Mark \'{step}\'?'**
  String voiceConfirm(String step);

  /// No description provided for @yesAction.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesAction;

  /// No description provided for @noAction.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noAction;

  /// No description provided for @voiceNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Voice input is not available right now'**
  String get voiceNotAvailable;

  /// No description provided for @voiceCommandsLabel.
  ///
  /// In en, this message translates to:
  /// **'Voice commands'**
  String get voiceCommandsLabel;

  /// No description provided for @textSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSizeLabel;

  /// No description provided for @closeAction.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeAction;

  /// No description provided for @callAction.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callAction;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @balanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balanceLabel;

  /// No description provided for @tripsLabel.
  ///
  /// In en, this message translates to:
  /// **'trips'**
  String get tripsLabel;

  /// No description provided for @doneAction.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneAction;

  /// No description provided for @addAction.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addAction;

  /// No description provided for @ownerTabDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get ownerTabDashboard;

  /// No description provided for @ownerTabApprovals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get ownerTabApprovals;

  /// No description provided for @ownerTabAccounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get ownerTabAccounts;

  /// No description provided for @ownerTabMap.
  ///
  /// In en, this message translates to:
  /// **'Live Map'**
  String get ownerTabMap;

  /// No description provided for @branchAll.
  ///
  /// In en, this message translates to:
  /// **'All Branches'**
  String get branchAll;

  /// No description provided for @revenueMonth.
  ///
  /// In en, this message translates to:
  /// **'Revenue this month'**
  String get revenueMonth;

  /// No description provided for @revenueToday.
  ///
  /// In en, this message translates to:
  /// **'Revenue today'**
  String get revenueToday;

  /// No description provided for @revenueWeek.
  ///
  /// In en, this message translates to:
  /// **'Revenue last 7 days'**
  String get revenueWeek;

  /// No description provided for @todayLabel.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayLabel;

  /// No description provided for @range7d.
  ///
  /// In en, this message translates to:
  /// **'7D'**
  String get range7d;

  /// No description provided for @rangeMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get rangeMonth;

  /// No description provided for @tripsToday.
  ///
  /// In en, this message translates to:
  /// **'Trips today'**
  String get tripsToday;

  /// No description provided for @collectionsMonth.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collectionsMonth;

  /// No description provided for @outstandingLabel.
  ///
  /// In en, this message translates to:
  /// **'Outstanding'**
  String get outstandingLabel;

  /// No description provided for @cashBankLabel.
  ///
  /// In en, this message translates to:
  /// **'Cash & Bank'**
  String get cashBankLabel;

  /// No description provided for @utilisationLabel.
  ///
  /// In en, this message translates to:
  /// **'Fleet utilisation'**
  String get utilisationLabel;

  /// No description provided for @trendTitle.
  ///
  /// In en, this message translates to:
  /// **'Revenue vs collection'**
  String get trendTitle;

  /// No description provided for @topLanesTitle.
  ///
  /// In en, this message translates to:
  /// **'Top lanes by margin'**
  String get topLanesTitle;

  /// No description provided for @bottomCustomersTitle.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get bottomCustomersTitle;

  /// No description provided for @attentionTitle.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get attentionTitle;

  /// No description provided for @briefTitle.
  ///
  /// In en, this message translates to:
  /// **'AI brief'**
  String get briefTitle;

  /// No description provided for @readFullBrief.
  ///
  /// In en, this message translates to:
  /// **'Read full brief'**
  String get readFullBrief;

  /// No description provided for @askTitle.
  ///
  /// In en, this message translates to:
  /// **'Ask your data'**
  String get askTitle;

  /// No description provided for @askHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Which customer gave the lowest margin?'**
  String get askHint;

  /// No description provided for @approvalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get approvalsTitle;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @approvalAdvance.
  ///
  /// In en, this message translates to:
  /// **'Advances'**
  String get approvalAdvance;

  /// No description provided for @approvalExpense.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get approvalExpense;

  /// No description provided for @approvalRate.
  ///
  /// In en, this message translates to:
  /// **'Rate exceptions'**
  String get approvalRate;

  /// No description provided for @approvalCredit.
  ///
  /// In en, this message translates to:
  /// **'Credit override'**
  String get approvalCredit;

  /// No description provided for @approvalVendor.
  ///
  /// In en, this message translates to:
  /// **'Vendor payments'**
  String get approvalVendor;

  /// No description provided for @approvalPurchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get approvalPurchase;

  /// No description provided for @approveAction.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approveAction;

  /// No description provided for @askInfoAction.
  ///
  /// In en, this message translates to:
  /// **'Ask for info'**
  String get askInfoAction;

  /// No description provided for @commentHint.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get commentHint;

  /// No description provided for @commentRequired.
  ///
  /// In en, this message translates to:
  /// **'A comment is required to reject'**
  String get commentRequired;

  /// No description provided for @approvedMsg.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approvedMsg;

  /// No description provided for @rejectedMsg.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejectedMsg;

  /// No description provided for @infoAskedMsg.
  ///
  /// In en, this message translates to:
  /// **'Info requested from the requester'**
  String get infoAskedMsg;

  /// No description provided for @undoAction.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undoAction;

  /// No description provided for @emptyApprovals.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get emptyApprovals;

  /// No description provided for @createdLabel.
  ///
  /// In en, this message translates to:
  /// **'Raised'**
  String get createdLabel;

  /// No description provided for @accountsTitle.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accountsTitle;

  /// No description provided for @customerLedgerTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer ledger'**
  String get customerLedgerTitle;

  /// No description provided for @vendorLedgerTitle.
  ///
  /// In en, this message translates to:
  /// **'Vendor ledger'**
  String get vendorLedgerTitle;

  /// No description provided for @ageingTitle.
  ///
  /// In en, this message translates to:
  /// **'Ageing'**
  String get ageingTitle;

  /// No description provided for @pnlTitle.
  ///
  /// In en, this message translates to:
  /// **'Profit & Loss'**
  String get pnlTitle;

  /// No description provided for @daybookTitle.
  ///
  /// In en, this message translates to:
  /// **'Day book'**
  String get daybookTitle;

  /// No description provided for @bankBalancesTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank balances'**
  String get bankBalancesTitle;

  /// No description provided for @gstSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'GST summary'**
  String get gstSummaryTitle;

  /// No description provided for @tripPnlTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip P&L'**
  String get tripPnlTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchHint;

  /// No description provided for @sharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePdf;

  /// No description provided for @selectCustomer.
  ///
  /// In en, this message translates to:
  /// **'Select a customer'**
  String get selectCustomer;

  /// No description provided for @customerLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customerLabel;

  /// No description provided for @groupBranch.
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get groupBranch;

  /// No description provided for @groupVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get groupVehicle;

  /// No description provided for @groupCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get groupCustomer;

  /// No description provided for @groupLane.
  ///
  /// In en, this message translates to:
  /// **'Lane'**
  String get groupLane;

  /// No description provided for @liveMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Live map'**
  String get liveMapTitle;

  /// No description provided for @exceptionsFilter.
  ///
  /// In en, this message translates to:
  /// **'Exceptions'**
  String get exceptionsFilter;

  /// No description provided for @noGpsKey.
  ///
  /// In en, this message translates to:
  /// **'Map key not configured - showing the trip list. Nothing crashes.'**
  String get noGpsKey;

  /// No description provided for @shareWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Share on WhatsApp'**
  String get shareWhatsapp;

  /// No description provided for @briefMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get briefMoney;

  /// No description provided for @briefRisks.
  ///
  /// In en, this message translates to:
  /// **'Risks'**
  String get briefRisks;

  /// No description provided for @alertSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification settings'**
  String get alertSettingsTitle;

  /// No description provided for @alertPay.
  ///
  /// In en, this message translates to:
  /// **'Large payment received'**
  String get alertPay;

  /// No description provided for @alertDelay.
  ///
  /// In en, this message translates to:
  /// **'Big delay'**
  String get alertDelay;

  /// No description provided for @alertDoc.
  ///
  /// In en, this message translates to:
  /// **'Document expiring'**
  String get alertDoc;

  /// No description provided for @alertCredit.
  ///
  /// In en, this message translates to:
  /// **'Credit limit crossed'**
  String get alertCredit;

  /// No description provided for @channelPush.
  ///
  /// In en, this message translates to:
  /// **'Push'**
  String get channelPush;

  /// No description provided for @channelWa.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get channelWa;

  /// No description provided for @channelApp.
  ///
  /// In en, this message translates to:
  /// **'In-app'**
  String get channelApp;

  /// No description provided for @opsTabOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get opsTabOrders;

  /// No description provided for @opsTabPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get opsTabPlan;

  /// No description provided for @opsTabTrips.
  ///
  /// In en, this message translates to:
  /// **'Live Trips'**
  String get opsTabTrips;

  /// No description provided for @opsTabExceptions.
  ///
  /// In en, this message translates to:
  /// **'Exceptions'**
  String get opsTabExceptions;

  /// No description provided for @ordersTitle.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersTitle;

  /// No description provided for @orderPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get orderPending;

  /// No description provided for @orderPlanned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get orderPlanned;

  /// No description provided for @orderRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get orderRunning;

  /// No description provided for @orderCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get orderCompleted;

  /// No description provided for @orderCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderCancelled;

  /// No description provided for @newOrder.
  ///
  /// In en, this message translates to:
  /// **'New order'**
  String get newOrder;

  /// No description provided for @orderTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get orderTypeLabel;

  /// No description provided for @orderTypeFtl.
  ///
  /// In en, this message translates to:
  /// **'FTL'**
  String get orderTypeFtl;

  /// No description provided for @orderTypePtl.
  ///
  /// In en, this message translates to:
  /// **'PTL'**
  String get orderTypePtl;

  /// No description provided for @vehicleTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get vehicleTypeLabel;

  /// No description provided for @commodityLabel.
  ///
  /// In en, this message translates to:
  /// **'Commodity'**
  String get commodityLabel;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightLabel;

  /// No description provided for @declaredValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Declared value (Rs.)'**
  String get declaredValueLabel;

  /// No description provided for @stopsLabel.
  ///
  /// In en, this message translates to:
  /// **'Stops'**
  String get stopsLabel;

  /// No description provided for @planTripAction.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get planTripAction;

  /// No description provided for @planTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan trip'**
  String get planTitle;

  /// No description provided for @stepCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get stepCustomer;

  /// No description provided for @stepRoute.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get stepRoute;

  /// No description provided for @stepCargo.
  ///
  /// In en, this message translates to:
  /// **'Cargo'**
  String get stepCargo;

  /// No description provided for @stepRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get stepRate;

  /// No description provided for @pickupPoint.
  ///
  /// In en, this message translates to:
  /// **'Pickup point'**
  String get pickupPoint;

  /// No description provided for @dropPoint.
  ///
  /// In en, this message translates to:
  /// **'Drop point'**
  String get dropPoint;

  /// No description provided for @neededByLabel.
  ///
  /// In en, this message translates to:
  /// **'Needed by'**
  String get neededByLabel;

  /// No description provided for @pickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick date'**
  String get pickDate;

  /// No description provided for @pasteWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Paste WhatsApp message'**
  String get pasteWhatsapp;

  /// No description provided for @pasteHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 2 trucks 32 ft Pune to Chennai tomorrow'**
  String get pasteHint;

  /// No description provided for @aiFilled.
  ///
  /// In en, this message translates to:
  /// **'AI filled - please verify'**
  String get aiFilled;

  /// No description provided for @contractRate.
  ///
  /// In en, this message translates to:
  /// **'Contract rate'**
  String get contractRate;

  /// No description provided for @belowContract.
  ///
  /// In en, this message translates to:
  /// **'Below contract rate - needs approval'**
  String get belowContract;

  /// No description provided for @createOrder.
  ///
  /// In en, this message translates to:
  /// **'Create order'**
  String get createOrder;

  /// No description provided for @orderCreated.
  ///
  /// In en, this message translates to:
  /// **'Order created'**
  String get orderCreated;

  /// No description provided for @planStepOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get planStepOrder;

  /// No description provided for @planStepVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get planStepVehicle;

  /// No description provided for @planStepDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get planStepDriver;

  /// No description provided for @planStepSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get planStepSummary;

  /// No description provided for @docsValid.
  ///
  /// In en, this message translates to:
  /// **'Docs valid'**
  String get docsValid;

  /// No description provided for @docsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Docs invalid'**
  String get docsInvalid;

  /// No description provided for @onTripBlock.
  ///
  /// In en, this message translates to:
  /// **'Already on a trip'**
  String get onTripBlock;

  /// No description provided for @licenceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Licence invalid'**
  String get licenceInvalid;

  /// No description provided for @routeKm.
  ///
  /// In en, this message translates to:
  /// **'Route distance'**
  String get routeKm;

  /// No description provided for @tollEst.
  ///
  /// In en, this message translates to:
  /// **'Toll estimate'**
  String get tollEst;

  /// No description provided for @dieselEst.
  ///
  /// In en, this message translates to:
  /// **'Diesel estimate'**
  String get dieselEst;

  /// No description provided for @etaLabel.
  ///
  /// In en, this message translates to:
  /// **'ETA'**
  String get etaLabel;

  /// No description provided for @advanceOptional.
  ///
  /// In en, this message translates to:
  /// **'Advance (optional)'**
  String get advanceOptional;

  /// No description provided for @assignAction.
  ///
  /// In en, this message translates to:
  /// **'Assign & notify driver'**
  String get assignAction;

  /// No description provided for @assignedMsg.
  ///
  /// In en, this message translates to:
  /// **'Trip assigned and driver notified:'**
  String get assignedMsg;

  /// No description provided for @returnLoadTitle.
  ///
  /// In en, this message translates to:
  /// **'Return load nearby'**
  String get returnLoadTitle;

  /// No description provided for @returnLoadBody.
  ///
  /// In en, this message translates to:
  /// **'2 loads available near {place}. Ask the driver before they head back empty.'**
  String returnLoadBody(String place);

  /// No description provided for @liveTripsTitle.
  ///
  /// In en, this message translates to:
  /// **'Live trips'**
  String get liveTripsTitle;

  /// No description provided for @listTab.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listTab;

  /// No description provided for @mapTab.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get mapTab;

  /// No description provided for @controlTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip control'**
  String get controlTitle;

  /// No description provided for @callDriver.
  ///
  /// In en, this message translates to:
  /// **'Call driver'**
  String get callDriver;

  /// No description provided for @updateStatusAction.
  ///
  /// In en, this message translates to:
  /// **'Update status'**
  String get updateStatusAction;

  /// No description provided for @reasonRequired.
  ///
  /// In en, this message translates to:
  /// **'A reason is required'**
  String get reasonRequired;

  /// No description provided for @raiseAdvanceAction.
  ///
  /// In en, this message translates to:
  /// **'Raise advance'**
  String get raiseAdvanceAction;

  /// No description provided for @advanceRaised.
  ///
  /// In en, this message translates to:
  /// **'Advance request raised'**
  String get advanceRaised;

  /// No description provided for @ewayLabel.
  ///
  /// In en, this message translates to:
  /// **'E-way bill no.'**
  String get ewayLabel;

  /// No description provided for @shareTracking.
  ///
  /// In en, this message translates to:
  /// **'Share tracking'**
  String get shareTracking;

  /// No description provided for @exceptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Exceptions'**
  String get exceptionsTitle;

  /// No description provided for @noExceptions.
  ///
  /// In en, this message translates to:
  /// **'All clear - no open exceptions'**
  String get noExceptions;

  /// No description provided for @exDelay.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get exDelay;

  /// No description provided for @exHalt.
  ///
  /// In en, this message translates to:
  /// **'Long halt'**
  String get exHalt;

  /// No description provided for @exDeviation.
  ///
  /// In en, this message translates to:
  /// **'Route deviation'**
  String get exDeviation;

  /// No description provided for @exOverspeed.
  ///
  /// In en, this message translates to:
  /// **'Overspeed'**
  String get exOverspeed;

  /// No description provided for @exDeviceOff.
  ///
  /// In en, this message translates to:
  /// **'Device off'**
  String get exDeviceOff;

  /// No description provided for @exEway.
  ///
  /// In en, this message translates to:
  /// **'E-way expiring'**
  String get exEway;

  /// No description provided for @exPod.
  ///
  /// In en, this message translates to:
  /// **'POD pending'**
  String get exPod;

  /// No description provided for @extendEway.
  ///
  /// In en, this message translates to:
  /// **'Extend e-way'**
  String get extendEway;

  /// No description provided for @ewayExtended.
  ///
  /// In en, this message translates to:
  /// **'E-way bill extended'**
  String get ewayExtended;

  /// No description provided for @escalateAction.
  ///
  /// In en, this message translates to:
  /// **'Escalate'**
  String get escalateAction;

  /// No description provided for @resolveAction.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get resolveAction;

  /// No description provided for @marketTitle.
  ///
  /// In en, this message translates to:
  /// **'Market vehicles'**
  String get marketTitle;

  /// No description provided for @knownVehicles.
  ///
  /// In en, this message translates to:
  /// **'Known broker vehicles'**
  String get knownVehicles;

  /// No description provided for @addVehicleTitle.
  ///
  /// In en, this message translates to:
  /// **'Add broker vehicle'**
  String get addVehicleTitle;

  /// No description provided for @vehicleNoLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle no.'**
  String get vehicleNoLabel;

  /// No description provided for @vehicleNoError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid vehicle no. e.g. MH 12 AB 1234'**
  String get vehicleNoError;

  /// No description provided for @ownerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner name'**
  String get ownerNameLabel;

  /// No description provided for @panLabel.
  ///
  /// In en, this message translates to:
  /// **'PAN'**
  String get panLabel;

  /// No description provided for @panError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid PAN e.g. AAKCS1234F'**
  String get panError;

  /// No description provided for @driverNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Driver name'**
  String get driverNameLabel;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get fillAllFields;

  /// No description provided for @kycPhotos.
  ///
  /// In en, this message translates to:
  /// **'KYC photos'**
  String get kycPhotos;

  /// No description provided for @memoTitle.
  ///
  /// In en, this message translates to:
  /// **'Hire memo'**
  String get memoTitle;

  /// No description provided for @freightAgreed.
  ///
  /// In en, this message translates to:
  /// **'Freight agreed'**
  String get freightAgreed;

  /// No description provided for @deductionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Deductions'**
  String get deductionsLabel;

  /// No description provided for @balanceOnPod.
  ///
  /// In en, this message translates to:
  /// **'Balance on POD'**
  String get balanceOnPod;

  /// No description provided for @payAdvanceAction.
  ///
  /// In en, this message translates to:
  /// **'Pay advance'**
  String get payAdvanceAction;

  /// No description provided for @approvalRaised.
  ///
  /// In en, this message translates to:
  /// **'Above limit - approval raised'**
  String get approvalRaised;

  /// No description provided for @paidMsg.
  ///
  /// In en, this message translates to:
  /// **'Advance paid'**
  String get paidMsg;

  /// No description provided for @centreTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get centreTitle;

  /// No description provided for @todayGroup.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayGroup;

  /// No description provided for @earlierGroup.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get earlierGroup;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get searchTrips;

  /// No description provided for @searchLrs.
  ///
  /// In en, this message translates to:
  /// **'LRs'**
  String get searchLrs;

  /// No description provided for @searchVehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get searchVehicles;

  /// No description provided for @searchCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get searchCustomers;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @biometricLabel.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock'**
  String get biometricLabel;

  /// No description provided for @aboutLabel.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutLabel;

  /// No description provided for @salesTabLeads.
  ///
  /// In en, this message translates to:
  /// **'Leads'**
  String get salesTabLeads;

  /// No description provided for @salesTabVisits.
  ///
  /// In en, this message translates to:
  /// **'Visits'**
  String get salesTabVisits;

  /// No description provided for @salesTabQuote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get salesTabQuote;

  /// No description provided for @salesTabCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get salesTabCustomers;

  /// No description provided for @leadsTitle.
  ///
  /// In en, this message translates to:
  /// **'Leads'**
  String get leadsTitle;

  /// No description provided for @addLeadAction.
  ///
  /// In en, this message translates to:
  /// **'Add lead'**
  String get addLeadAction;

  /// No description provided for @slaDueIn.
  ///
  /// In en, this message translates to:
  /// **'Due in {left}'**
  String slaDueIn(String left);

  /// No description provided for @slaOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue {left}'**
  String slaOverdue(String left);

  /// No description provided for @stageFresh.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get stageFresh;

  /// No description provided for @stageContacted.
  ///
  /// In en, this message translates to:
  /// **'Contacted'**
  String get stageContacted;

  /// No description provided for @stageQuoted.
  ///
  /// In en, this message translates to:
  /// **'Quoted'**
  String get stageQuoted;

  /// No description provided for @stageNegotiation.
  ///
  /// In en, this message translates to:
  /// **'Negotiation'**
  String get stageNegotiation;

  /// No description provided for @stageWon.
  ///
  /// In en, this message translates to:
  /// **'Won'**
  String get stageWon;

  /// No description provided for @stageLost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get stageLost;

  /// No description provided for @srcWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get srcWebsite;

  /// No description provided for @srcWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get srcWhatsapp;

  /// No description provided for @srcIndiamart.
  ///
  /// In en, this message translates to:
  /// **'IndiaMART'**
  String get srcIndiamart;

  /// No description provided for @srcJustdial.
  ///
  /// In en, this message translates to:
  /// **'Justdial'**
  String get srcJustdial;

  /// No description provided for @srcIvr.
  ///
  /// In en, this message translates to:
  /// **'IVR'**
  String get srcIvr;

  /// No description provided for @srcEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get srcEmail;

  /// No description provided for @srcWalkin.
  ///
  /// In en, this message translates to:
  /// **'Walk-in'**
  String get srcWalkin;

  /// No description provided for @srcReferral.
  ///
  /// In en, this message translates to:
  /// **'Referral'**
  String get srcReferral;

  /// No description provided for @companyLabel.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get companyLabel;

  /// No description provided for @contactLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact person'**
  String get contactLabel;

  /// No description provided for @sourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get sourceLabel;

  /// No description provided for @fromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get fromLabel;

  /// No description provided for @toLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get toLabel;

  /// No description provided for @tripsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'Trips / month'**
  String get tripsPerMonth;

  /// No description provided for @targetRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Target rate'**
  String get targetRateLabel;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @voiceTranscribed.
  ///
  /// In en, this message translates to:
  /// **'voice note transcribed'**
  String get voiceTranscribed;

  /// No description provided for @scanCardAction.
  ///
  /// In en, this message translates to:
  /// **'Scan card'**
  String get scanCardAction;

  /// No description provided for @cardScanned.
  ///
  /// In en, this message translates to:
  /// **'Card scanned - verify the fields'**
  String get cardScanned;

  /// No description provided for @duplicateLead.
  ///
  /// In en, this message translates to:
  /// **'This phone already exists - possible duplicate'**
  String get duplicateLead;

  /// No description provided for @saveLeadAction.
  ///
  /// In en, this message translates to:
  /// **'Save lead'**
  String get saveLeadAction;

  /// No description provided for @moveToStage.
  ///
  /// In en, this message translates to:
  /// **'Move to'**
  String get moveToStage;

  /// No description provided for @addLeadTitle.
  ///
  /// In en, this message translates to:
  /// **'Add lead'**
  String get addLeadTitle;

  /// No description provided for @visitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Visits'**
  String get visitsTitle;

  /// No description provided for @checkInAction.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get checkInAction;

  /// No description provided for @checkInTitle.
  ///
  /// In en, this message translates to:
  /// **'Visit check-in'**
  String get checkInTitle;

  /// No description provided for @visitCustomerLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get visitCustomerLabel;

  /// No description provided for @checkinPhoto.
  ///
  /// In en, this message translates to:
  /// **'Site photo'**
  String get checkinPhoto;

  /// No description provided for @photoRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake photo'**
  String get photoRetake;

  /// No description provided for @outcomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Outcome'**
  String get outcomeLabel;

  /// No description provided for @checkOutAction.
  ///
  /// In en, this message translates to:
  /// **'Check out'**
  String get checkOutAction;

  /// No description provided for @visitDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get visitDone;

  /// No description provided for @visitActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get visitActive;

  /// No description provided for @visitPlanned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get visitPlanned;

  /// No description provided for @quoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get quoteTitle;

  /// No description provided for @perTonRate.
  ///
  /// In en, this message translates to:
  /// **'Per ton'**
  String get perTonRate;

  /// No description provided for @noRateCard.
  ///
  /// In en, this message translates to:
  /// **'No rate card for this lane'**
  String get noRateCard;

  /// No description provided for @chargeDetention.
  ///
  /// In en, this message translates to:
  /// **'Detention'**
  String get chargeDetention;

  /// No description provided for @chargeLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get chargeLoading;

  /// No description provided for @chargeOda.
  ///
  /// In en, this message translates to:
  /// **'ODA'**
  String get chargeOda;

  /// No description provided for @chargeMultiDrop.
  ///
  /// In en, this message translates to:
  /// **'Multi-drop'**
  String get chargeMultiDrop;

  /// No description provided for @needsApproval.
  ///
  /// In en, this message translates to:
  /// **'Needs approval'**
  String get needsApproval;

  /// No description provided for @quoteTotal.
  ///
  /// In en, this message translates to:
  /// **'Quote total'**
  String get quoteTotal;

  /// No description provided for @quotePreviewAction.
  ///
  /// In en, this message translates to:
  /// **'Preview quote'**
  String get quotePreviewAction;

  /// No description provided for @sendWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Send via WhatsApp'**
  String get sendWhatsapp;

  /// No description provided for @customersTitle.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customersTitle;

  /// No description provided for @remindPayment.
  ///
  /// In en, this message translates to:
  /// **'Remind payment'**
  String get remindPayment;

  /// No description provided for @reminderSent.
  ///
  /// In en, this message translates to:
  /// **'Reminder sent'**
  String get reminderSent;

  /// No description provided for @reminderTemplate.
  ///
  /// In en, this message translates to:
  /// **'Namaste {name}, Rs.{amount} is due to Shree Ganesh Roadlines. Please pay at the earliest.'**
  String reminderTemplate(String name, String amount);

  /// No description provided for @targetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Targets'**
  String get targetsTitle;

  /// No description provided for @targetRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue (L)'**
  String get targetRevenue;

  /// No description provided for @targetCustomers.
  ///
  /// In en, this message translates to:
  /// **'New customers'**
  String get targetCustomers;

  /// No description provided for @targetTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get targetTrips;

  /// No description provided for @leaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardTitle;

  /// No description provided for @superTabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get superTabToday;

  /// No description provided for @superTabGate.
  ///
  /// In en, this message translates to:
  /// **'Gate'**
  String get superTabGate;

  /// No description provided for @superTabScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get superTabScan;

  /// No description provided for @superTabManifest.
  ///
  /// In en, this message translates to:
  /// **'Manifest'**
  String get superTabManifest;

  /// No description provided for @todayTitle.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayTitle;

  /// No description provided for @loadingsTab.
  ///
  /// In en, this message translates to:
  /// **'Loadings'**
  String get loadingsTab;

  /// No description provided for @arrivalsTab.
  ///
  /// In en, this message translates to:
  /// **'Arrivals'**
  String get arrivalsTab;

  /// No description provided for @hubPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get hubPending;

  /// No description provided for @hubInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get hubInProgress;

  /// No description provided for @hubDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get hubDone;

  /// No description provided for @gateTitle.
  ///
  /// In en, this message translates to:
  /// **'Gate'**
  String get gateTitle;

  /// No description provided for @selectVehicle.
  ///
  /// In en, this message translates to:
  /// **'Select vehicle'**
  String get selectVehicle;

  /// No description provided for @gateInAction.
  ///
  /// In en, this message translates to:
  /// **'Gate in'**
  String get gateInAction;

  /// No description provided for @gateOutAction.
  ///
  /// In en, this message translates to:
  /// **'Gate out'**
  String get gateOutAction;

  /// No description provided for @gateEarly.
  ///
  /// In en, this message translates to:
  /// **'Early by {span}'**
  String gateEarly(String span);

  /// No description provided for @gateLate.
  ///
  /// In en, this message translates to:
  /// **'Late by {span}'**
  String gateLate(String span);

  /// No description provided for @loadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingTitle;

  /// No description provided for @loadingStartPhoto.
  ///
  /// In en, this message translates to:
  /// **'Start photo'**
  String get loadingStartPhoto;

  /// No description provided for @loadingEndPhoto.
  ///
  /// In en, this message translates to:
  /// **'End photo'**
  String get loadingEndPhoto;

  /// No description provided for @sealNoLabel.
  ///
  /// In en, this message translates to:
  /// **'Seal number'**
  String get sealNoLabel;

  /// No description provided for @weighmentSlip.
  ///
  /// In en, this message translates to:
  /// **'Weighment slip'**
  String get weighmentSlip;

  /// No description provided for @weightMismatch.
  ///
  /// In en, this message translates to:
  /// **'Weight differs from declared - will be reviewed'**
  String get weightMismatch;

  /// No description provided for @completeLoading.
  ///
  /// In en, this message translates to:
  /// **'Complete loading'**
  String get completeLoading;

  /// No description provided for @loadingComplete.
  ///
  /// In en, this message translates to:
  /// **'Loading completed'**
  String get loadingComplete;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan packages'**
  String get scanTitle;

  /// No description provided for @scannedLabel.
  ///
  /// In en, this message translates to:
  /// **'Scanned'**
  String get scannedLabel;

  /// No description provided for @duplicateScan.
  ///
  /// In en, this message translates to:
  /// **'Already scanned'**
  String get duplicateScan;

  /// No description provided for @scannerUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Scanner unavailable on this device'**
  String get scannerUnavailable;

  /// No description provided for @markDamage.
  ///
  /// In en, this message translates to:
  /// **'Damage'**
  String get markDamage;

  /// No description provided for @markShortage.
  ///
  /// In en, this message translates to:
  /// **'Shortage'**
  String get markShortage;

  /// No description provided for @createManifest.
  ///
  /// In en, this message translates to:
  /// **'Create manifest'**
  String get createManifest;

  /// No description provided for @manifestTitle.
  ///
  /// In en, this message translates to:
  /// **'Manifest'**
  String get manifestTitle;

  /// No description provided for @destHubLabel.
  ///
  /// In en, this message translates to:
  /// **'Destination hub'**
  String get destHubLabel;

  /// No description provided for @lrPrintTitle.
  ///
  /// In en, this message translates to:
  /// **'LR print'**
  String get lrPrintTitle;

  /// No description provided for @printAction.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get printAction;

  /// No description provided for @bluetoothPrinter.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth printer'**
  String get bluetoothPrinter;

  /// No description provided for @bluetoothSoon.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth printer coming soon'**
  String get bluetoothSoon;

  /// No description provided for @scanToManifest.
  ///
  /// In en, this message translates to:
  /// **'Scan packages to build a manifest'**
  String get scanToManifest;

  /// No description provided for @acctTabSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get acctTabSummary;

  /// No description provided for @acctTabLedgers.
  ///
  /// In en, this message translates to:
  /// **'Ledgers'**
  String get acctTabLedgers;

  /// No description provided for @acctTabInvoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get acctTabInvoices;

  /// No description provided for @acctTabApprovals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get acctTabApprovals;

  /// No description provided for @acctSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Accounts summary'**
  String get acctSummaryTitle;

  /// No description provided for @receivablesLabel.
  ///
  /// In en, this message translates to:
  /// **'Receivables'**
  String get receivablesLabel;

  /// No description provided for @payablesLabel.
  ///
  /// In en, this message translates to:
  /// **'Payables'**
  String get payablesLabel;

  /// No description provided for @readyToBill.
  ///
  /// In en, this message translates to:
  /// **'Ready to bill'**
  String get readyToBill;

  /// No description provided for @invoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesTitle;

  /// No description provided for @invDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get invDraft;

  /// No description provided for @invSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get invSent;

  /// No description provided for @invPartPaid.
  ///
  /// In en, this message translates to:
  /// **'Part-paid'**
  String get invPartPaid;

  /// No description provided for @invPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get invPaid;

  /// No description provided for @invOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get invOverdue;

  /// No description provided for @dueLabel.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get dueLabel;

  /// No description provided for @paidLabel.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidLabel;

  /// No description provided for @viewPdf.
  ///
  /// In en, this message translates to:
  /// **'View PDF'**
  String get viewPdf;

  /// No description provided for @recordReceiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Record receipt'**
  String get recordReceiptTitle;

  /// No description provided for @receiptNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Your role cannot record receipts'**
  String get receiptNotAllowed;

  /// No description provided for @receiptSaved.
  ///
  /// In en, this message translates to:
  /// **'Receipt recorded'**
  String get receiptSaved;

  /// No description provided for @utrLabel.
  ///
  /// In en, this message translates to:
  /// **'UTR'**
  String get utrLabel;

  /// No description provided for @tdsLabel.
  ///
  /// In en, this message translates to:
  /// **'TDS deducted'**
  String get tdsLabel;

  /// No description provided for @shortPayLabel.
  ///
  /// In en, this message translates to:
  /// **'Short-pay reason'**
  String get shortPayLabel;

  /// No description provided for @remindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersTitle;

  /// No description provided for @payLikely.
  ///
  /// In en, this message translates to:
  /// **'Likely to pay in 3 days'**
  String get payLikely;

  /// No description provided for @limitForwarded.
  ///
  /// In en, this message translates to:
  /// **'Above your Rs.50,000 limit - forwarded to Owner'**
  String get limitForwarded;

  /// No description provided for @tripAssigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get tripAssigned;

  /// No description provided for @tripDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get tripDelivered;

  /// No description provided for @tripClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get tripClosed;

  /// No description provided for @tripCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get tripCancelled;

  /// No description provided for @phaseComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming in {phase}'**
  String phaseComingSoon(String phase);

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Namaste, {name}'**
  String greeting(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'bn',
        'en',
        'hi',
        'kn',
        'mr',
        'pa',
        'ta',
        'te'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'mr':
      return AppLocalizationsMr();
    case 'pa':
      return AppLocalizationsPa();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
