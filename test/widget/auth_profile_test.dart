import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

  group('profile', () {
    testWidgets('switch role re-opens the role picker', (tester) async {
      await reachOtp(tester, '9000000099');
      await submitOtp(tester, '123456');
      await tester.tap(find.text('Driver'));
      await tester.pump();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      // Driver skips biometric: permissions then home (empty for Rajesh).
      await allowAllPermissions(tester);
      expect(
        find.text('No trip right now. We\'ll notify you.'),
        findsOneWidget,
      );
      final Element el =
          tester.element(find.text('No trip right now. We\'ll notify you.'));
      GoRouter.of(el).go('/profile');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Switch role'));
      await tester.pumpAndSettle();
      expect(find.text('Choose your role'), findsOneWidget);
    });
  });
}
