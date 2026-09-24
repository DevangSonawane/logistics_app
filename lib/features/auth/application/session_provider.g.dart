// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Current session. Restored from Hive on boot; every mutation persists.

@ProviderFor(Session)
final sessionProvider = SessionProvider._();

/// Current session. Restored from Hive on boot; every mutation persists.
final class SessionProvider extends $NotifierProvider<Session, SessionState> {
  /// Current session. Restored from Hive on boot; every mutation persists.
  SessionProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sessionProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sessionHash();

  @$internal
  @override
  Session create() => Session();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionState>(value),
    );
  }
}

String _$sessionHash() => r'07df73ea769d979732866b3cbdbfdd7a7b600ca7';

/// Current session. Restored from Hive on boot; every mutation persists.

abstract class _$Session extends $Notifier<SessionState> {
  SessionState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SessionState, SessionState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SessionState, SessionState>,
        SessionState,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}

/// Permission helper used to show/hide actions:
/// `ref.watch(canProvider(AppPermission.approveAdvance))`.

@ProviderFor(can)
final canProvider = CanFamily._();

/// Permission helper used to show/hide actions:
/// `ref.watch(canProvider(AppPermission.approveAdvance))`.

final class CanProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Permission helper used to show/hide actions:
  /// `ref.watch(canProvider(AppPermission.approveAdvance))`.
  CanProvider._(
      {required CanFamily super.from, required AppPermission super.argument})
      : super(
          retry: null,
          name: r'canProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$canHash();

  @override
  String toString() {
    return r'canProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as AppPermission;
    return can(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$canHash() => r'00ae342a6415506319c768e95da9d5fa2dc65418';

/// Permission helper used to show/hide actions:
/// `ref.watch(canProvider(AppPermission.approveAdvance))`.

final class CanFamily extends $Family
    with $FunctionalFamilyOverride<bool, AppPermission> {
  CanFamily._()
      : super(
          retry: null,
          name: r'canProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Permission helper used to show/hide actions:
  /// `ref.watch(canProvider(AppPermission.approveAdvance))`.

  CanProvider call(
    AppPermission permission,
  ) =>
      CanProvider._(argument: permission, from: this);

  @override
  String toString() => r'canProvider';
}
