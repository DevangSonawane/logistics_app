// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hubTasks)
final hubTasksProvider = HubTasksProvider._();

final class HubTasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HubTask>>,
          List<HubTask>,
          FutureOr<List<HubTask>>
        >
    with $FutureModifier<List<HubTask>>, $FutureProvider<List<HubTask>> {
  HubTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hubTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hubTasksHash();

  @$internal
  @override
  $FutureProviderElement<List<HubTask>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HubTask>> create(Ref ref) {
    return hubTasks(ref);
  }
}

String _$hubTasksHash() => r'f92d556291103578fd59daf5ba9ea48d49a2fd02';

@ProviderFor(manifests)
final manifestsProvider = ManifestsProvider._();

final class ManifestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Manifest>>,
          List<Manifest>,
          FutureOr<List<Manifest>>
        >
    with $FutureModifier<List<Manifest>>, $FutureProvider<List<Manifest>> {
  ManifestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'manifestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$manifestsHash();

  @$internal
  @override
  $FutureProviderElement<List<Manifest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Manifest>> create(Ref ref) {
    return manifests(ref);
  }
}

String _$manifestsHash() => r'21f74e9a8969e2cc5a900ca3f970e221ba7d1e64';
