import 'package:go_router/go_router.dart';

import '../../../data/models/app_user.dart';
import '../../../features/auth/application/session_provider.dart';
import 'route_names.dart';

/// Router-level enforcement (Section 5). Evaluated in this order:
/// onboarding -> login -> role pick -> active role home. The UI never
/// enforces roles itself.
String? roleGuard(SessionState session, GoRouterState state) {
  final String path = state.uri.path;

  // Splash always runs its 1.2 s animation, then forwards into the flow.
  if (path == RouteNames.splash) return null;

  if (!session.onboardingDone) {
    return path == RouteNames.language ? null : RouteNames.language;
  }

  if (!session.loggedIn) {
    if (path == RouteNames.login) return null;
    return RouteNames.login;
  }

  if (session.needsRolePick || session.activeRole == null) {
    return path == RouteNames.rolePicker ? null : RouteNames.rolePicker;
  }

  final String home = RouteNames.homeFor(session.activeRole);

  // Keep logged-in users out of the pre-home flow.
  const Set<String> preHome = {
    RouteNames.splash,
    RouteNames.language,
    RouteNames.login,
    RouteNames.rolePicker,
    RouteNames.biometricSetup,
    RouteNames.lock,
  };
  if (preHome.contains(path)) return home;

  // Role isolation: /driver/* is unreachable for other roles, even by
  // deep link. Violations land on the 403 page.
  final AppRole? pathRole = RouteNames.roleForPath(path);
  if (pathRole != null && pathRole != session.activeRole) {
    return RouteNames.forbidden;
  }

  return null;
}
