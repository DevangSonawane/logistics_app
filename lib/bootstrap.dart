import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/storage/hive_boxes.dart';

/// Bootstrap: Hive init + box opens, then runs the app.
/// Session restore is lazy via sessionProvider on first read.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeDateFormatting('en_IN', null);
  await Future.wait([
    Hive.openBox(HiveBoxes.session),
    Hive.openBox(HiveBoxes.cache),
    Hive.openBox(HiveBoxes.offlineQueue),
    Hive.openBox(HiveBoxes.gpsTrack),
  ]);
  runApp(const ProviderScope(child: RoadOpsApp()));
}
