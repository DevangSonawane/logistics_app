import 'package:local_auth/local_auth.dart';

import '../config/app_config.dart';

/// Biometric auth for staff lock/setup. Demo builds simulate success so
/// tests and demos never hit the OS dialog; real devices use local_auth.
class BiometricService {
  BiometricService({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  Future<bool> canUseBiometrics() async {
    try {
      return await _auth.canCheckBiometrics ||
          await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate(String reason) async {
    if (AppConfig.demo) return true;
    try {
      if (!await canUseBiometrics()) return false;
      return await _auth.authenticate(localizedReason: reason);
    } catch (_) {
      return false;
    }
  }
}
