import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:roadops/data/repositories/auth_repository.dart';
import 'package:roadops/data/repositories/mock_auth_repository.dart';

import '../helpers/auth_robot.dart';

void main() {
  setUpAll(configureAuthTest);

  group('login', () {
    testWidgets('role pill autofills, sign in reaches driver home', (
      tester,
    ) async {
      await pumpFreshApp(tester);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Driver pill fills the demo phone + password.
      await tester.tap(find.text('Driver').first);
      await tester.pumpAndSettle();
      expect(find.text('Ramesh Yadav · +91 9000000001'), findsOneWidget);

      await tester.tap(find.byKey(const Key('signInSubmit')));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      // No permissions step: Ramesh lands straight on his running trip.
      expect(find.text('Login'), findsNothing);
      expect(find.textContaining('Namaste'), findsOneWidget);
    });

    testWidgets('every role pill autofills a valid demo number', (
      tester,
    ) async {
      await pumpFreshApp(tester);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      const Map<String, String> pills = {
        'Driver': 'Ramesh Yadav · +91 9000000001',
        'Sales': 'Karan Shah · +91 9000000031',
        'Supervisor': 'Vijay Gaikwad · +91 9000000041',
        'Accountant': 'Neha Kulkarni · +91 9000000051',
      };
      expect(find.text('Owner'), findsNothing);
      expect(find.text('Ops'), findsNothing);
      expect(find.text('Owner + Ops'), findsNothing);
      for (final MapEntry<String, String> pill in pills.entries) {
        await tester.tap(find.text(pill.key).first);
        await tester.pumpAndSettle();
        expect(
          find.text(pill.value),
          findsOneWidget,
          reason: '${pill.key} pill should autofill ${pill.value}',
        );
      }
    });

    testWidgets('unknown number shows an error, no navigation', (tester) async {
      await pumpFreshApp(tester);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('loginPhone')), '9111111111');
      await tester.enterText(find.byKey(const Key('loginPassword')), '123456');
      await tester.tap(find.byKey(const Key('signInSubmit')));
      await tester.pump(const Duration(seconds: 2));
      expect(find.textContaining('not registered'), findsOneWidget);
      expect(find.text('Login'), findsNWidgets(2));
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

    test('credentials sign-in accepts the demo password', () async {
      final AuthResult result = await MockAuthRepository()
          .signInWithCredentials(phone: '9000000001', password: '123456');
      expect(result.user.name, 'Ramesh Yadav');
    });
  });
}
