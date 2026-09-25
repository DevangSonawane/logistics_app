import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

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
}
