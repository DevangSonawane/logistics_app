// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_gps_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backgroundGpsService)
final backgroundGpsServiceProvider = BackgroundGpsServiceProvider._();

final class BackgroundGpsServiceProvider extends $FunctionalProvider<
    BackgroundGpsService,
    BackgroundGpsService,
    BackgroundGpsService> with $Provider<BackgroundGpsService> {
  BackgroundGpsServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'backgroundGpsServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$backgroundGpsServiceHash();

  @$internal
  @override
  $ProviderElement<BackgroundGpsService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackgroundGpsService create(Ref ref) {
    return backgroundGpsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackgroundGpsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackgroundGpsService>(value),
    );
  }
}

String _$backgroundGpsServiceHash() =>
    r'fe11cbd3b08fb03b60fd86c1c07ab9e0b3679d48';
