import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadops/app.dart';
import 'package:roadops/core/storage/secure_store.dart';
import 'package:roadops/data/models/app_user.dart';
import 'package:roadops/features/auth/application/session_provider.dart';

import '../helpers/memory_boxes.dart';
import '../helpers/memory_secure_store.dart';

/// Step 1 regression tests: the "zoomed in on real devices" bug must never
/// silently return. System text scale is clamped to 0.9-1.15 app-wide, the
/// driver 1.15x theme multiplier applies only inside driver routes, and key
/// screens render overflow-free at 360dp and 420dp widths.
class _TestSession extends Session {
  _TestSession(this.testState);

  final SessionState testState;

  @override
  SessionState build() => testState;
}

SessionState _driverState() => const SessionState(
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

void main() {
  setUpAll(() async {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<void> setSurface(
    WidgetTester tester,
    Size size,
    double textScale,
  ) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    tester.binding.platformDispatcher.textScaleFactorTestValue =
        textScale;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
      tester.binding.platformDispatcher.clearTextScaleFactorTestValue();
    });
  }

  Future<void> pumpApp(
    WidgetTester tester, {
    SessionState? session,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          secureStoreProvider.overrideWithValue(memorySecureStore()),
          ...memoryBoxOverrides(),
          if (session != null)
            sessionProvider.overrideWith(
              () => _TestSession(session),
            ),
        ],
        child: const RoadOpsApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1400));
    await tester.pumpAndSettle();
    // Logged-out runs start at language select: move to login.
    if (session == null) {
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
    }
  }

  double scalerOf(WidgetTester tester, Finder finder) =>
      MediaQuery.textScalerOf(tester.element(finder)).scale(1.0);

  group('text scale clamp', () {
    testWidgets('360dp at system 1.3 clamps to 1.15, no overflow',
        (tester) async {
      await setSurface(
        tester,
        const Size(360, 640),
        1.3,
      );
      await pumpApp(tester);
      expect(find.text('Log in with your phone number'), findsOneWidget);
      expect(
        scalerOf(tester, find.text('Log in with your phone number')),
        moreOrLessEquals(1.15),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('420dp at system 1.0 stays 1.0, no overflow',
        (tester) async {
      await setSurface(
        tester,
        const Size(420, 900),
        1.0,
      );
      await pumpApp(tester);
      expect(find.text('Log in with your phone number'), findsOneWidget);
      expect(
        scalerOf(tester, find.text('Log in with your phone number')),
        moreOrLessEquals(1.0),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('system 0.8 floors to 0.9', (tester) async {
      await setSurface(
        tester,
        const Size(360, 640),
        0.8,
      );
      await pumpApp(tester);
      expect(
        scalerOf(tester, find.text('Log in with your phone number')),
        moreOrLessEquals(0.9),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('driver theme isolation', () {
    testWidgets('driver routes get the 1.15x text theme', (tester) async {
      await setSurface(
        tester,
        const Size(360, 640),
        1.0,
      );
      await pumpApp(tester, session: _driverState());
      expect(find.text('Namaste, Ramesh Yadav'), findsOneWidget);
      final ThemeData theme = Theme.of(
        tester.element(find.text('Namaste, Ramesh Yadav')),
      );
      // 20 (h2 token) x 1.15 driver multiplier; staff screens stay 20.
      expect(
        theme.textTheme.headlineMedium!.fontSize!,
        moreOrLessEquals(23.0),
      );
      // Builder clamp does not stack: system 1.0 stays 1.0 in driver too.
      expect(
        scalerOf(tester, find.text('Namaste, Ramesh Yadav')),
        moreOrLessEquals(1.0),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('staff screens keep the unscaled text theme',
        (tester) async {
      await setSurface(
        tester,
        const Size(360, 640),
        1.0,
      );
      await pumpApp(tester);
      final ThemeData theme = Theme.of(
        tester.element(find.text('Log in with your phone number')),
      );
      expect(theme.textTheme.headlineMedium!.fontSize, 20);
      expect(tester.takeException(), isNull);
    });
  });
}
