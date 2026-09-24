import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'hive_boxes.dart';

/// Persists the auth session (user JSON + flow flags) in Hive.
/// Language choice and onboarding flag survive logout.
class SessionStore {
  SessionStore({HiveInterface? hive}) : _hive = hive ?? Hive;

  final HiveInterface _hive;

  Box<dynamic> get _box => _hive.box(HiveBoxes.session);

  Future<void> saveSessionJson(String json) =>
      _box.put(HiveBoxes.keySessionJson, json);

  String? readSessionJson() => _box.get(HiveBoxes.keySessionJson) as String?;

  Future<void> saveSessionMap(Map<String, dynamic> map) =>
      saveSessionJson(jsonEncode(map));

  Map<String, dynamic>? readSessionMap() {
    final String? raw = readSessionJson();
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> clearSession() => _box.delete(HiveBoxes.keySessionJson);

  bool get onboardingDone =>
      _box.get(HiveBoxes.keyOnboardingDone, defaultValue: false) as bool;

  Future<void> setOnboardingDone(bool value) =>
      _box.put(HiveBoxes.keyOnboardingDone, value);

  String? get localeCode => _box.get(HiveBoxes.keyLocale) as String?;

  Future<void> setLocaleCode(String code) =>
      _box.put(HiveBoxes.keyLocale, code);

  String? get themeModeName => _box.get(HiveBoxes.keyThemeMode) as String?;

  Future<void> setThemeModeName(String name) =>
      _box.put(HiveBoxes.keyThemeMode, name);
}
