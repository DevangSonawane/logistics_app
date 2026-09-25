import 'dart:convert';

import 'boxes.dart';
import 'hive_boxes.dart';

/// Persists the auth session (user JSON + flow flags).
/// Language choice and onboarding flag survive logout.
/// Backed by an injected box: Hive in production, memory in widget tests.
class SessionStore {
  SessionStore({required this.box});

  final KeyValueBox box;

  Future<void> saveSessionJson(String json) =>
      box.write(HiveBoxes.keySessionJson, json);

  String? readSessionJson() =>
      box.read(HiveBoxes.keySessionJson) as String?;

  Future<void> saveSessionMap(Map<String, dynamic> map) =>
      saveSessionJson(jsonEncode(map));

  Map<String, dynamic>? readSessionMap() {
    final String? raw = readSessionJson();
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> clearSession() =>
      box.delete(HiveBoxes.keySessionJson);

  bool get onboardingDone =>
      box.read(HiveBoxes.keyOnboardingDone, defaultValue: false) as bool;

  Future<void> setOnboardingDone(bool value) =>
      box.write(HiveBoxes.keyOnboardingDone, value);

  String? get localeCode => box.read(HiveBoxes.keyLocale) as String?;

  Future<void> setLocaleCode(String code) =>
      box.write(HiveBoxes.keyLocale, code);

  String? get themeModeName =>
      box.read(HiveBoxes.keyThemeMode) as String?;

  Future<void> setThemeModeName(String name) =>
      box.write(HiveBoxes.keyThemeMode, name);
}
