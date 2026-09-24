import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/session_store.dart';

part 'theme_provider.g.dart';

/// Theme mode (System / Light / Dark), persisted. Read from Profile settings.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() {
    final String? name = SessionStore().themeModeName;
    return ThemeMode.values.firstWhere(
      (ThemeMode m) => m.name == name,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setMode(ThemeMode mode) async {
    await SessionStore().setThemeModeName(mode.name);
    state = mode;
  }
}
