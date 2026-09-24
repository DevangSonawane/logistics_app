import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/hive_boxes.dart';

part 'owner_settings.g.dart';

/// Per-alert-type toggles (push / WhatsApp / in-app) for owner alerts:
/// large payment, big delay, doc expiring, credit limit crossed.
@Riverpod(keepAlive: true)
class AlertSettings extends _$AlertSettings {
  static const List<String> alerts = ['pay', 'delay', 'doc', 'credit'];
  static const List<String> channels = ['push', 'wa', 'app'];

  @override
  Map<String, bool> build() {
    try {
      final box = Hive.box(HiveBoxes.cache);
      final Map<String, bool> state = {};
      for (final String alert in alerts) {
        for (final String channel in channels) {
          state['$alert-$channel'] =
              box.get('alert-$alert-$channel', defaultValue: true) as bool;
        }
      }
      return state;
    } catch (_) {
      return {for (final a in alerts) for (final c in channels) '$a-$c': true};
    }
  }

  bool enabled(String alert, String channel) =>
      state['$alert-$channel'] ?? true;

  Future<void> set(String alert, String channel, bool value) async {
    try {
      await Hive.box(HiveBoxes.cache).put('alert-$alert-$channel', value);
    } catch (_) {}
    state = {...state, '$alert-$channel': value};
  }
}
