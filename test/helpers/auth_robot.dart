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

/// Demo phones per account name for the simple login form.
const Map<String, String> demoPhones = {
  'Ramesh Yadav': '9000000001',
  'Suresh Patil': '9000000002',
  'Murugan K': '9000000003',
  'Anil Mehta': '9000000011',
  'Priya Nair': '9000000021',
  'Karan Shah': '9000000031',
  'Vijay Gaikwad': '9000000041',
  'Neha Kulkarni': '9000000051',
  'Rajesh Iyer': '9000000099',
};

/// Language -> fill the login form (phone + demo password) -> Sign In.
/// No OTP: the form signs straight in and the guard routes onward.
Future<void> signInAs(WidgetTester tester, String name) async {
  await pumpFreshApp(tester);
  expect(find.text('Choose your language'), findsOneWidget);
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
  await tester.enterText(
    find.byKey(const Key('loginPhone')),
    demoPhones[name] ?? name,
  );
  await tester.enterText(
    find.byKey(const Key('loginPassword')),
    '123456',
  );
  await tester.tap(find.byKey(const Key('signInSubmit')));
  await tester.pump(const Duration(seconds: 2));
}

/// Permissions step was removed from the flow; login lands directly on
/// the role home (or biometric setup for staff). Kept as a no-op so
/// existing journey tests keep compiling.
Future<void> allowAllPermissions(WidgetTester tester) async {
  await tester.pumpAndSettle();
}

/// Opens the profile tab. Bottom nav is icons-only, so tap the profile
/// icon (person in most shells, overflow in owner).
Future<void> openProfileTab(WidgetTester tester) async {
  final Finder person = find.byIcon(Icons.person_outline);
  if (person.evaluate().isNotEmpty) {
    await tester.tap(person);
  } else {
    await tester.tap(find.byIcon(Icons.more_horiz_outlined));
  }
  await tester.pumpAndSettle();
}

/// Profile tab -> scroll to Log out -> confirm dialog.
/// Dialog/opening taps retry once: in FakeAsync, taps landing mid-transition
/// can miss without failing the finder.
Future<void> confirmLogout(WidgetTester tester) async {
  await openProfileTab(tester);
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
