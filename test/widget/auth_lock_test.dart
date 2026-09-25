import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/features/auth/application/session_provider.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

  group('lock', () {
    testWidgets('locked staff unlocks with the demo PIN', (tester) async {
      await signInAs(tester, 'Anil Mehta');
      await allowAllPermissions(tester);
      await tester.tap(find.text('Enable'));
      await tester.pumpAndSettle();
      final Element el = tester.element(find.text('All Branches'));
      ProviderScope.containerOf(el)
          .read(sessionProvider.notifier)
          .setLocked(true);
      await tester.pumpAndSettle();
      expect(find.text('Welcome back'), findsOneWidget);
      await tester.tap(find.text('Use demo PIN 1234'));
      await tester.pumpAndSettle();
      expect(find.text('All Branches'), findsOneWidget);
    });

    testWidgets('wrong PIN is rejected on the lock page', (tester) async {
      await signInAs(tester, 'Anil Mehta');
      await allowAllPermissions(tester);
      await tester.tap(find.text('Enable'));
      await tester.pumpAndSettle();
      final Element el = tester.element(find.text('All Branches'));
      ProviderScope.containerOf(el)
          .read(sessionProvider.notifier)
          .setLocked(true);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(EditableText), '9999');
      await tester.pump();
      expect(find.text('Wrong PIN, try again'), findsOneWidget);
    });
  });
}
