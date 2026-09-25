// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App router with role-based redirect guards. The router is created once
/// and re-evaluates [roleGuard] on every session change via refresh().
///
/// Each role gets its own ShellRoute; sales/supervisor/accountant tabbed
/// shells land in Phase 7. Deep links (roadops://trip/{id} ...) are wired
/// in Phase 6 with the notification centre.
/// TODO(Phase 6): notification centre, global search, settings pages.
/// TODO(Phase 7): sales, supervisor and accountant shells.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// App router with role-based redirect guards. The router is created once
/// and re-evaluates [roleGuard] on every session change via refresh().
///
/// Each role gets its own ShellRoute; sales/supervisor/accountant tabbed
/// shells land in Phase 7. Deep links (roadops://trip/{id} ...) are wired
/// in Phase 6 with the notification centre.
/// TODO(Phase 6): notification centre, global search, settings pages.
/// TODO(Phase 7): sales, supervisor and accountant shells.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// App router with role-based redirect guards. The router is created once
  /// and re-evaluates [roleGuard] on every session change via refresh().
  ///
  /// Each role gets its own ShellRoute; sales/supervisor/accountant tabbed
  /// shells land in Phase 7. Deep links (roadops://trip/{id} ...) are wired
  /// in Phase 6 with the notification centre.
  /// TODO(Phase 6): notification centre, global search, settings pages.
  /// TODO(Phase 7): sales, supervisor and accountant shells.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'e9551b080f43688f816514bdff063ca0cbac00ed';
