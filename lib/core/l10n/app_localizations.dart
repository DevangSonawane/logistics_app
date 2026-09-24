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
