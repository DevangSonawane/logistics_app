// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boxes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sessionBox)
final sessionBoxProvider = SessionBoxProvider._();

final class SessionBoxProvider
    extends $FunctionalProvider<KeyValueBox, KeyValueBox, KeyValueBox>
    with $Provider<KeyValueBox> {
  SessionBoxProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'sessionBoxProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$sessionBoxHash();

  @$internal
  @override
  $ProviderElement<KeyValueBox> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KeyValueBox create(Ref ref) {
    return sessionBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyValueBox value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyValueBox>(value),
    );
  }
}

String _$sessionBoxHash() => r'4a3018dfcdaf5f71d887d64b6cdc12955195c481';

@ProviderFor(cacheBox)
final cacheBoxProvider = CacheBoxProvider._();

final class CacheBoxProvider
    extends $FunctionalProvider<KeyValueBox, KeyValueBox, KeyValueBox>
    with $Provider<KeyValueBox> {
  CacheBoxProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'cacheBoxProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$cacheBoxHash();

  @$internal
  @override
  $ProviderElement<KeyValueBox> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KeyValueBox create(Ref ref) {
    return cacheBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyValueBox value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyValueBox>(value),
    );
  }
}

String _$cacheBoxHash() => r'9d53354e31302fc9055f5662faaf7647bb02a85e';

@ProviderFor(queueBox)
final queueBoxProvider = QueueBoxProvider._();

final class QueueBoxProvider
    extends $FunctionalProvider<KeyValueBox, KeyValueBox, KeyValueBox>
    with $Provider<KeyValueBox> {
  QueueBoxProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'queueBoxProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$queueBoxHash();

  @$internal
  @override
  $ProviderElement<KeyValueBox> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KeyValueBox create(Ref ref) {
    return queueBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyValueBox value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyValueBox>(value),
    );
  }
}

String _$queueBoxHash() => r'8558bc986c19d23a714645c0bff1e883b1ac9a29';

@ProviderFor(gpsTrackBox)
final gpsTrackBoxProvider = GpsTrackBoxProvider._();

final class GpsTrackBoxProvider
    extends $FunctionalProvider<KeyValueBox, KeyValueBox, KeyValueBox>
    with $Provider<KeyValueBox> {
  GpsTrackBoxProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'gpsTrackBoxProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$gpsTrackBoxHash();

  @$internal
  @override
  $ProviderElement<KeyValueBox> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KeyValueBox create(Ref ref) {
    return gpsTrackBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyValueBox value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyValueBox>(value),
    );
  }
}

String _$gpsTrackBoxHash() => r'6a8b5ce9455508ccfda7591df33031330ac7404f';
