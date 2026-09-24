import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_store.g.dart';

/// Overridable handle to the secure store. Tests inject a memory fake.
@Riverpod(keepAlive: true)
SecureStore secureStore(Ref ref) => SecureStore();

/// Token storage. Auth tokens live ONLY here, never in Hive or logs.
class SecureStore {
  SecureStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const String _keyToken = 'auth_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyAppPin = 'app_pin';

  Future<void> saveTokens({
    required String token,
    required String refreshToken,
  }) async {
    await _storage.write(key: _keyToken, value: token);
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
  }

  Future<String?> readToken() => _storage.read(key: _keyToken);

  Future<void> saveAppPin(String pin) =>
      _storage.write(key: _keyAppPin, value: pin);

  Future<String?> readAppPin() => _storage.read(key: _keyAppPin);

  /// Clears everything on logout.
  Future<void> clearAll() => _storage.deleteAll();
}
