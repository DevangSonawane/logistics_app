import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/boxes.dart';
import '../storage/session_store.dart';

part 'theme_provider.g.dart';

/// Theme mode (System / Light / Dark), persisted. Read from Profile settings.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  SessionStore get _store =>
      SessionStore(box: ref.read(sessionBoxProvider));

  @override
  ThemeMode build() {
    final String? name = _store.themeModeName;
    return ThemeMode.values.firstWhere(
      (ThemeMode m) => m.name == name,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setMode(ThemeMode mode) async {
    await _store.setThemeModeName(mode.name);
    state = mode;
  }
}
