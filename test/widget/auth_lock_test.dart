import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/features/auth/application/session_provider.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

  group('lock', () {
    testWidgets('locked flag no longer redirects staff to lock page', (
      tester,
    ) async {
      await signInAs(tester, 'Anil Mehta');
      await allowAllPermissions(tester);
      final el = tester.element(find.text('All Branches'));
      ProviderScope.containerOf(
        el,
      ).read(sessionProvider.notifier).setLocked(true);
      await tester.pumpAndSettle();
      expect(find.text('Welcome back'), findsNothing);
      expect(find.text('All Branches'), findsOneWidget);
    });
  });
}
