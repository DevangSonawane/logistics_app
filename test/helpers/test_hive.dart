import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:roadops/core/storage/hive_boxes.dart';

bool _ready = false;

/// Opens real Hive boxes in a temp dir for widget/unit tests.
/// Each test file runs in its own isolate; call in setUpAll.
Future<void> ensureTestHive() async {
  if (_ready) return;
  final Directory dir =
      await Directory.systemTemp.createTemp('roadops_test');
  Hive.init(dir.path);
  for (final String name in [
    HiveBoxes.session,
    HiveBoxes.cache,
    HiveBoxes.offlineQueue,
    HiveBoxes.gpsTrack,
  ]) {
    if (!Hive.isBoxOpen(name)) await Hive.openBox(name);
  }
  _ready = true;
}

/// Wipes queue-box contents between cases.
Future<void> clearTestBoxes() async {
  await Hive.box(HiveBoxes.offlineQueue).clear();
  await Hive.box(HiveBoxes.session).clear();
}
