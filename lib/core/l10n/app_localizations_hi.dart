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
  String get tabMyTrip => 'मेरी ट्रिप';

  @override
  String get tabEarnings => 'कमाई';

  @override
  String get tabDocuments => 'दस्तावेज़';

  @override
  String get tabProfile => 'प्रोफ़ाइल';

  @override
  String get noTripTitle => 'अभी कोई ट्रिप नहीं है। हम आपको बताएंगे।';

  @override
  String get offerTitle => 'नई ट्रिप ऑफर';

  @override
  String get pickupLabel => 'पिकअप';

  @override
  String get dropLabel => 'ड्रॉप';

  @override
  String get freightLabel => 'भाड़ा भत्ता';

  @override
  String get pickupByLabel => 'पिकअप समय';

  @override
  String get rejectTitle => 'ट्रिप अस्वीकार करें';

  @override
  String get rejectReasonLabel => 'कारण (ज़रूरी)';

  @override
  String get rejectVehicle => 'गाड़ी में दिक्कत';

  @override
  String get rejectHealth => 'तबीयत';

  @override
  String get rejectPersonal => 'निजी कारण';

  @override
  String get rejectRoute => 'रूट मालूम नहीं';

  @override
  String get rejectOther => 'अन्य';

  @override
  String get rejectNoteHint => 'विवरण (वैकल्पिक)';

  @override
  String get submitAction => 'जमा करें';

  @override
  String get lrEwayLabel => 'LR / ई-वे बिल';

  @override
  String get addExpenseAction => 'खर्च जोड़ें';

  @override
  String get requestAdvanceAction => 'एडवांस मांगें';

  @override
  String get stepReachedPickup => 'पिकअप पहुंचे';

  @override
  String get stepLoadingDone => 'लोडिंग हो गई';

  @override
  String get stepStartTrip => 'ट्रिप शुरू करें';

  @override
  String get stepReachedDrop => 'ड्रॉप पहुंचे';

  @override
  String get stepUnloaded => 'अनलोड हो गया';

  @override
  String get slideHint => 'पुष्टि के लिए स्लाइड करें';

  @override
  String get photoRequired => 'इस चरण के लिए फोटो ज़रूरी है';

  @override
  String get stepDone => 'स्टेटस अपडेट हो गया';

  @override
  String get stepQueued => 'ऑफ़लाइन - अपने आप सिंक होगा';

  @override
  String get conflictTitle => 'ट्रिप बदल गई';

  @override
  String get conflictMessage =>
      'Ops ने यह ट्रिप बदल दी। आपका काम रद्द हुआ और ट्रिप ताज़ा हो गई।';

  @override
  String get okAction => 'ठीक है';

  @override
  String get timelineTitle => 'टाइमलाइन';

  @override
  String get podPromptTitle => 'ट्रिप अनलोड - POD बनाएं';

  @override
  String get podPromptAction => 'POD बनाएं';

  @override
  String get callOps => 'Ops को कॉल करें';

  @override
  String get opsAlerted => 'Ops को सूचित कर दिया गया';

  @override
  String get trackingOn => 'GPS ट्रैकिंग चालू';

  @override
  String get advanceBalance => 'एडवांस बैलेंस';

  @override
  String get podTitle => 'डिलीवरी प्रूफ (POD)';

  @override
  String get podStep1 => 'साइन की हुई LR की फोटो';

  @override
  String get podStep2 => 'पाने वाले की पुष्टि';

  @override
  String get podOtpHint => 'पाने वाले के पास 4 अंकों का OTP';

  @override
  String get podOtpWrong => 'गलत OTP';

  @override
  String get podOr => 'या';

  @override
  String get podSignHint => 'पाने वाले के हस्ताक्षर';

  @override
  String get podNameHint => 'पाने वाले का नाम';

  @override
  String get podDamageToggle => 'कोई नुकसान या कमी?';

  @override
  String get podDamageRemark => 'टिप्पणी';

  @override
  String get podDamageQty => 'प्रभावित मात्रा';

  @override
  String get podSubmit => 'POD जमा करें';

  @override
  String get podDone => 'POD जमा हो गया';

  @override
  String get earningsPreview => 'कमाई का अनुमान';

  @override
  String get demoOtpHint => 'डेमो OTP: 4321';

  @override
  String get expenseTitle => 'खर्च जोड़ें';

  @override
  String get expenseDiesel => 'डीज़ल';

  @override
  String get expenseToll => 'टोल';

  @override
  String get expenseRepair => 'मरम्मत';

  @override
  String get expenseLoading => 'लोडिंग';

  @override
  String get expensePolice => 'पुलिस/RTO';

  @override
  String get expenseFood => 'खाना';

  @override
  String get expenseOther => 'अन्य';

  @override
  String get amountLabel => 'राशि';

  @override
  String get litresLabel => 'लीटर';

  @override
  String get rateLabel => 'रेट / लीटर';

  @override
  String get billPhotoLabel => 'बिल की फोटो';

  @override
  String get photoCamera => 'कैमरा';

  @override
  String get photoGallery => 'गैलरी';

  @override
  String get billRequired => '₹100 से ऊपर बिल फोटो ज़रूरी है';

  @override
  String get noteHint => 'नोट (वैकल्पिक)';

  @override
  String get voiceNoteAction => 'वॉइस नोट';

  @override
  String get voiceConsentTitle => 'वॉइस नोट रिकॉर्ड करें?';

  @override
  String get voiceConsentMessage =>
      'वॉइस नोट खर्च के साथ सेव होगा और सिंक पर अपलोड होगा।';

  @override
  String get agreeAction => 'सहमत';

  @override
  String get aboveNorm => 'इस रूट के सामान्य से ज़्यादा। Ops जांच कर सकता है।';

  @override
  String get saveAction => 'सेव करें';

  @override
  String get expenseSaved => 'खर्च सेव हो गया';

  @override
  String get expensesTitle => 'खर्च';

  @override
  String get advancesTitle => 'एडवांस';

  @override
  String get requestAdvanceTitle => 'एडवांस मांगें';

  @override
  String get purposeLabel => 'उद्देश्य';

  @override
  String get purposeFuel => 'ईंधन';

  @override
  String get purposeToll => 'टोल';

  @override
  String get purposeRepair => 'मरम्मत';

  @override
  String get purposeFood => 'खाना';

  @override
  String get purposeOther => 'अन्य';

  @override
  String get requestAction => 'मांगें';

  @override
  String get advanceRequested => 'एडवांस मांग लिया गया';

  @override
  String get statusRequested => 'मांगा गया';

  @override
  String get statusApproved => 'स्वीकृत';

  @override
  String get statusPaid => 'भुगतान';

  @override
  String get statusRejected => 'अस्वीकृत';

  @override
  String get earningsTitle => 'कमाई';

  @override
  String get monthTotal => 'इस महीने';

  @override
  String get allowancesTitle => 'ट्रिप भत्ते';

  @override
  String get incentivesLabel => 'प्रोत्साहन';

  @override
  String get settlementTitle => 'हिसाब बैलेंस';

  @override
  String get payableLabel => 'आपको देय';

  @override
  String get recoverableLabel => 'आपसे वसूली';

  @override
  String get slipsTitle => 'सैलरी स्लिप';

  @override
  String get tripsDoneLabel => 'ट्रिप पूरी';

  @override
  String get onTimeLabel => 'समय पर';

  @override
  String get documentsTitle => 'दस्तावेज़';

  @override
  String get docLicence => 'ड्राइविंग लाइसेंस';

  @override
  String get docRc => 'RC';

  @override
  String get docInsurance => 'बीमा';

  @override
  String get docFitness => 'फिटनेस';

  @override
  String get docPermit => 'परमिट';

  @override
  String get docPuc => 'PUC';

  @override
  String expiresInDays(int days) {
    return '$days दिन बचे हैं';
  }

  @override
  String get expiredLabel => 'समाप्त';

  @override
  String get docNumberLabel => 'नंबर';

  @override
  String get sosTitle => 'SOS';

  @override
  String get sosPrompt => 'Ops को सूचित करने के लिए 3 सेकंड दबाकर रखें';

  @override
  String get sosSelectType => 'क्या हुआ?';

  @override
  String get sosBreakdown => 'ब्रेकडाउन';

  @override
  String get sosAccident => 'दुर्घटना';

  @override
  String get sosMedical => 'मेडिकल';

  @override
  String get sosThreat => 'खतरा';

  @override
  String get sosOther => 'अन्य';

  @override
  String get sosSent => 'SOS भेज दिया गया। Ops को सूचित कर दिया गया।';

  @override
  String get sosQueued => 'ऑफ़लाइन - SOS कतार में, अपने आप भेजा जाएगा';

  @override
  String get queueTitle => 'ऑफ़लाइन कतार';

  @override
  String get queueEmpty => 'सब कुछ सिंक है';

  @override
  String get statusPending => 'बाकी';

  @override
  String get statusUploading => 'अपलोड हो रहा';

  @override
  String get statusFailed => 'असफल';

  @override
  String get actionTripStatus => 'ट्रिप स्टेटस';

  @override
  String get actionOffer => 'ट्रिप ऑफर';

  @override
  String get actionPod => 'POD';

  @override
  String get actionExpense => 'खर्च';

  @override
  String get actionAdvance => 'एडवांस';

  @override
  String get actionSos => 'SOS';

  @override
  String get actionGps => 'GPS बैच';

  @override
  String get actionOther => 'सिंक आइटम';

  @override
  String get statusDone => 'हो गया';

  @override
  String get listeningLabel => 'सुन रहे हैं...';

  @override
  String voiceConfirm(String step) {
    return '\'$step\' दर्ज करें?';
  }

  @override
  String get yesAction => 'हां';

  @override
  String get noAction => 'नहीं';

  @override
  String get voiceNotAvailable => 'वॉइस इनपुट अभी उपलब्ध नहीं है';

  @override
  String get voiceCommandsLabel => 'वॉइस कमांड';

  @override
  String get textSizeLabel => 'टेक्स्ट साइज़';

  @override
  String get closeAction => 'बंद करें';

  @override
  String get callAction => 'कॉल करें';

  @override
  String get tripAssigned => 'स्वीकृत';

  @override
  String get tripDelivered => 'डिलीवर';

  @override
  String get tripClosed => 'बंद';

  @override
  String get tripCancelled => 'रद्द';

  @override
  String phaseComingSoon(String phase) {
    return '$phase में आ रहा है';
  }

  @override
  String greeting(String name) {
    return 'नमस्ते, $name';
  }
}
