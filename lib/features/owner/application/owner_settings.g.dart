// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Per-alert-type toggles (push / WhatsApp / in-app) for owner alerts:
/// large payment, big delay, doc expiring, credit limit crossed.

@ProviderFor(AlertSettings)
final alertSettingsProvider = AlertSettingsProvider._();

/// Per-alert-type toggles (push / WhatsApp / in-app) for owner alerts:
/// large payment, big delay, doc expiring, credit limit crossed.
final class AlertSettingsProvider
    extends $NotifierProvider<AlertSettings, Map<String, bool>> {
  /// Per-alert-type toggles (push / WhatsApp / in-app) for owner alerts:
  /// large payment, big delay, doc expiring, credit limit crossed.
  AlertSettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'alertSettingsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$alertSettingsHash();

  @$internal
  @override
  AlertSettings create() => AlertSettings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, bool>>(value),
    );
  }
}

String _$alertSettingsHash() => r'61024116aca4a3eef47483f25dc6ab65ad22958c';

/// Per-alert-type toggles (push / WhatsApp / in-app) for owner alerts:
/// large payment, big delay, doc expiring, credit limit crossed.

abstract class _$AlertSettings extends $Notifier<Map<String, bool>> {
  Map<String, bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Map<String, bool>, Map<String, bool>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, bool>, Map<String, bool>>,
        Map<String, bool>,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
