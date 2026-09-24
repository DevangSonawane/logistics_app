import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/app_user.dart';
import '../../features/auth/application/logout_flow.dart';
import '../../features/auth/application/session_provider.dart';
import '../../features/auth/presentation/biometric_setup_page.dart';
import '../../features/auth/presentation/lock_page.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/otp_page.dart';
import '../../features/auth/presentation/permissions_page.dart';
import '../../features/auth/presentation/role_picker_page.dart';
import '../../features/common/profile/profile_page.dart';
import '../../features/onboarding/language_select_page.dart';
import '../../features/splash/splash_page.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_scaffold.dart';
import 'role_guard.dart';
import 'role_labels.dart';
import 'route_names.dart';

part 'app_router.g.dart';

/// App router with role-based redirect guards. The router is created once
/// and re-evaluates [roleGuard] on every session change via refresh().
///
/// Each role gets its own ShellRoute; real tabbed shells land with the
/// feature phases (TODOs below). Deep links (roadops://trip/{id} ...)
/// are wired in Phase 3+.
/// TODO(Phase 3): driver_shell with 4 tabs + deep links.
/// TODO(Phase 4): owner_shell (5 tabs) + ops_shell (5 tabs).
/// TODO(Phase 6): notification centre, global search, settings pages.
/// TODO(Phase 7): sales, supervisor and accountant shells.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (BuildContext context, GoRouterState state) =>
        roleGuard(ref.read(sessionProvider), state),
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.language,
        builder: (context, state) => const LanguageSelectPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.otp,
        builder: (context, state) {
          final String phone = state.extra as String? ?? '';
          return OtpPage(phone: phone);
        },
      ),
      GoRoute(
        path: RouteNames.rolePicker,
        builder: (context, state) => const RolePickerPage(),
      ),
      GoRoute(
        path: RouteNames.permissions,
        builder: (context, state) => const PermissionsPage(),
      ),
      GoRoute(
        path: RouteNames.biometricSetup,
        builder: (context, state) => const BiometricSetupPage(),
      ),
      GoRoute(
        path: RouteNames.lock,
        builder: (context, state) => const LockPage(),
      ),
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: RouteNames.forbidden,
        builder: (context, state) => const _ForbiddenPage(),
      ),
      for (final AppRole role in AppRole.values)
        ShellRoute(
          builder: (context, state, child) =>
              _RoleShell(role: role, child: child),
          routes: [
            GoRoute(
              path: '/${role.name}/home',
              builder: (context, state) => _RoleHomePage(role: role),
            ),
          ],
        ),
    ],
  );
  ref.onDispose(router.dispose);
  ref.listen(sessionProvider, (_, __) => router.refresh());
  return router;
}

/// Minimal role shell for Phase 2. Real tabbed shells arrive per phase.
class _RoleShell extends ConsumerWidget {
  const _RoleShell({required this.role, required this.child});

  final AppRole role;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roleLabel(AppLocalizations.of(context), role)),
        actions: [
          IconButton(
            tooltip: AppLocalizations.of(context).profileTitle,
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.go(RouteNames.profile),
          ),
        ],
      ),
      body: child,
    );
  }
}

class _RoleHomePage extends ConsumerWidget {
  const _RoleHomePage({required this.role});

  final AppRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.greeting(ref.watch(
                sessionProvider.select(
                  (SessionState s) => s.user?.name ?? '',
                ),
              )),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.phaseComingSoon(_phaseFor(role))),
            const SizedBox(height: AppSpacing.xl),
            OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text(l10n.logoutAction),
              onPressed: () => runLogoutFlow(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForbiddenPage extends StatelessWidget {
  const _ForbiddenPage();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.block,
              size: AppSpacing.huge,
              color: AppColors.danger,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.forbiddenTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.forbiddenMessage),
          ],
        ),
      ),
    );
  }
}

String _phaseFor(AppRole role) {
  return switch (role) {
    AppRole.driver => 'Phase 3',
    AppRole.owner || AppRole.ops => 'Phases 4-5',
    AppRole.sales || AppRole.supervisor || AppRole.accountant => 'Phase 7',
  };
}
