// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'RoadOps';

  @override
  String get splashTagline => 'आपका लॉजिस्टिक्स साथी';

  @override
  String get languageTitle => 'अपनी भाषा चुनें';

  @override
  String get languageSubtitle => 'इसे आप बाद में सेटिंग्स में बदल सकते हैं';

  @override
  String get continueAction => 'आगे बढ़ें';

  @override
  String get langEnglish => 'अंग्रेज़ी';

  @override
  String get langHindi => 'हिन्दी';

  @override
  String get langMarathi => 'मराठी';

  @override
  String get langTamil => 'तमिल';

  @override
  String get langTelugu => 'तेलुगु';

  @override
  String get langKannada => 'कन्नड़';

  @override
  String get langBengali => 'बंगाली';

  @override
  String get langPunjabi => 'पंजाबी';

  @override
  String get loginTitle => 'अपने फोन नंबर से लॉगिन करें';

  @override
  String get loginSubtitle =>
      'यूज़र सिर्फ एडमिन बनाता है। साइन-अप की ज़रूरत नहीं।';

  @override
  String get phoneLabel => 'मोबाइल नंबर';

  @override
  String get phoneHint => '10 अंकों का नंबर';

  @override
  String get phoneError => 'सही 10 अंकों का मोबाइल नंबर डालें';

  @override
  String get getOtp => 'OTP पाएं';

  @override
  String get demoAccounts => 'डेमो अकाउंट';

  @override
  String get demoAccountsHint => 'डेमो नंबर भरने के लिए भूमिका पर टैप करें';

  @override
  String get invalidPhone =>
      'यह नंबर रजिस्टर नहीं है। अपने एडमिन से संपर्क करें।';

  @override
  String get blockedAccount =>
      'आपका अकाउंट सक्रिय नहीं है। अपने एडमिन से संपर्क करें।';

  @override
  String otpTitle(String phone) {
    return '+91 $phone पर भेजा OTP डालें';
  }

  @override
  String get otpSubtitle => '6 अंकों का कोड। कुछ मिनट में खत्म हो जाएगा।';

  @override
  String get otpError => 'गलत OTP, फिर कोशिश करें';

  @override
  String get otpExpired => 'इस OTP की समय सीमा खत्म हो गई। नया OTP मंगाएं।';

  @override
  String get otpResend => 'OTP दोबारा भेजें';

  @override
  String otpResendIn(int seconds) {
    return '$seconds सेकंड में दोबारा भेजें';
  }

  @override
  String otpAttemptsLeft(int count) {
    return '$count मौके बचे हैं';
  }

  @override
  String get verifyAction => 'सत्यापित करें';

  @override
  String get roleDriver => 'ड्राइवर';

  @override
  String get roleOwner => 'मालिक';

  @override
  String get roleOps => 'ऑप्स';

  @override
  String get roleSales => 'सेल्स';

  @override
  String get roleSupervisor => 'सुपरवाइज़र';

  @override
  String get roleAccountant => 'अकाउंटेंट';

  @override
  String get rolePickerTitle => 'अपनी भूमिका चुनें';

  @override
  String get rolePickerSubtitle =>
      'आपके पास एक से ज़्यादा भूमिकाएं हैं। आज कहां जाना है चुनें।';

  @override
  String get permissionsTitle => 'कुछ अनुमतियां चाहिए';

  @override
  String get permissionsSubtitle =>
      'हर अनुमति आपकी भूमिका के काम में मदद करती है।';

  @override
  String get permissionAllow => 'अनुमति दें';

  @override
  String get permissionDeny => 'मना करें';

  @override
  String get permNotificationsTitle => 'नोटिफिकेशन';

  @override
  String get permNotificationsWhy =>
      'ट्रिप, अप्रूवल और पेमेंट की जानकारी के लिए।';

  @override
  String get permCameraTitle => 'कैमरा';

  @override
  String get permCameraWhy => 'POD, बिल, लोडिंग फोटो और स्कैन के लिए।';

  @override
  String get permLocationTitle => 'लोकेशन';

  @override
  String get permLocationWhy => 'नेविगेशन और ट्रिप चेकपॉइंट के लिए।';

  @override
  String get permLocationAlwaysTitle => 'बैकग्राउंड लोकेशन';

  @override
  String get permLocationAlwaysWhy =>
      'ऐप बंद होने पर भी आपकी ट्रिप ट्रैक करने के लिए।';

  @override
  String get permBatteryTitle => 'बैटरी ऑप्टिमाइज़ेशन';

  @override
  String get permBatteryWhy => 'ताकि लंबे रूट पर ट्रिप ट्रैकिंग चलती रहे।';

  @override
  String get permMicrophoneTitle => 'माइक्रोफोन';

  @override
  String get permMicrophoneWhy => 'वॉइस कमांड और वॉइस नोट के लिए।';

  @override
  String get locationDisclosure =>
      'ऐप बंद होने या इस्तेमाल न होने पर भी आपकी ट्रिप ट्रैक करने के लिए RoadOps लोकेशन डेटा लेता है।';

  @override
  String get acceptAction => 'स्वीकार करें';

  @override
  String get denyAction => 'मना करें';

  @override
  String get rejectAction => 'अस्वीकार करें';

  @override
  String get navigateAction => 'नेविगेट करें';

  @override
  String get biometricTitle => 'ऐप लॉक करें';

  @override
  String get biometricSubtitle =>
      'फिंगरप्रिंट, फेस अनलॉक या 4 अंकों का PIN इस्तेमाल करें।';

  @override
  String get biometricEnable => 'चालू करें';

  @override
  String get biometricSkip => 'PIN इस्तेमाल करें';

  @override
  String get lockTitle => 'वापसी पर स्वागत है';

  @override
  String get lockSubtitle => 'आगे बढ़ने के लिए अनलॉक करें';

  @override
  String get useDemoPin => 'डेमो PIN 1234 इस्तेमाल करें';

  @override
  String get logoutTitle => 'लॉगआउट करें?';

  @override
  String get logoutMessage => 'वापस लॉगिन के लिए OTP चाहिए होगा।';

  @override
  String get logoutAction => 'लॉगआउट';

  @override
  String get cancelAction => 'रद्द करें';

  @override
  String get retryAction => 'पुनः प्रयास करें';

  @override
  String get commonLoading => 'लोड हो रहा है…';

  @override
  String get commonEmpty => 'यहां अभी कुछ नहीं है';

  @override
  String get commonError => 'कुछ गड़बड़ हो गई';

  @override
  String get offlineMessage => 'आप ऑफ़लाइन हैं। अपडेट अपने आप सिंक हो जाएंगे।';

  @override
  String pendingSync(int count) {
    return '$count आइटम सिंक होना बाकी है';
  }

  @override
  String get syncNow => 'अभी सिंक करें';

  @override
  String get viewQueue => 'कतार देखें';

  @override
  String get forbiddenTitle => 'अनुमति नहीं है';

  @override
  String get forbiddenMessage => 'आपकी भूमिका यह स्क्रीन नहीं खोल सकती।';

  @override
  String get goBackAction => 'वापस जाएं';

  @override
  String get otpBackToLogin => 'लॉगिन पर वापस जाएं';

  @override
  String otpLockout(int minutes) {
    return 'बहुत ज़्यादा गलत कोशिशें। $minutes मिनट बाद फिर कोशिश करें।';
  }

  @override
  String get permissionNext => 'आगे';

  @override
  String get permissionDone => 'हो गया';

  @override
  String get appPinTitle => '4 अंकों का ऐप PIN बनाएं';

  @override
  String get appPinConfirmTitle => 'अपना PIN दोबारा डालें';

  @override
  String get appPinMismatch => 'PIN मेल नहीं खा रहे। फिर कोशिश करें।';

  @override
  String get pinHint => '4 अंकों का PIN';

  @override
  String get biometricSetupHint =>
      'सिर्फ स्टाफ के लिए। ड्राइवर यह चरण छोड़ देते हैं।';

  @override
  String get biometricEnrolled => 'बायोमेट्रिक चालू हो गया';

  @override
  String get unlockAction => 'अनलॉक करें';

  @override
  String get wrongPin => 'गलत PIN, फिर कोशिश करें';

  @override
  String get unlockWithBio => 'फिंगरप्रिंट / फेस इस्तेमाल करें';

  @override
  String get profileTitle => 'प्रोफ़ाइल';

  @override
  String get switchRole => 'भूमिका बदलें';

  @override
  String appVersion(String version) {
    return 'ऐप वर्शन $version';
  }

  @override
  String get demoTools => 'डेमो टूल्स';

  @override
  String get demoSampleNotification => 'सैंपल नोटिफिकेशन भेजें';

  @override
  String get demoAdvanceTrip => 'ट्रिप सिम्युलेशन आगे बढ़ाएं';

  @override
  String get simulateOffline => 'ऑफ़लाइन सिम्युलेट करें';

  @override
  String get resetDemoData => 'डेमो डेटा रीसेट करें';

  @override
  String get demoActionDone => 'हो गया';

  @override
  String get logoutRunningTrip =>
      'आपकी ट्रिप चल रही है। लॉगआउट से पहले उसे पूरा करें या Ops से बंद करने को कहें।';

  @override
  String logoutPendingSync(int count) {
    return '$count आइटम अभी अपलोड नहीं हुए हैं। लॉगआउट से पहले इंटरनेट से जुड़कर सिंक करें।';
  }

  @override
  String get forceLogout => 'फोर्स लॉगआउट (डेमो)';

  @override
  String get roleContinueAs => 'आगे बढ़ें';

  @override
  String get lastUsedRole => 'पिछली बार इस्तेमाल';

  @override
  String phaseComingSoon(String phase) {
    return '$phase में आ रहा है';
  }

  @override
  String greeting(String name) {
    return 'नमस्ते, $name';
  }
}
