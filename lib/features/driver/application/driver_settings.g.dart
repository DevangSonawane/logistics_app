// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Driver preferences (Profile -> driver section): voice commands toggle
/// and text size. Persisted in the Hive cache box.

@ProviderFor(DriverSettings)
final driverSettingsProvider = DriverSettingsProvider._();

/// Driver preferences (Profile -> driver section): voice commands toggle
/// and text size. Persisted in the Hive cache box.
final class DriverSettingsProvider
    extends $NotifierProvider<DriverSettings, DriverSettingsState> {
  /// Driver preferences (Profile -> driver section): voice commands toggle
  /// and text size. Persisted in the Hive cache box.
  DriverSettingsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'driverSettingsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$driverSettingsHash();

  @$internal
  @override
  DriverSettings create() => DriverSettings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriverSettingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriverSettingsState>(value),
    );
  }
}

String _$driverSettingsHash() => r'd5de684a6565990fcfad48fe313b86308d8a9f91';

/// Driver preferences (Profile -> driver section): voice commands toggle
/// and text size. Persisted in the Hive cache box.

abstract class _$DriverSettings extends $Notifier<DriverSettingsState> {
  DriverSettingsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DriverSettingsState, DriverSettingsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<DriverSettingsState, DriverSettingsState>,
        DriverSettingsState,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
