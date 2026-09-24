import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/app_user.dart';
import '../../features/auth/application/session_provider.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_scaffold.dart';
import 'role_guard.dart';
import 'route_names.dart';

part 'app_router.g.dart';

/// App router with role-based redirect guards. Each role gets its own
/// ShellRoute; real tabbed shells land with the feature phases (TODOs below).
/// Deep links (roadops://trip/{id} ...) are wired in Phase 3+.
/// TODO(Phase 2): replace placeholders with real auth screens.
/// TODO(Phase 3): driver_shell with 4 tabs + deep links.
/// TODO(Phase 4): owner_shell (5 tabs) + ops_shell (5 tabs).
/// TODO(Phase 6): notification centre, global search, profile/settings.
/// TODO(Phase 7): sales, supervisor and accountant shells.
@riverpod
GoRouter appRouter(Ref ref) {
  final SessionState session = ref.watch(sessionProvider);
  return GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (BuildContext context, GoRouterState state) =>
        roleGuard(session, state),
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) =>
            const _PlaceholderPage(phase: 'Phase 2', title: 'RoadOps'),
      ),
      GoRoute(
        path: RouteNames.language,
        builder: (context, state) =>
            const _PlaceholderPage(phase: 'Phase 2', title: 'Language'),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) =>
            const _PlaceholderPage(phase: 'Phase 2', title: 'Login'),
      ),
      GoRoute(
        path: RouteNames.otp,
        builder: (context, state) =>
            const _PlaceholderPage(phase: 'Phase 2', title: 'OTP'),
      ),
      GoRoute(
        path: RouteNames.rolePicker,
        builder: (context, state) =>
            const _PlaceholderPage(phase: 'Phase 2', title: 'Role picker'),
      ),
      GoRoute(
        path: RouteNames.permissions,
        builder: (context, state) =>
            const _PlaceholderPage(phase: 'Phase 2', title: 'Permissions'),
      ),
      GoRoute(
        path: RouteNames.biometricSetup,
        builder: (context, state) =>
            const _PlaceholderPage(phase: 'Phase 2', title: 'Biometric setup'),
      ),
      GoRoute(
        path: RouteNames.lock,
        builder: (context, state) =>
            const _PlaceholderPage(phase: 'Phase 2', title: 'Lock'),
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
}

/// Minimal role shell for Phase 1. Real tabbed shells arrive per phase.
class _RoleShell extends StatelessWidget {
  const _RoleShell({required this.role, required this.child});

  final AppRole role;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_roleLabel(context, role))),
      body: child,
    );
  }
}

class _RoleHomePage extends StatelessWidget {
  const _RoleHomePage({required this.role});

  final AppRole role;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      body: Center(
        child: Text(
          l10n.phaseComingSoon(_phaseFor(role)),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.phase, required this.title});

  final String phase;
  final String title;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.phaseComingSoon(phase)),
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
            const Icon(Icons.block, size: AppSpacing.huge, color: AppColors.danger),
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

String _roleLabel(BuildContext context, AppRole role) {
  final AppLocalizations l10n = AppLocalizations.of(context);
  return switch (role) {
    AppRole.driver => l10n.roleDriver,
    AppRole.owner => l10n.roleOwner,
    AppRole.ops => l10n.roleOps,
    AppRole.sales => l10n.roleSales,
    AppRole.supervisor => l10n.roleSupervisor,
    AppRole.accountant => l10n.roleAccountant,
  };
}

String _phaseFor(AppRole role) {
  return switch (role) {
    AppRole.driver => 'Phase 3',
    AppRole.owner || AppRole.ops => 'Phases 4-5',
    AppRole.sales || AppRole.supervisor || AppRole.accountant => 'Phase 7',
  };
}
