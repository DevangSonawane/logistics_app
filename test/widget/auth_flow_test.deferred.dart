import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadops/app.dart';
import 'package:roadops/core/offline/offline_action.dart';
import 'package:roadops/core/offline/offline_queue.dart';
import 'package:roadops/core/storage/secure_store.dart';
import 'package:roadops/features/auth/application/session_provider.dart';

import '../helpers/memory_secure_store.dart';
import '../helpers/test_hive.dart';

/// Full Phase 2 auth journeys against the mock repositories.
/// DEFERRED (user decision): parked as .deferred.dart so `flutter test`
/// ignores it. Continue-tap does not flip onboarding in widget tests and
/// one flow hangs - debug after the build phases.
/// Never pumpAndSettle on the OTP page (its resend countdown is periodic).
void main() {
  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await ensureTestHive();
  });
  setUp(clearTestBoxes);

  Future<void> pumpFreshApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          secureStoreProvider.overrideWithValue(memorySecureStore()),
        ],
        child: const RoadOpsApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1400));
    await tester.pumpAndSettle();
  }

  /// Language -> phone entry -> Get OTP -> OTP page.
  Future<void> reachOtp(WidgetTester tester, String phone) async {
    await pumpFreshApp(tester);
    expect(find.text('Choose your language'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Log in with your phone number'), findsOneWidget);
    await tester.enterText(find.byType(TextField), phone);
    await tester.tap(find.text('Get OTP'));
    await tester.pump(const Duration(seconds: 2));
  }

  /// Types the code and lets the mock round-trip finish.
  Future<void> submitOtp(WidgetTester tester, String code) async {
    await tester.enterText(find.byType(TextField).first, code);
    await tester.pump(const Duration(seconds: 2));
  }

  /// Taps through every permission card to the end of the checklist.
  Future<void> allowAllPermissions(WidgetTester tester) async {
    for (int i = 0; i < 8; i++) {
      final Finder allow = find.text('Allow');
      if (allow.evaluate().isEmpty) break;
      await tester.tap(allow);
      await tester.pumpAndSettle();
    }
  }

  group('login', () {
    testWidgets('valid demo number reaches the OTP page', (tester) async {
      await reachOtp(tester, '9000000001');
      expect(find.textContaining('9000000001'), findsOneWidget);
    });

    testWidgets('demo chips autofill the phone field', (tester) async {
      await pumpFreshApp(tester);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Demo accounts'));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Ramesh').first);
      await tester.pump();
      final TextField field =
          tester.widget<TextField>(find.byType(TextField));
      expect(field.controller?.text, '9000000001');
    });

    testWidgets('bad format shows the phone error', (tester) async {
      await reachOtp(tester, '1234567890');
      expect(
        find.text('Enter a valid 10-digit mobile number'),
        findsOneWidget,
      );
    });

    testWidgets('blocked number shows the blocked message', (tester) async {
      await reachOtp(tester, '9000000000');
      expect(
        find.text('Your account is not active. Contact your admin.'),
        findsOneWidget,
      );
    });
  });

  group('otp', () {
    testWidgets('correct OTP signs a driver in to permissions', (
      tester,
    ) async {
      await reachOtp(tester, '9000000001');
      await submitOtp(tester, '123456');
      expect(find.text('We need a few permissions'), findsOneWidget);
    });

    testWidgets('wrong OTP shakes and shows error + attempts left', (
      tester,
    ) async {
      await reachOtp(tester, '9000000001');
      await submitOtp(tester, '000001');
      expect(find.text('Wrong OTP, please try again'), findsOneWidget);
      expect(find.text('4 attempts left'), findsOneWidget);
    });

    testWidgets('expired OTP shows the expired message', (tester) async {
      await reachOtp(tester, '9000000001');
      await submitOtp(tester, '000000');
      expect(
        find.text('This OTP has expired. Request a new one.'),
        findsOneWidget,
      );
    });

    testWidgets('five wrong attempts trigger the 5-minute lockout', (
      tester,
    ) async {
      await reachOtp(tester, '9000000001');
      for (int i = 0; i < 5; i++) {
        await submitOtp(tester, '000001');
      }
      expect(
        find.text('Too many wrong attempts. Try again after 5 min'),
        findsOneWidget,
      );
    });

    testWidgets('resend unlocks after 30 s and restarts the timer', (
      tester,
    ) async {
      await reachOtp(tester, '9000000001');
      expect(find.text('Resend in 30s'), findsOneWidget);
      await tester.pump(const Duration(seconds: 31));
      expect(find.text('Resend OTP'), findsOneWidget);
      await tester.tap(find.text('Resend OTP'));
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Resend in 30s'), findsOneWidget);
    });
  });

  group('role picker', () {
    testWidgets('multi-role user picks a role and continues', (tester) async {
      await reachOtp(tester, '9000000099');
      await submitOtp(tester, '123456');
      expect(find.text('Choose your role'), findsOneWidget);
      await tester.tap(find.text('Ops'));
      await tester.pump();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('We need a few permissions'), findsOneWidget);
    });
  });

  group('permissions + biometric', () {
    testWidgets('driver finishes 6 cards incl. disclosure, lands home', (
      tester,
    ) async {
      await reachOtp(tester, '9000000002');
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      expect(find.text('Namaste, Suresh Patil'), findsOneWidget);
    });

    testWidgets('staff goes through biometric setup to home', (tester) async {
      await reachOtp(tester, '9000000011');
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      expect(find.text('Lock your app'), findsOneWidget);
      await tester.tap(find.text('Enable'));
      await tester.pumpAndSettle();
      expect(find.text('Namaste, Anil Mehta'), findsOneWidget);
    });

    testWidgets('staff can set a 4-digit PIN instead', (tester) async {
      await reachOtp(tester, '9000000051');
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      await tester.tap(find.text('Use PIN instead'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '1111');
      await tester.pump();
      await tester.enterText(find.byType(TextField), '1111');
      await tester.pumpAndSettle();
      expect(find.text('Namaste, Neha Kulkarni'), findsOneWidget);
    });
  });

  group('lock', () {
    testWidgets('locked staff unlocks with the demo PIN', (tester) async {
      await reachOtp(tester, '9000000011');
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      await tester.tap(find.text('Enable'));
      await tester.pumpAndSettle();
      final Element el = tester.element(find.text('Namaste, Anil Mehta'));
      ProviderScope.containerOf(el)
          .read(sessionProvider.notifier)
          .setLocked(true);
      await tester.pumpAndSettle();
      expect(find.text('Welcome back'), findsOneWidget);
      await tester.tap(find.text('Use demo PIN 1234'));
      await tester.pumpAndSettle();
      expect(find.text('Namaste, Anil Mehta'), findsOneWidget);
    });

    testWidgets('wrong PIN is rejected on the lock page', (tester) async {
      await reachOtp(tester, '9000000011');
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      await tester.tap(find.text('Enable'));
      await tester.pumpAndSettle();
      final Element el = tester.element(find.text('Namaste, Anil Mehta'));
      ProviderScope.containerOf(el)
          .read(sessionProvider.notifier)
          .setLocked(true);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '9999');
      await tester.pump();
      expect(find.text('Wrong PIN, try again'), findsOneWidget);
    });
  });

  group('logout blockers', () {
    Future<Element> driverHome(WidgetTester tester, String phone) async {
      await reachOtp(tester, phone);
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      return tester.element(find.textContaining('Namaste'));
    }

    Future<void> confirmLogout(WidgetTester tester) async {
      await tester.tap(find.text('Log out'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Log out').last);
      await tester.pump(const Duration(seconds: 2));
    }

    testWidgets('running trip blocks driver logout', (tester) async {
      await driverHome(tester, '9000000001');
      await confirmLogout(tester);
      expect(
        find.text(
          'You have a running trip. Please complete it or ask Ops to close it before logging out.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('pending sync blocks logout, force logout escapes (demo)', (
      tester,
    ) async {
      final Element el = await driverHome(tester, '9000000002');
      await ProviderScope.containerOf(el)
          .read(offlineQueueProvider.notifier)
          .enqueue(
            OfflineAction(
              id: 'a1',
              type: 'expense_add',
              tripId: 'trip-1',
              payload: const {'amount': 500},
              createdAt: DateTime(2026, 1, 1),
            ),
          );
      await tester.pump();
      await confirmLogout(tester);
      expect(find.textContaining('not uploaded yet'), findsOneWidget);
      await tester.tap(find.text('Force logout (demo)'));
      await tester.pumpAndSettle();
      expect(
        find.text('Log in with your phone number'),
        findsOneWidget,
      );
    });

    testWidgets('staff logout needs only confirmation', (tester) async {
      await reachOtp(tester, '9000000021');
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      await tester.tap(find.text('Enable'));
      await tester.pumpAndSettle();
      await confirmLogout(tester);
      expect(
        find.text('Log in with your phone number'),
        findsOneWidget,
      );
    });
  });

  group('profile', () {
    testWidgets('switch role re-opens the role picker', (tester) async {
      await reachOtp(tester, '9000000099');
      await submitOtp(tester, '123456');
      await tester.tap(find.text('Driver'));
      await tester.pump();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      // Driver skips biometric: permissions then straight home.
      await allowAllPermissions(tester);
      expect(find.text('Namaste, Rajesh Iyer'), findsOneWidget);
      final Element el = tester.element(find.text('Namaste, Rajesh Iyer'));
      GoRouter.of(el).go('/profile');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Switch role'));
      await tester.pumpAndSettle();
      expect(find.text('Choose your role'), findsOneWidget);
    });
  });
}
