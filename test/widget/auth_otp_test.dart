import 'package:flutter_test/flutter_test.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

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
      expect(find.textContaining('Resend in'), findsOneWidget);
      await tester.pump(const Duration(seconds: 31));
      expect(find.text('Resend OTP'), findsOneWidget);
      await tester.tap(find.text('Resend OTP'));
      await tester.pump(const Duration(seconds: 2));
      expect(find.textContaining('Resend in'), findsOneWidget);
    });
  });
}
