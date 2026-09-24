// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Orchestrates send/verify OTP. Session mutation (sign-in) happens here;
/// the router guard decides the next screen.

@ProviderFor(AuthFlow)
final authFlowProvider = AuthFlowProvider._();

/// Orchestrates send/verify OTP. Session mutation (sign-in) happens here;
/// the router guard decides the next screen.
final class AuthFlowProvider
    extends $NotifierProvider<AuthFlow, AuthFlowState> {
  /// Orchestrates send/verify OTP. Session mutation (sign-in) happens here;
  /// the router guard decides the next screen.
  AuthFlowProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authFlowProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authFlowHash();

  @$internal
  @override
  AuthFlow create() => AuthFlow();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthFlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthFlowState>(value),
    );
  }
}

String _$authFlowHash() => r'33542393d3cf2b6a4beaaee8f985fbd0e0afde9e';

/// Orchestrates send/verify OTP. Session mutation (sign-in) happens here;
/// the router guard decides the next screen.

abstract class _$AuthFlow extends $Notifier<AuthFlowState> {
  AuthFlowState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AuthFlowState, AuthFlowState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AuthFlowState, AuthFlowState>,
        AuthFlowState,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
