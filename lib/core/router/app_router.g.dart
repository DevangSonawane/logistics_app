// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App router with role-based redirect guards. Each role gets its own
/// ShellRoute; real tabbed shells land with the feature phases (TODOs below).
/// Deep links (roadops://trip/{id} ...) are wired in Phase 3+.
/// TODO(Phase 2): replace placeholders with real auth screens.
/// TODO(Phase 3): driver_shell with 4 tabs + deep links.
/// TODO(Phase 4): owner_shell (5 tabs) + ops_shell (5 tabs).
/// TODO(Phase 6): notification centre, global search, profile/settings.
/// TODO(Phase 7): sales, supervisor and accountant shells.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// App router with role-based redirect guards. Each role gets its own
/// ShellRoute; real tabbed shells land with the feature phases (TODOs below).
/// Deep links (roadops://trip/{id} ...) are wired in Phase 3+.
/// TODO(Phase 2): replace placeholders with real auth screens.
/// TODO(Phase 3): driver_shell with 4 tabs + deep links.
/// TODO(Phase 4): owner_shell (5 tabs) + ops_shell (5 tabs).
/// TODO(Phase 6): notification centre, global search, profile/settings.
/// TODO(Phase 7): sales, supervisor and accountant shells.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// App router with role-based redirect guards. Each role gets its own
  /// ShellRoute; real tabbed shells land with the feature phases (TODOs below).
  /// Deep links (roadops://trip/{id} ...) are wired in Phase 3+.
  /// TODO(Phase 2): replace placeholders with real auth screens.
  /// TODO(Phase 3): driver_shell with 4 tabs + deep links.
  /// TODO(Phase 4): owner_shell (5 tabs) + ops_shell (5 tabs).
  /// TODO(Phase 6): notification centre, global search, profile/settings.
  /// TODO(Phase 7): sales, supervisor and accountant shells.
  AppRouterProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appRouterProvider',
          isAutoDispose: true,
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

String _$appRouterHash() => r'20ca474c5a4b218308461647a76a6654108aae4a';
