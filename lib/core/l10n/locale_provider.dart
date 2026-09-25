import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/boxes.dart';
import '../storage/session_store.dart';

part 'locale_provider.g.dart';

/// Supported locales. English + Hindi fully translated; the rest ship the
/// core driver strings and fall back to English for missing keys.
const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('hi'),
  Locale('mr'),
  Locale('ta'),
  Locale('te'),
  Locale('kn'),
  Locale('bn'),
  Locale('pa'),
];

/// Current locale, persisted in Hive. Switching updates the UI instantly
/// with no restart (MaterialApp rebuilds via watch).
@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  SessionStore get _store =>
      SessionStore(box: ref.read(sessionBoxProvider));

  @override
  Locale build() {
    final String? code = _store.localeCode;
    return Locale(code ?? 'en');
  }

  Future<void> setLocale(Locale locale) async {
    await _store.setLocaleCode(locale.languageCode);
    state = locale;
  }
}
