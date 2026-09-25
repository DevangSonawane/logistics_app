import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/data/repositories/auth_repository.dart';
import 'package:roadops/data/repositories/mock_auth_repository.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

  group('login', () {
    testWidgets('tapping an account card reaches permissions', (
      tester,
    ) async {
      await signInAs(tester, 'Ramesh Yadav');
      expect(find.text('We need a few permissions'), findsOneWidget);
    });

    testWidgets('all nine demo accounts are listed', (tester) async {
      await pumpFreshApp(tester);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      for (final String name in [
        'Ramesh Yadav',
        'Suresh Patil',
        'Murugan K',
        'Anil Mehta',
        'Priya Nair',
        'Karan Shah',
        'Vijay Gaikwad',
        'Neha Kulkarni',
        'Rajesh Iyer',
      ]) {
        await tester.scrollUntilVisible(find.text(name), 200);
        expect(find.text(name), findsOneWidget);
      }
    });

    test('blocked number throws blocked', () async {
      await expectLater(
        MockAuthRepository().demoSignIn('9000000000'),
        throwsA(
          isA<AuthException>().having(
            (e) => e.failure,
            'failure',
            AuthFailure.blocked,
          ),
        ),
      );
    });

    test('unknown number throws invalidPhone', () async {
      await expectLater(
        MockAuthRepository().demoSignIn('9111111111'),
        throwsA(
          isA<AuthException>().having(
            (e) => e.failure,
            'failure',
            AuthFailure.invalidPhone,
          ),
        ),
      );
    });
  });
}
