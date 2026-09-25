import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

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
      // Suresh has a trip offer waiting.
      expect(find.text('New trip offer'), findsOneWidget);
      expect(find.text('Parle Products'), findsOneWidget);
    });

    testWidgets('staff goes through biometric setup to home', (tester) async {
      await reachOtp(tester, '9000000011');
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      expect(find.text('Lock your app'), findsOneWidget);
      await tester.tap(find.text('Enable'));
      await tester.pumpAndSettle();
      expect(find.text('All Branches'), findsOneWidget);
    });

    testWidgets('staff can set a 4-digit PIN instead', (tester) async {
      await reachOtp(tester, '9000000051');
      await submitOtp(tester, '123456');
      await allowAllPermissions(tester);
      await tester.tap(find.text('Use PIN instead'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(EditableText), '1111');
      await tester.pump();
      await tester.enterText(find.byType(EditableText), '1111');
      await tester.pumpAndSettle();
      expect(find.text('Accounts summary'), findsOneWidget);
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pump(const Duration(seconds: 1));
    });
  });
}
