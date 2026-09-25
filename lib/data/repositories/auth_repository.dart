import '../models/app_user.dart';

/// Successful demo sign-in: user + tokens (tokens go to SecureStore).
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
  /// Demo sign-in without OTP: validates the phone is a known demo
  /// account (or throws [AuthException]) and returns user + tokens.
  Future<AuthResult> demoSignIn(String phone);

  Future<void> logout();
}

/// Demo sign-in failure reasons mapped to localized messages by the UI.
enum AuthFailure {
  invalidPhone,
  blocked,
  network,
}

class AuthException implements Exception {
  const AuthException(this.failure, [this.message]);

  final AuthFailure failure;
  final String? message;

  @override
  String toString() => 'AuthException($failure, $message)';
}
