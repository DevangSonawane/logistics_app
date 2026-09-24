import '../models/app_user.dart';

/// Auth failure reasons mapped to localized messages by the UI.
enum AuthFailure {
  invalidPhone,
  blocked,
  wrongOtp,
  expiredOtp,
  tooManyAttempts,
  network,
}

class AuthException implements Exception {
  const AuthException(this.failure, [this.message]);

  final AuthFailure failure;
  final String? message;

  @override
  String toString() => 'AuthException($failure, $message)';
}

/// Successful OTP verification: user + tokens (tokens go to SecureStore).
class AuthResult {
  const AuthResult({
    required this.user,
    required this.token,
    required this.refreshToken,
  });

  final AppUser user;
  final String token;
  final String refreshToken;
}

abstract class AuthRepository {
  /// Validates the phone and (mock-)sends the OTP.
  Future<void> sendOtp(String phone);

  /// Verifies the OTP and returns the user + tokens.
  Future<AuthResult> verifyOtp({required String phone, required String otp});

  Future<void> logout();
}
