import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'hive_boxes.dart';

part 'boxes.g.dart';

/// Synchronous-read key-value store. Hive in production, in-memory fakes
/// in widget tests (Hive file writes never complete in FakeAsync and
/// dangling writes poison later tests, so tests must not touch real Hive).
abstract class KeyValueBox {
  dynamic read(String key, {dynamic defaultValue});
  Future<void> write(String key, dynamic value);
  Future<void> delete(String key);
  Future<void> clear();
}

class HiveKeyValueBox implements KeyValueBox {
  HiveKeyValueBox(this.boxName);

  final String boxName;

  Box<dynamic> get _box => Hive.box(boxName);

  @override
  dynamic read(String key, {dynamic defaultValue}) =>
      _box.get(key, defaultValue: defaultValue);

  @override
  Future<void> write(String key, dynamic value) => _box.put(key, value);

  @override
  Future<void> delete(String key) => _box.delete(key);

  @override
  Future<void> clear() => _box.clear();
}

class MemoryKeyValueBox implements KeyValueBox {
  final Map<String, dynamic> data = {};

  @override
  dynamic read(String key, {dynamic defaultValue}) =>
      data.containsKey(key) ? data[key] : defaultValue;

  @override
  Future<void> write(String key, dynamic value) async {
    data[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    data.remove(key);
  }

  @override
  Future<void> clear() async {
    data.clear();
  }
}

@Riverpod(keepAlive: true)
KeyValueBox sessionBox(Ref ref) =>
    HiveKeyValueBox(HiveBoxes.session);

@Riverpod(keepAlive: true)
KeyValueBox cacheBox(Ref ref) => HiveKeyValueBox(HiveBoxes.cache);

@Riverpod(keepAlive: true)
KeyValueBox queueBox(Ref ref) =>
    HiveKeyValueBox(HiveBoxes.offlineQueue);

@Riverpod(keepAlive: true)
KeyValueBox gpsTrackBox(Ref ref) =>
    HiveKeyValueBox(HiveBoxes.gpsTrack);
