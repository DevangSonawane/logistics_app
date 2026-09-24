import 'package:go_router/go_router.dart';

import '../../../data/models/app_user.dart';
import '../../../features/auth/application/session_provider.dart';
import 'route_names.dart';

/// Router-level enforcement (Section 5). Evaluated in this order:
/// onboarding -> login -> role pick -> permissions -> biometric -> lock,
/// else the active role home. The UI never enforces roles itself.
String? roleGuard(SessionState session, GoRouterState state) {
  final String path = state.uri.path;

  if (!session.onboardingDone) {
    return path == RouteNames.language ? null : RouteNames.language;
  }

  if (!session.loggedIn) {
    if (path == RouteNames.login || path == RouteNames.otp) return null;
    return RouteNames.login;
  }

  if (session.needsRolePick || session.activeRole == null) {
    return path == RouteNames.rolePicker ? null : RouteNames.rolePicker;
  }

  if (!session.permissionsDone) {
    return path == RouteNames.permissions ? null : RouteNames.permissions;
  }

  if (session.isStaff && !session.biometricSetup) {
    return path == RouteNames.biometricSetup ? null : RouteNames.biometricSetup;
  }

  if (session.locked) {
    return path == RouteNames.lock ? null : RouteNames.lock;
  }

  final String home = RouteNames.homeFor(session.activeRole);

  // Keep logged-in users out of the pre-home flow.
  const Set<String> preHome = {
    RouteNames.splash,
    RouteNames.language,
    RouteNames.login,
    RouteNames.otp,
    RouteNames.rolePicker,
    RouteNames.permissions,
    RouteNames.biometricSetup,
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
