import 'package:flutter_test/flutter_test.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

  group('role picker', () {
    testWidgets('multi-role user picks a role and continues', (tester) async {
      await signInAs(tester, 'Rajesh Iyer');
      expect(find.text('Choose your role'), findsOneWidget);
      await tester.tap(find.text('Ops'));
      await tester.pump();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('Lock your app'), findsNothing);
      expect(find.text('Orders'), findsWidgets);
      await tester.pump(const Duration(seconds: 1));
    });
  });

  group('permissions + biometric', () {
    testWidgets('driver skips permissions and lands home', (tester) async {
      await signInAs(tester, 'Suresh Patil');
      await allowAllPermissions(tester);
      // Suresh has a trip offer waiting.
      expect(find.text('New trip offer'), findsOneWidget);
      expect(find.text('Parle Products'), findsOneWidget);
    });

    testWidgets('staff lands directly on home', (tester) async {
      await signInAs(tester, 'Anil Mehta');
      await allowAllPermissions(tester);
      expect(find.text('Lock your app'), findsNothing);
      expect(find.text('All Branches'), findsOneWidget);
    });

    testWidgets('accountant lands directly on home', (tester) async {
      await signInAs(tester, 'Neha Kulkarni');
      await allowAllPermissions(tester);
      expect(find.text('Lock your app'), findsNothing);
      expect(find.text('Accounts summary'), findsOneWidget);
    });
  });
}
