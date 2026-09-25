import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/boxes.dart';

part 'driver_settings.g.dart';

class DriverSettingsState {
  const DriverSettingsState({
    this.voiceEnabled = true,
    this.textScale = 1.0,
  });

  final bool voiceEnabled;

  /// Extra text scaling on top of the driver theme (1.0 / 1.15 / 1.3).
  final double textScale;

  DriverSettingsState copyWith({bool? voiceEnabled, double? textScale}) {
    return DriverSettingsState(
      voiceEnabled: voiceEnabled ?? this.voiceEnabled,
      textScale: textScale ?? this.textScale,
    );
  }
}

/// Driver preferences (Profile -> driver section): voice commands toggle
/// and text size. Persisted in the Hive cache box.
@Riverpod(keepAlive: true)
class DriverSettings extends _$DriverSettings {
  static const String _voiceKey = 'voice_enabled';
  static const String _scaleKey = 'text_scale';

  @override
  DriverSettingsState build() {
    try {
      final KeyValueBox box = ref.read(cacheBoxProvider);
      return DriverSettingsState(
        voiceEnabled: box.read(_voiceKey, defaultValue: true) as bool,
        textScale:
            (box.read(_scaleKey, defaultValue: 1.0) as num).toDouble(),
      );
    } catch (_) {
      return const DriverSettingsState();
    }
  }

  Future<void> setVoiceEnabled(bool value) async {
    try {
      await ref.read(cacheBoxProvider).write(_voiceKey, value);
    } catch (_) {}
    state = state.copyWith(voiceEnabled: value);
  }

  Future<void> setTextScale(double value) async {
    try {
      await ref.read(cacheBoxProvider).write(_scaleKey, value);
    } catch (_) {}
    state = state.copyWith(textScale: value);
  }
}
