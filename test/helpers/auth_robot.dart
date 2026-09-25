import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadops/app.dart';
import 'package:roadops/core/storage/secure_store.dart';

import 'memory_boxes.dart';
import 'memory_secure_store.dart';

/// Shared robot for auth journey tests. Split across files so each file
/// runs in its own (memory-friendlier) tester process.
Future<void> configureAuthTest() async {
  GoogleFonts.config.allowRuntimeFetching = false;
}

Future<void> pumpFreshApp(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        secureStoreProvider.overrideWithValue(memorySecureStore()),
        ...memoryBoxOverrides(),
      ],
      child: const RoadOpsApp(),
    ),
  );
  await tester.pump(const Duration(milliseconds: 1400));
  await tester.pumpAndSettle();
}

/// Language -> tap a demo account card -> permissions (no OTP).
Future<void> signInAs(WidgetTester tester, String name) async {
  await pumpFreshApp(tester);
  expect(find.text('Choose your language'), findsOneWidget);
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(find.text(name), 200);
  await tester.tap(find.text(name));
  await tester.pump(const Duration(seconds: 2));
}

/// Taps through every permission card to the end of the checklist.
/// The background-location step uses Accept instead of Allow.
Future<void> allowAllPermissions(WidgetTester tester) async {
  for (int i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 200));
    // Stop once we leave the permissions page (driver home also
    // has an Accept button for trip offers).
    if (find.text('We need a few permissions').evaluate().isEmpty) {
      break;
    }
    final Finder allow = find.text('Allow');
    final Finder accept = find.text('Accept');
    if (allow.evaluate().isNotEmpty) {
      await tester.tap(allow);
    } else if (accept.evaluate().isNotEmpty) {
      await tester.tap(accept);
    } else {
      break;
    }
    await tester.pumpAndSettle();
  }
}

/// Profile tab -> scroll to Log out -> confirm dialog.
/// Dialog/opening taps retry once: in FakeAsync, taps landing mid-transition
/// can miss without failing the finder.
Future<void> confirmLogout(WidgetTester tester) async {
  await tester.tap(find.text('Profile'));
  await tester.pumpAndSettle();
  // Bring Log out to a safely tappable spot: fling from a known-free
  // point until its center sits clear of bars and overlays.
  for (int i = 0; i < 6; i++) {
    final Finder target = find.text('Log out');
    if (target.evaluate().isEmpty) {
      await tester.dragFrom(const Offset(400, 300), const Offset(0, -300));
      await tester.pumpAndSettle();
      continue;
    }
    final Offset center = tester.getCenter(target);
    if (center.dy > 200 && center.dy < 400) break;
    await tester.dragFrom(const Offset(400, 300), const Offset(0, -300));
    await tester.pumpAndSettle();
  }
  for (int attempt = 0; attempt < 3; attempt++) {
    // Tap the button (not the label text): the squeezed label's
    // center can miss the hit area.
    final Finder button = find.ancestor(
      of: find.text('Log out'),
      matching: find.byType(ElevatedButton),
    );
    if (button.evaluate().isNotEmpty) {
      await tester.tap(button, warnIfMissed: false);
    } else {
      await tester.tap(find.text('Log out'), warnIfMissed: false);
    }
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 500));
    if (find.byType(AlertDialog).evaluate().isNotEmpty) break;
  }
  await tester.tap(
    find.descendant(
      of: find.byType(AlertDialog),
      matching: find.text('Log out'),
    ),
  );
  await tester.pump(const Duration(seconds: 2));
}

Element containerElement(WidgetTester tester, String text) =>
    tester.element(find.text(text));
