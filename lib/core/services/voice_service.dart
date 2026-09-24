import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../data/models/trip.dart';

part 'voice_service.g.dart';

@Riverpod(keepAlive: true)
VoiceService voiceService(Ref ref) => VoiceService();

/// Voice commands (STT with per-language phrase sets) + voice notes.
/// Recognition never auto-applies: callers show a confirmation chip first.
class VoiceService {
  VoiceService({SpeechToText? stt, AudioRecorder? recorder})
      : _stt = stt ?? SpeechToText(),
        _recorder = recorder ?? AudioRecorder();

  final SpeechToText _stt;
  final AudioRecorder _recorder;

  Future<bool> listen({
    required void Function(String words) onResult,
    String? localeId,
  }) async {
    try {
      final bool available = await _stt.initialize();
      if (!available) return false;
      await _stt.listen(
        onResult: (result) => onResult(result.recognizedWords),
        localeId: localeId,
        partialResults: true,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> stopListening() async {
    try {
      await _stt.stop();
    } catch (_) {}
  }

  bool get isListening {
    try {
      return _stt.isListening;
    } catch (_) {
      return false;
    }
  }

  /// Starts a voice note; returns the target path for [stopNote].
  /// Callers show the recording-consent screen first (Phase 3 UI does).
  Future<String?> startNote() async {
    try {
      if (!await _recorder.hasPermission()) return null;
      final dir = await getApplicationDocumentsDirectory();
      final String path =
          '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(const RecordConfig(), path: path);
      return path;
    } catch (_) {
      return null;
    }
  }

  Future<String?> stopNote() async {
    try {
      return await _recorder.stop();
    } catch (_) {
      return null;
    }
  }

  Future<void> disposeRecorder() async {
    try {
      await _recorder.dispose();
    } catch (_) {}
  }
}

/// Matches heard words to a driver status step. English + Hindi phrase sets;
/// unknown locales fall back to English. Single-word triggers ('start')
/// are checked last so longer phrases win.
TripStepType? matchDriverCommand(String words, String languageCode) {
  final String text = words.toLowerCase();
  bool has(Iterable<String> keys) => keys.any(text.contains);

  const Map<TripStepType, List<String>> en = {
    TripStepType.unloaded: ['unloading done', 'unloaded', 'unload ho gaya'],
    TripStepType.loadingDone: ['loading done', 'loaded'],
    TripStepType.reachedPickup: ['reached pickup', 'reached pick up'],
    TripStepType.reachedDrop: ['reached drop', 'reached destination'],
    TripStepType.startTrip: ['start trip', 'start'],
  };
  const Map<TripStepType, List<String>> hi = {
    TripStepType.unloaded: ['unloading ho gayi', 'अनलोडिंग', 'unload'],
    TripStepType.loadingDone: [
      'loading ho gaya',
      'load ho gaya',
      'लोड हो गया',
      'सामान लोड',
    ],
    TripStepType.reachedPickup: ['pickup pahunch', 'पिकअप पहुंच'],
    TripStepType.reachedDrop: ['drop pahunch', 'ड्रॉप पहुंच'],
    TripStepType.startTrip: ['chalo', 'चलो', 'start'],
  };

  final Map<TripStepType, List<String>> phrases =
      languageCode == 'hi' ? hi : en;
  // Check order: specific multi-word phrases before the bare 'start'.
  const List<TripStepType> order = [
    TripStepType.unloaded,
    TripStepType.loadingDone,
    TripStepType.reachedPickup,
    TripStepType.reachedDrop,
    TripStepType.startTrip,
  ];
  for (final TripStepType step in order) {
    if (has(phrases[step]!)) return step;
  }
  return null;
}
