import 'package:roadops/core/storage/boxes.dart';

/// Fresh in-memory boxes per widget test. Widget bodies run in FakeAsync
/// where Hive file writes never complete (and dangling writes poison later
/// tests), so widget tests must never touch real Hive.
///
/// Spread into ProviderScope overrides; the override objects infer their
/// own types at the call site (Override is not public API in Riverpod 3).
List<dynamic> memoryBoxOverrides() => [
      sessionBoxProvider.overrideWithValue(MemoryKeyValueBox()),
      cacheBoxProvider.overrideWithValue(MemoryKeyValueBox()),
      queueBoxProvider.overrideWithValue(MemoryKeyValueBox()),
      gpsTrackBoxProvider.overrideWithValue(MemoryKeyValueBox()),
    ];
