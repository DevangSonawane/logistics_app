import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/l10n/app_localizations.dart';
import 'core/l10n/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

/// Root widget: theme, locale and role-guarded router.
/// Bootstrap (Hive, session restore) happens in bootstrap.dart before this.
class RoadOpsApp extends ConsumerWidget {
  const RoadOpsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(appRouterProvider);
    final Locale locale = ref.watch(localeControllerProvider);
    final ThemeMode mode = ref.watch(themeModeControllerProvider);
    return MaterialApp.router(
      title: 'RoadOps',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
    );
  }
}
