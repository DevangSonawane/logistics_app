// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appName => 'RoadOps';

  @override
  String get splashTagline => 'Your logistics companion';

  @override
  String get languageTitle => 'Choose your language';

  @override
  String get languageSubtitle => 'You can change this later in Settings';

  @override
  String get continueAction => 'ಮುಂದುವರಿಸಿ';

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
  String get roleDriver => 'ಚಾಲಕ';

  @override
  String get roleOwner => 'ಮಾಲೀಕ';

  @override
  String get roleOps => 'ಆಪ್ಸ್';

  @override
  String get roleSales => 'ಸೇಲ್ಸ್';

  @override
  String get roleSupervisor => 'ಸೂಪರ್‌ವೈಸರ್';

  @override
  String get roleAccountant => 'ಲೆಕ್ಕಿಗ';

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
  String get acceptAction => 'ಸ್ವೀಕರಿಸಿ';

  @override
  String get denyAction => 'Deny';

  @override
  String get rejectAction => 'ತಿರಸ್ಕರಿಸಿ';

  @override
  String get navigateAction => 'ನ್ಯಾವಿಗೇಟ್ ಮಾಡಿ';

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
  String get cancelAction => 'ರದ್ದುಮಾಡಿ';

  @override
  String get retryAction => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonEmpty => 'Nothing here yet';

  @override
  String get commonError => 'Something went wrong';

  @override
  String get offlineMessage =>
      'ನೀವು ಆಫ್‌ಲೈನ್‌ನಲ್ಲಿದ್ದೀರಿ. ನವೀಕರಣಗಳು ಸ್ವಯಂಚಾಲಿತವಾಗಿ ಸಿಂಕ್ ಆಗುತ್ತವೆ.';

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
  String get otpBackToLogin => 'Back to login';

  @override
  String otpLockout(int minutes) {
    return 'Too many wrong attempts. Try again after $minutes min';
  }

  @override
  String get permissionNext => 'Next';

  @override
  String get permissionDone => 'Done';

  @override
  String get appPinTitle => 'Set a 4-digit app PIN';

  @override
  String get appPinConfirmTitle => 'Confirm your PIN';

  @override
  String get appPinMismatch => 'PINs don\'t match. Try again.';

  @override
  String get pinHint => '4-digit PIN';

  @override
  String get biometricSetupHint => 'Staff only. Drivers skip this step.';

  @override
  String get biometricEnrolled => 'Biometrics enabled';

  @override
  String get unlockAction => 'Unlock';

  @override
  String get wrongPin => 'Wrong PIN, try again';

  @override
  String get unlockWithBio => 'Use fingerprint / face';

  @override
  String get profileTitle => 'Profile';

  @override
  String get switchRole => 'Switch role';

  @override
  String appVersion(String version) {
    return 'App version $version';
  }

  @override
  String get demoTools => 'Demo tools';

  @override
  String get demoSampleNotification => 'Trigger sample notification';

  @override
  String get demoAdvanceTrip => 'Advance trip simulation';

  @override
  String get simulateOffline => 'Simulate offline';

  @override
  String get resetDemoData => 'Reset demo data';

  @override
  String get demoActionDone => 'Done';

  @override
  String get logoutRunningTrip =>
      'You have a running trip. Please complete it or ask Ops to close it before logging out.';

  @override
  String logoutPendingSync(int count) {
    return '$count items are not uploaded yet. Connect to the internet and sync before logging out.';
  }

  @override
  String get forceLogout => 'Force logout (demo)';

  @override
  String get roleContinueAs => 'Continue';

  @override
  String get lastUsedRole => 'Last used';

  @override
  String get tabMyTrip => 'My Trip';

  @override
  String get tabEarnings => 'Earnings';

  @override
  String get tabDocuments => 'Documents';

  @override
  String get tabProfile => 'Profile';

  @override
  String get noTripTitle => 'No trip right now. We\'ll notify you.';

  @override
  String get offerTitle => 'New trip offer';

  @override
  String get pickupLabel => 'Pickup';

  @override
  String get dropLabel => 'Drop';

  @override
  String get freightLabel => 'Freight allowance';

  @override
  String get pickupByLabel => 'Pickup by';

  @override
  String get rejectTitle => 'Reject trip';

  @override
  String get rejectReasonLabel => 'Reason (required)';

  @override
  String get rejectVehicle => 'Vehicle issue';

  @override
  String get rejectHealth => 'Health';

  @override
  String get rejectPersonal => 'Personal';

  @override
  String get rejectRoute => 'Route not known';

  @override
  String get rejectOther => 'Other';

  @override
  String get rejectNoteHint => 'Details (optional)';

  @override
  String get submitAction => 'Submit';

  @override
  String get lrEwayLabel => 'LR / E-way bill';

  @override
  String get addExpenseAction => 'Add Expense';

  @override
  String get requestAdvanceAction => 'Request Advance';

  @override
  String get stepReachedPickup => 'Reached Pickup';

  @override
  String get stepLoadingDone => 'Loading Done';

  @override
  String get stepStartTrip => 'Start Trip';

  @override
  String get stepReachedDrop => 'Reached Drop';

  @override
  String get stepUnloaded => 'Unloaded';

  @override
  String get slideHint => 'Slide to confirm';

  @override
  String get photoRequired => 'A photo is required for this step';

  @override
  String get stepDone => 'Status updated';

  @override
  String get stepQueued => 'Offline - will sync automatically';

  @override
  String get conflictTitle => 'Trip changed';

  @override
  String get conflictMessage =>
      'Ops changed this trip. Your action was rejected and the trip was refreshed.';

  @override
  String get okAction => 'OK';

  @override
  String get timelineTitle => 'Timeline';

  @override
  String get podPromptTitle => 'Trip unloaded - capture POD';

  @override
  String get podPromptAction => 'Capture POD';

  @override
  String get callOps => 'Call Ops';

  @override
  String get opsAlerted => 'Ops has been alerted';

  @override
  String get trackingOn => 'GPS tracking on';

  @override
  String get advanceBalance => 'Advance balance';

  @override
  String get podTitle => 'Proof of Delivery';

  @override
  String get podStep1 => 'Photo of the signed LR';

  @override
  String get podStep2 => 'Consignee confirmation';

  @override
  String get podOtpHint => '4-digit OTP with consignee';

  @override
  String get podOtpWrong => 'Wrong consignee OTP';

  @override
  String get podOr => 'OR';

  @override
  String get podSignHint => 'Consignee e-signature';

  @override
  String get podNameHint => 'Consignee name';

  @override
  String get podDamageToggle => 'Any damage or shortage?';

  @override
  String get podDamageRemark => 'Remark';

  @override
  String get podDamageQty => 'Quantity affected';

  @override
  String get podSubmit => 'Submit POD';

  @override
  String get podDone => 'POD submitted';

  @override
  String get earningsPreview => 'Earnings preview';

  @override
  String get demoOtpHint => 'Demo consignee OTP: 4321';

  @override
  String get expenseTitle => 'Add Expense';

  @override
  String get expenseDiesel => 'Diesel';

  @override
  String get expenseToll => 'Toll';

  @override
  String get expenseRepair => 'Repair';

  @override
  String get expenseLoading => 'Loading';

  @override
  String get expensePolice => 'Police/RTO';

  @override
  String get expenseFood => 'Food';

  @override
  String get expenseOther => 'Other';

  @override
  String get amountLabel => 'Amount';

  @override
  String get litresLabel => 'Litres';

  @override
  String get rateLabel => 'Rate (Rs.)';

  @override
  String get billPhotoLabel => 'Bill photo';

  @override
  String get photoCamera => 'Camera';

  @override
  String get photoGallery => 'Gallery';

  @override
  String get billRequired => 'Bill photo is required above Rs.100';

  @override
  String get noteHint => 'Note (optional)';

  @override
  String get voiceNoteAction => 'Voice note';

  @override
  String get voiceConsentTitle => 'Record a voice note?';

  @override
  String get voiceConsentMessage =>
      'Voice notes are stored with the expense and uploaded on sync.';

  @override
  String get agreeAction => 'Agree';

  @override
  String get aboveNorm => 'Above usual for this route. Ops may review.';

  @override
  String get saveAction => 'Save';

  @override
  String get expenseSaved => 'Expense saved';

  @override
  String get expensesTitle => 'Expenses';

  @override
  String get advancesTitle => 'Advances';

  @override
  String get requestAdvanceTitle => 'Request Advance';

  @override
  String get purposeLabel => 'Purpose';

  @override
  String get purposeFuel => 'Fuel';

  @override
  String get purposeToll => 'Toll';

  @override
  String get purposeRepair => 'Repair';

  @override
  String get purposeFood => 'Food';

  @override
  String get purposeOther => 'Other';

  @override
  String get requestAction => 'Request';

  @override
  String get advanceRequested => 'Advance requested';

  @override
  String get statusRequested => 'Requested';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get earningsTitle => 'Earnings';

  @override
  String get monthTotal => 'This month';

  @override
  String get allowancesTitle => 'Trip allowances';

  @override
  String get incentivesLabel => 'Incentives';

  @override
  String get settlementTitle => 'Settlement balance';

  @override
  String get payableLabel => 'Payable to you';

  @override
  String get recoverableLabel => 'Recoverable from you';

  @override
  String get slipsTitle => 'Salary slips';

  @override
  String get tripsDoneLabel => 'Trips done';

  @override
  String get onTimeLabel => 'On-time';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get docLicence => 'Driving Licence';

  @override
  String get docRc => 'RC';

  @override
  String get docInsurance => 'Insurance';

  @override
  String get docFitness => 'Fitness';

  @override
  String get docPermit => 'Permit';

  @override
  String get docPuc => 'PUC';

  @override
  String expiresInDays(int days) {
    return '$days days left';
  }

  @override
  String get expiredLabel => 'Expired';

  @override
  String get docNumberLabel => 'Number';

  @override
  String get sosTitle => 'SOS';

  @override
  String get sosPrompt => 'Press and hold for 3 seconds to alert Ops';

  @override
  String get sosSelectType => 'What happened?';

  @override
  String get sosBreakdown => 'Breakdown';

  @override
  String get sosAccident => 'Accident';

  @override
  String get sosMedical => 'Medical';

  @override
  String get sosThreat => 'Threat';

  @override
  String get sosOther => 'Other';

  @override
  String get sosSent => 'SOS sent. Ops has been alerted.';

  @override
  String get sosQueued => 'Offline - SOS queued and will send automatically';

  @override
  String get queueTitle => 'Offline queue';

  @override
  String get queueEmpty => 'Everything is synced';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusUploading => 'Uploading';

  @override
  String get statusFailed => 'Failed';

  @override
  String get actionTripStatus => 'Trip status';

  @override
  String get actionOffer => 'Trip offer';

  @override
  String get actionPod => 'POD';

  @override
  String get actionExpense => 'Expense';

  @override
  String get actionAdvance => 'Advance';

  @override
  String get actionSos => 'SOS';

  @override
  String get actionGps => 'GPS batch';

  @override
  String get actionOther => 'Sync item';

  @override
  String get statusDone => 'Done';

  @override
  String get listeningLabel => 'Listening...';

  @override
  String voiceConfirm(String step) {
    return 'Mark \'$step\'?';
  }

  @override
  String get yesAction => 'Yes';

  @override
  String get noAction => 'No';

  @override
  String get voiceNotAvailable => 'Voice input is not available right now';

  @override
  String get voiceCommandsLabel => 'Voice commands';

  @override
  String get textSizeLabel => 'Text size';

  @override
  String get closeAction => 'Close';

  @override
  String get callAction => 'Call';

  @override
  String get viewDetails => 'View details';

  @override
  String get balanceLabel => 'Balance';

  @override
  String get tripsLabel => 'trips';

  @override
  String get doneAction => 'Done';

  @override
  String get addAction => 'Add';

  @override
  String get ownerTabDashboard => 'Dashboard';

  @override
  String get ownerTabApprovals => 'Approvals';

  @override
  String get ownerTabAccounts => 'Accounts';

  @override
  String get ownerTabMap => 'Live Map';

  @override
  String get branchAll => 'All Branches';

  @override
  String get revenueMonth => 'Revenue this month';

  @override
  String get revenueToday => 'Revenue today';

  @override
  String get revenueWeek => 'Revenue last 7 days';

  @override
  String get todayLabel => 'Today';

  @override
  String get range7d => '7D';

  @override
  String get rangeMonth => 'Month';

  @override
  String get tripsToday => 'Trips today';

  @override
  String get collectionsMonth => 'Collections';

  @override
  String get outstandingLabel => 'Outstanding';

  @override
  String get cashBankLabel => 'Cash & Bank';

  @override
  String get utilisationLabel => 'Fleet utilisation';

  @override
  String get trendTitle => 'Revenue vs collection';

  @override
  String get topLanesTitle => 'Top lanes by margin';

  @override
  String get bottomCustomersTitle => 'Watchlist';

  @override
  String get attentionTitle => 'Needs attention';

  @override
  String get briefTitle => 'AI brief';

  @override
  String get readFullBrief => 'Read full brief';

  @override
  String get askTitle => 'Ask your data';

  @override
  String get askHint => 'e.g. Which customer gave the lowest margin?';

  @override
  String get approvalsTitle => 'Approvals';

  @override
  String get filterAll => 'All';

  @override
  String get approvalAdvance => 'Advances';

  @override
  String get approvalExpense => 'Expenses';

  @override
  String get approvalRate => 'Rate exceptions';

  @override
  String get approvalCredit => 'Credit override';

  @override
  String get approvalVendor => 'Vendor payments';

  @override
  String get approvalPurchase => 'Purchase';

  @override
  String get approveAction => 'Approve';

  @override
  String get askInfoAction => 'Ask for info';

  @override
  String get commentHint => 'Comment';

  @override
  String get commentRequired => 'A comment is required to reject';

  @override
  String get approvedMsg => 'Approved';

  @override
  String get rejectedMsg => 'Rejected';

  @override
  String get infoAskedMsg => 'Info requested from the requester';

  @override
  String get undoAction => 'Undo';

  @override
  String get emptyApprovals => 'You\'re all caught up';

  @override
  String get createdLabel => 'Raised';

  @override
  String get accountsTitle => 'Accounts';

  @override
  String get customerLedgerTitle => 'Customer ledger';

  @override
  String get vendorLedgerTitle => 'Vendor ledger';

  @override
  String get ageingTitle => 'Ageing';

  @override
  String get pnlTitle => 'Profit & Loss';

  @override
  String get daybookTitle => 'Day book';

  @override
  String get bankBalancesTitle => 'Bank balances';

  @override
  String get gstSummaryTitle => 'GST summary';

  @override
  String get tripPnlTitle => 'Trip P&L';

  @override
  String get searchHint => 'Search';

  @override
  String get sharePdf => 'Share PDF';

  @override
  String get selectCustomer => 'Select a customer';

  @override
  String get customerLabel => 'Customer';

  @override
  String get groupBranch => 'Branch';

  @override
  String get groupVehicle => 'Vehicle';

  @override
  String get groupCustomer => 'Customer';

  @override
  String get groupLane => 'Lane';

  @override
  String get liveMapTitle => 'Live map';

  @override
  String get exceptionsFilter => 'Exceptions';

  @override
  String get noGpsKey =>
      'Map key not configured - showing the trip list. Nothing crashes.';

  @override
  String get shareWhatsapp => 'Share on WhatsApp';

  @override
  String get briefMoney => 'Money';

  @override
  String get briefRisks => 'Risks';

  @override
  String get alertSettingsTitle => 'Notification settings';

  @override
  String get alertPay => 'Large payment received';

  @override
  String get alertDelay => 'Big delay';

  @override
  String get alertDoc => 'Document expiring';

  @override
  String get alertCredit => 'Credit limit crossed';

  @override
  String get channelPush => 'Push';

  @override
  String get channelWa => 'WhatsApp';

  @override
  String get channelApp => 'In-app';

  @override
  String get opsTabOrders => 'Orders';

  @override
  String get opsTabPlan => 'Plan';

  @override
  String get opsTabTrips => 'Live Trips';

  @override
  String get opsTabExceptions => 'Exceptions';

  @override
  String get ordersTitle => 'Orders';

  @override
  String get orderPending => 'Pending';

  @override
  String get orderPlanned => 'Planned';

  @override
  String get orderRunning => 'Running';

  @override
  String get orderCompleted => 'Completed';

  @override
  String get orderCancelled => 'Cancelled';

  @override
  String get newOrder => 'New order';

  @override
  String get orderTypeLabel => 'Type';

  @override
  String get orderTypeFtl => 'FTL';

  @override
  String get orderTypePtl => 'PTL';

  @override
  String get vehicleTypeLabel => 'Vehicle type';

  @override
  String get commodityLabel => 'Commodity';

  @override
  String get weightLabel => 'Weight (kg)';

  @override
  String get declaredValueLabel => 'Declared value (Rs.)';

  @override
  String get stopsLabel => 'Stops';

  @override
  String get planTripAction => 'Plan';

  @override
  String get planTitle => 'Plan trip';

  @override
  String get stepCustomer => 'Customer';

  @override
  String get stepRoute => 'Route';

  @override
  String get stepCargo => 'Cargo';

  @override
  String get stepRate => 'Rate';

  @override
  String get pickupPoint => 'Pickup point';

  @override
  String get dropPoint => 'Drop point';

  @override
  String get neededByLabel => 'Needed by';

  @override
  String get pickDate => 'Pick date';

  @override
  String get pasteWhatsapp => 'Paste WhatsApp message';

  @override
  String get pasteHint => 'e.g. 2 trucks 32 ft Pune to Chennai tomorrow';

  @override
  String get aiFilled => 'AI filled - please verify';

  @override
  String get contractRate => 'Contract rate';

  @override
  String get belowContract => 'Below contract rate - needs approval';

  @override
  String get createOrder => 'Create order';

  @override
  String get orderCreated => 'Order created';

  @override
  String get planStepOrder => 'Order';

  @override
  String get planStepVehicle => 'Vehicle';

  @override
  String get planStepDriver => 'Driver';

  @override
  String get planStepSummary => 'Summary';

  @override
  String get docsValid => 'Docs valid';

  @override
  String get docsInvalid => 'Docs invalid';

  @override
  String get onTripBlock => 'Already on a trip';

  @override
  String get licenceInvalid => 'Licence invalid';

  @override
  String get routeKm => 'Route distance';

  @override
  String get tollEst => 'Toll estimate';

  @override
  String get dieselEst => 'Diesel estimate';

  @override
  String get etaLabel => 'ETA';

  @override
  String get advanceOptional => 'Advance (optional)';

  @override
  String get assignAction => 'Assign & notify driver';

  @override
  String get assignedMsg => 'Trip assigned and driver notified:';

  @override
  String get returnLoadTitle => 'Return load nearby';

  @override
  String returnLoadBody(String place) {
    return '2 loads available near $place. Ask the driver before they head back empty.';
  }

  @override
  String get liveTripsTitle => 'Live trips';

  @override
  String get listTab => 'List';

  @override
  String get mapTab => 'Map';

  @override
  String get controlTitle => 'Trip control';

  @override
  String get callDriver => 'Call driver';

  @override
  String get updateStatusAction => 'Update status';

  @override
  String get reasonRequired => 'A reason is required';

  @override
  String get raiseAdvanceAction => 'Raise advance';

  @override
  String get advanceRaised => 'Advance request raised';

  @override
  String get ewayLabel => 'E-way bill no.';

  @override
  String get shareTracking => 'Share tracking';

  @override
  String get exceptionsTitle => 'Exceptions';

  @override
  String get noExceptions => 'All clear - no open exceptions';

  @override
  String get exDelay => 'Delay';

  @override
  String get exHalt => 'Long halt';

  @override
  String get exDeviation => 'Route deviation';

  @override
  String get exOverspeed => 'Overspeed';

  @override
  String get exDeviceOff => 'Device off';

  @override
  String get exEway => 'E-way expiring';

  @override
  String get exPod => 'POD pending';

  @override
  String get extendEway => 'Extend e-way';

  @override
  String get ewayExtended => 'E-way bill extended';

  @override
  String get escalateAction => 'Escalate';

  @override
  String get resolveAction => 'Resolve';

  @override
  String get marketTitle => 'Market vehicles';

  @override
  String get knownVehicles => 'Known broker vehicles';

  @override
  String get addVehicleTitle => 'Add broker vehicle';

  @override
  String get vehicleNoLabel => 'Vehicle no.';

  @override
  String get vehicleNoError => 'Enter a valid vehicle no. e.g. MH 12 AB 1234';

  @override
  String get ownerNameLabel => 'Owner name';

  @override
  String get panLabel => 'PAN';

  @override
  String get panError => 'Enter a valid PAN e.g. AAKCS1234F';

  @override
  String get driverNameLabel => 'Driver name';

  @override
  String get fillAllFields => 'Please fill all required fields';

  @override
  String get kycPhotos => 'KYC photos';

  @override
  String get memoTitle => 'Hire memo';

  @override
  String get freightAgreed => 'Freight agreed';

  @override
  String get deductionsLabel => 'Deductions';

  @override
  String get balanceOnPod => 'Balance on POD';

  @override
  String get payAdvanceAction => 'Pay advance';

  @override
  String get approvalRaised => 'Above limit - approval raised';

  @override
  String get paidMsg => 'Advance paid';

  @override
  String get centreTitle => 'Notifications';

  @override
  String get todayGroup => 'Today';

  @override
  String get earlierGroup => 'Earlier';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get noNotifications => 'No notifications yet';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchTrips => 'Trips';

  @override
  String get searchLrs => 'LRs';

  @override
  String get searchVehicles => 'Vehicles';

  @override
  String get searchCustomers => 'Customers';

  @override
  String get noResults => 'No results found';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get biometricLabel => 'Biometric unlock';

  @override
  String get aboutLabel => 'About';

  @override
  String get salesTabLeads => 'Leads';

  @override
  String get salesTabVisits => 'Visits';

  @override
  String get salesTabQuote => 'Quote';

  @override
  String get salesTabCustomers => 'Customers';

  @override
  String get leadsTitle => 'Leads';

  @override
  String get addLeadAction => 'Add lead';

  @override
  String slaDueIn(String left) {
    return 'Due in $left';
  }

  @override
  String slaOverdue(String left) {
    return 'Overdue $left';
  }

  @override
  String get stageFresh => 'New';

  @override
  String get stageContacted => 'Contacted';

  @override
  String get stageQuoted => 'Quoted';

  @override
  String get stageNegotiation => 'Negotiation';

  @override
  String get stageWon => 'Won';

  @override
  String get stageLost => 'Lost';

  @override
  String get srcWebsite => 'Website';

  @override
  String get srcWhatsapp => 'WhatsApp';

  @override
  String get srcIndiamart => 'IndiaMART';

  @override
  String get srcJustdial => 'Justdial';

  @override
  String get srcIvr => 'IVR';

  @override
  String get srcEmail => 'Email';

  @override
  String get srcWalkin => 'Walk-in';

  @override
  String get srcReferral => 'Referral';

  @override
  String get companyLabel => 'Company';

  @override
  String get contactLabel => 'Contact person';

  @override
  String get sourceLabel => 'Source';

  @override
  String get fromLabel => 'From';

  @override
  String get toLabel => 'To';

  @override
  String get tripsPerMonth => 'Trips / month';

  @override
  String get targetRateLabel => 'Target rate';

  @override
  String get notesLabel => 'Notes';

  @override
  String get voiceTranscribed => 'voice note transcribed';

  @override
  String get scanCardAction => 'Scan card';

  @override
  String get cardScanned => 'Card scanned - verify the fields';

  @override
  String get duplicateLead => 'This phone already exists - possible duplicate';

  @override
  String get saveLeadAction => 'Save lead';

  @override
  String get moveToStage => 'Move to';

  @override
  String get addLeadTitle => 'Add lead';

  @override
  String get visitsTitle => 'Visits';

  @override
  String get checkInAction => 'Check in';

  @override
  String get checkInTitle => 'Visit check-in';

  @override
  String get visitCustomerLabel => 'Customer';

  @override
  String get checkinPhoto => 'Site photo';

  @override
  String get photoRetake => 'Retake photo';

  @override
  String get outcomeLabel => 'Outcome';

  @override
  String get checkOutAction => 'Check out';

  @override
  String get visitDone => 'Done';

  @override
  String get visitActive => 'Active';

  @override
  String get visitPlanned => 'Planned';

  @override
  String get quoteTitle => 'Quote';

  @override
  String get perTonRate => 'Per ton';

  @override
  String get noRateCard => 'No rate card for this lane';

  @override
  String get chargeDetention => 'Detention';

  @override
  String get chargeLoading => 'Loading';

  @override
  String get chargeOda => 'ODA';

  @override
  String get chargeMultiDrop => 'Multi-drop';

  @override
  String get needsApproval => 'Needs approval';

  @override
  String get quoteTotal => 'Quote total';

  @override
  String get quotePreviewAction => 'Preview quote';

  @override
  String get sendWhatsapp => 'Send via WhatsApp';

  @override
  String get customersTitle => 'Customers';

  @override
  String get remindPayment => 'Remind payment';

  @override
  String get reminderSent => 'Reminder sent';

  @override
  String reminderTemplate(String name, String amount) {
    return 'Namaste $name, Rs.$amount is due to Shree Ganesh Roadlines. Please pay at the earliest.';
  }

  @override
  String get targetsTitle => 'Targets';

  @override
  String get targetRevenue => 'Revenue (L)';

  @override
  String get targetCustomers => 'New customers';

  @override
  String get targetTrips => 'Trips';

  @override
  String get leaderboardTitle => 'Leaderboard';

  @override
  String get superTabToday => 'Today';

  @override
  String get superTabGate => 'Gate';

  @override
  String get superTabScan => 'Scan';

  @override
  String get superTabManifest => 'Manifest';

  @override
  String get todayTitle => 'Today';

  @override
  String get loadingsTab => 'Loadings';

  @override
  String get arrivalsTab => 'Arrivals';

  @override
  String get hubPending => 'Pending';

  @override
  String get hubInProgress => 'In progress';

  @override
  String get hubDone => 'Done';

  @override
  String get gateTitle => 'Gate';

  @override
  String get selectVehicle => 'Select vehicle';

  @override
  String get gateInAction => 'Gate in';

  @override
  String get gateOutAction => 'Gate out';

  @override
  String gateEarly(String span) {
    return 'Early by $span';
  }

  @override
  String gateLate(String span) {
    return 'Late by $span';
  }

  @override
  String get loadingTitle => 'Loading';

  @override
  String get loadingStartPhoto => 'Start photo';

  @override
  String get loadingEndPhoto => 'End photo';

  @override
  String get sealNoLabel => 'Seal number';

  @override
  String get weighmentSlip => 'Weighment slip';

  @override
  String get weightMismatch =>
      'Weight differs from declared - will be reviewed';

  @override
  String get completeLoading => 'Complete loading';

  @override
  String get loadingComplete => 'Loading completed';

  @override
  String get scanTitle => 'Scan packages';

  @override
  String get scannedLabel => 'Scanned';

  @override
  String get duplicateScan => 'Already scanned';

  @override
  String get scannerUnavailable => 'Scanner unavailable on this device';

  @override
  String get markDamage => 'Damage';

  @override
  String get markShortage => 'Shortage';

  @override
  String get createManifest => 'Create manifest';

  @override
  String get manifestTitle => 'Manifest';

  @override
  String get destHubLabel => 'Destination hub';

  @override
  String get lrPrintTitle => 'LR print';

  @override
  String get printAction => 'Print';

  @override
  String get bluetoothPrinter => 'Bluetooth printer';

  @override
  String get bluetoothSoon => 'Bluetooth printer coming soon';

  @override
  String get scanToManifest => 'Scan packages to build a manifest';

  @override
  String get acctTabSummary => 'Summary';

  @override
  String get acctTabLedgers => 'Ledgers';

  @override
  String get acctTabInvoices => 'Invoices';

  @override
  String get acctTabApprovals => 'Approvals';

  @override
  String get acctSummaryTitle => 'Accounts summary';

  @override
  String get receivablesLabel => 'Receivables';

  @override
  String get payablesLabel => 'Payables';

  @override
  String get readyToBill => 'Ready to bill';

  @override
  String get invoicesTitle => 'Invoices';

  @override
  String get invDraft => 'Draft';

  @override
  String get invSent => 'Sent';

  @override
  String get invPartPaid => 'Part-paid';

  @override
  String get invPaid => 'Paid';

  @override
  String get invOverdue => 'Overdue';

  @override
  String get dueLabel => 'Due';

  @override
  String get paidLabel => 'Paid';

  @override
  String get viewPdf => 'View PDF';

  @override
  String get recordReceiptTitle => 'Record receipt';

  @override
  String get receiptNotAllowed => 'Your role cannot record receipts';

  @override
  String get receiptSaved => 'Receipt recorded';

  @override
  String get utrLabel => 'UTR';

  @override
  String get tdsLabel => 'TDS deducted';

  @override
  String get shortPayLabel => 'Short-pay reason';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String get payLikely => 'Likely to pay in 3 days';

  @override
  String get limitForwarded =>
      'Above your Rs.50,000 limit - forwarded to Owner';

  @override
  String get tripAssigned => 'Assigned';

  @override
  String get tripDelivered => 'Delivered';

  @override
  String get tripClosed => 'Closed';

  @override
  String get tripCancelled => 'Cancelled';

  @override
  String phaseComingSoon(String phase) {
    return 'Coming in $phase';
  }

  @override
  String greeting(String name) {
    return 'ನಮಸ್ಕಾರ, $name';
  }
}
