import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/boxes.dart';
import '../../../core/storage/secure_store.dart';
import '../../../core/storage/session_store.dart';
import '../../../data/models/app_user.dart';

part 'session_provider.g.dart';

/// Immutable auth/onboarding flow state evaluated by the router guard.
class SessionState {
  const SessionState({
    this.onboardingDone = false,
    this.loggedIn = false,
    this.user,
    this.activeRole,
    this.needsRolePick = false,
    this.permissionsDone = false,
    this.biometricSetup = false,
    this.locked = false,
    this.lastRole,
  });

  final bool onboardingDone;
  final bool loggedIn;
  final AppUser? user;
  final AppRole? activeRole;
  final bool needsRolePick;
  final bool permissionsDone;
  final bool biometricSetup;
  final bool locked;

  /// Last role the user worked in. Pre-selected on the role picker.
  final AppRole? lastRole;

  /// Staff roles use the biometric/PIN lock; drivers skip it.
  bool get isStaff => activeRole != null && activeRole != AppRole.driver;

  SessionState copyWith({
    bool? onboardingDone,
    bool? loggedIn,
    AppUser? user,
    AppRole? activeRole,
    bool? needsRolePick,
    bool? permissionsDone,
    bool? biometricSetup,
    bool? locked,
    AppRole? lastRole,
  }) {
    return SessionState(
      onboardingDone: onboardingDone ?? this.onboardingDone,
      loggedIn: loggedIn ?? this.loggedIn,
      user: user ?? this.user,
      activeRole: activeRole ?? this.activeRole,
      needsRolePick: needsRolePick ?? this.needsRolePick,
      permissionsDone: permissionsDone ?? this.permissionsDone,
      biometricSetup: biometricSetup ?? this.biometricSetup,
      locked: locked ?? this.locked,
      lastRole: lastRole ?? this.lastRole,
    );
  }
}

/// Current session. Restored from Hive on boot; every mutation persists.
@Riverpod(keepAlive: true)
class Session extends _$Session {
  SessionStore get _store =>
      SessionStore(box: ref.read(sessionBoxProvider));

  @override
  SessionState build() {
    final Map<String, dynamic>? saved = _store.readSessionMap();
    if (saved == null) {
      return SessionState(onboardingDone: _store.onboardingDone);
    }
    try {
      final AppUser user =
          AppUser.fromJson(Map<String, dynamic>.from(saved['user'] as Map));
      final String? roleName = saved['activeRole'] as String?;
      final String? lastRoleName = saved['lastRole'] as String?;
      return SessionState(
        onboardingDone: _store.onboardingDone,
        loggedIn: true,
        user: user,
        activeRole: roleName == null
            ? null
            : AppRole.values.byName(roleName),
        needsRolePick: saved['needsRolePick'] as bool? ?? false,
        permissionsDone: saved['permissionsDone'] as bool? ?? false,
        biometricSetup: saved['biometricSetup'] as bool? ?? false,
        lastRole: lastRoleName == null
            ? null
            : AppRole.values.byName(lastRoleName),
      );
    } catch (_) {
      return SessionState(onboardingDone: _store.onboardingDone);
    }
  }

  void _persist() {
    final SessionState s = state;
    if (!s.loggedIn || s.user == null) {
      unawaited(_store.clearSession());
      return;
    }
    unawaited(_store.saveSessionMap({
      'user': s.user!.toJson(),
      'activeRole': s.activeRole?.name,
      'lastRole': s.lastRole?.name,
      'needsRolePick': s.needsRolePick,
      'permissionsDone': s.permissionsDone,
      'biometricSetup': s.biometricSetup,
    }));
  }

  /// State flips synchronously so navigation never waits on disk I/O;
  /// the flag persists in the background.
  Future<void> completeOnboarding() async {
    state = state.copyWith(onboardingDone: true);
    try {
      await _store.setOnboardingDone(true);
    } catch (_) {}
  }

  /// Called by the auth controller after OTP verification (Phase 2).
  void signIn(AppUser user) {
    final bool multi = user.roles.length > 1;
    state = state.copyWith(
      loggedIn: true,
      user: user,
      activeRole: multi ? null : user.roles.first,
      needsRolePick: multi,
      permissionsDone: false,
      biometricSetup: false,
      locked: false,
    );
    _persist();
  }

  void selectRole(AppRole role) {
    state = state.copyWith(
      activeRole: role,
      needsRolePick: false,
      lastRole: role,
    );
    _persist();
  }

  /// Re-opens the role picker without logging out (Profile -> Switch role).
  void changeRole() {
    state = state.copyWith(activeRole: null, needsRolePick: true);
    _persist();
  }

  void completePermissions() {
    state = state.copyWith(permissionsDone: true);
    _persist();
  }

  void completeBiometric() {
    state = state.copyWith(biometricSetup: true);
    _persist();
  }

  void setLocked(bool value) {
    state = state.copyWith(locked: value);
  }

  /// Clears secure storage, session and cached data. Keeps language +
  /// onboarding flag. GPS is stopped by the logout flow (Phase 3 wiring).
  Future<void> signOut() async {
    await ref.read(secureStoreProvider).clearAll();
    await _store.clearSession();
    await ref.read(cacheBoxProvider).clear();
    await ref.read(queueBoxProvider).clear();
    await ref.read(gpsTrackBoxProvider).clear();
    state = SessionState(onboardingDone: _store.onboardingDone);
  }
}

/// Permission helper used to show/hide actions:
/// `ref.watch(canProvider(AppPermission.approveAdvance))`.
@riverpod
bool can(Ref ref, AppPermission permission) {
  final SessionState session = ref.watch(sessionProvider);
  final AppUser? user = session.user;
  final AppRole? role = session.activeRole;
  if (user == null || role == null) return false;
  return hasPermission(user, role, permission);
}
