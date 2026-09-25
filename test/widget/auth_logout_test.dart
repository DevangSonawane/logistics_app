import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/core/offline/offline_action.dart';
import 'package:roadops/core/offline/offline_queue.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

  group('logout blockers', () {
    Future<Element> driverHome(WidgetTester tester, String phone) async {
      const Map<String, String> names = {
        '9000000001': 'Ramesh Yadav',
        '9000000002': 'Suresh Patil',
      };
      await signInAs(tester, names[phone] ?? phone);
      await allowAllPermissions(tester);
      await tester.pumpAndSettle();
      return tester.element(find.text('My Trip'));
    }

    // Shared robust helper from the auth robot (scroll + retry +
    // dialog-scoped confirm tap).

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
      await signInAs(tester, 'Priya Nair');
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
}
