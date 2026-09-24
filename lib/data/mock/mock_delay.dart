import 'dart:async';
import 'dart:math';

import '../../core/config/app_config.dart';

final Random _random = Random();

/// Artificial latency for every mock repository call (300-900 ms).
Future<void> mockDelay() async {
  await Future<void>.delayed(
    Duration(milliseconds: 300 + _random.nextInt(601)),
  );
}

/// When chaos mode is on (demo tools), ~3% of calls fail to exercise
/// error + retry states on every screen.
void throwIfChaos({bool chaos = AppConfig.chaosMode}) {
  if (chaos && _random.nextDouble() < 0.03) {
    throw const MockApiException('Simulated network failure (chaos mode)');
  }
}

class MockApiException implements Exception {
  const MockApiException(this.message);
  final String message;

  @override
  String toString() => 'MockApiException: $message';
}
