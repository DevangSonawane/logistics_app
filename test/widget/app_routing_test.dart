import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadops/app.dart';
import 'package:roadops/core/l10n/app_localizations.dart';
import 'package:roadops/core/theme/app_colors.dart';
import 'package:roadops/core/widgets/amount_text.dart';
import 'package:roadops/core/widgets/app_button.dart';
import 'package:roadops/core/widgets/empty_state.dart';
import 'package:roadops/core/widgets/error_state.dart';
import 'package:roadops/core/widgets/status_chip.dart';
import 'package:roadops/data/models/app_user.dart';
import 'package:roadops/features/auth/application/session_provider.dart';

import '../helpers/test_hive.dart';

/// Test session that skips Hive restore and returns a fixed state.
class TestSession extends Session {
  TestSession(this.testState);

  final SessionState testState;

  @override
  SessionState build() => testState;
}

Widget _l10nWrap(Widget child) {
  return MaterialApp(
    supportedLocales: const [Locale('en')],
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );
}

void main() {
  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await ensureTestHive();
  });
  setUp(clearTestBoxes);

  group('design-system widgets', () {
    testWidgets('StatusChip shows label', (tester) async {
      await tester.pumpWidget(
        _l10nWrap(
          const StatusChip(label: 'Running', color: AppColors.primary),
        ),
      );
      expect(find.text('Running'), findsOneWidget);
    });

    testWidgets('AppButton shows label and reacts to tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        _l10nWrap(
          AppButton(label: 'Continue', onPressed: () => tapped = true),
        ),
      );
      await tester.tap(find.text('Continue'));
      expect(tapped, isTrue);
    });

    testWidgets('AmountText uses Indian grouping', (tester) async {
      await tester.pumpWidget(_l10nWrap(const AmountText(1234567)));
      expect(find.text('\u20B912,34,567'), findsOneWidget);
    });

    testWidgets('EmptyState retry calls back', (tester) async {
      bool retried = false;
      await tester.pumpWidget(
        _l10nWrap(
          ErrorState(message: 'No network', onRetry: () => retried = true),
        ),
      );
      await tester.tap(find.text('Retry'));
      expect(retried, isTrue);
    });

    testWidgets('EmptyState shows title and message', (tester) async {
      await tester.pumpWidget(
        _l10nWrap(
          const EmptyState(title: 'All done', message: 'Nothing pending'),
        ),
      );
      expect(find.text('All done'), findsOneWidget);
      expect(find.text('Nothing pending'), findsOneWidget);
    });
  });

  group('role-guarded routing', () {
    SessionState driverState() => const SessionState(
          onboardingDone: true,
          loggedIn: true,
          user: AppUser(
            id: 'u-driver-1',
            name: 'Ramesh Yadav',
            phone: '9000000001',
            roles: [AppRole.driver],
            branchIds: ['br-pune'],
            language: 'hi',
          ),
          activeRole: AppRole.driver,
          permissionsDone: true,
        );

    Future<void> pumpApp(WidgetTester tester, SessionState state) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sessionProvider.overrideWith(() => TestSession(state)),
          ],
          child: const RoadOpsApp(),
        ),
      );
      // Splash holds 1.2 s, then the guard routes onward.
      await tester.pump(const Duration(milliseconds: 1400));
      await tester.pumpAndSettle();
    }

    testWidgets('driver lands on driver home', (tester) async {
      await pumpApp(tester, driverState());
      expect(find.text('Namaste, Ramesh Yadav'), findsOneWidget);
      expect(find.textContaining('Phase 3'), findsOneWidget);
    });

    testWidgets('driver cannot open owner routes (403)', (tester) async {
      await pumpApp(tester, driverState());
      final Element el = tester.element(find.textContaining('Phase 3'));
      GoRouter.of(el).go('/owner/home');
      await tester.pumpAndSettle();
      expect(find.text('Not allowed'), findsOneWidget);
    });

    testWidgets('logged-out user is sent to login', (tester) async {
      await pumpApp(
        tester,
        const SessionState(onboardingDone: true),
      );
      expect(find.text('Log in with your phone number'), findsOneWidget);
    });

    testWidgets('fresh install starts at language select', (tester) async {
      await pumpApp(tester, const SessionState());
      expect(find.text('Choose your language'), findsOneWidget);
    });
  });
}
