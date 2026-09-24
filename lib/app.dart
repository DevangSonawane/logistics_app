import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/config/constants.dart';
import 'core/l10n/app_localizations.dart';
import 'core/l10n/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/auth/application/session_provider.dart';

/// Root widget: theme, locale and role-guarded router.
/// Bootstrap (Hive, session restore) happens in bootstrap.dart before this.
///
/// Staff sessions lock after [AppConstants.staffLockAfterMinutes] in the
/// background (Section 6.2); the guard then routes to the lock page.
class RoadOpsApp extends ConsumerStatefulWidget {
  const RoadOpsApp({super.key});

  @override
  ConsumerState<RoadOpsApp> createState() => _RoadOpsAppState();
}

class _RoadOpsAppState extends ConsumerState<RoadOpsApp>
    with WidgetsBindingObserver {
  DateTime? _pausedAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _pausedAt = DateTime.now();
    } else if (state == AppLifecycleState.resumed && _pausedAt != null) {
      final SessionState session = ref.read(sessionProvider);
      final Duration away = DateTime.now().difference(_pausedAt!);
      _pausedAt = null;
      if (session.isStaff &&
          away.inMinutes >= AppConstants.staffLockAfterMinutes) {
        ref.read(sessionProvider.notifier).setLocked(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
