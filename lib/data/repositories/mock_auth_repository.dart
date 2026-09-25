import '../mock/mock_delay.dart';
import '../mock/mock_users.dart';
import 'auth_repository.dart';

/// Mock auth: demo credentials from Section 9, artificial latency.
/// No OTP — tapping a demo account signs straight in.
/// Swap for the real API by overriding `authRepositoryProvider`.
class MockAuthRepository implements AuthRepository {
  @override
  Future<AuthResult> demoSignIn(String phone) async {
    await mockDelay();
    throwIfChaos();
    if (phone == MockUsers.blockedPhone) {
      throw const AuthException(AuthFailure.blocked);
    }
    final user = MockUsers.byPhone(phone);
    if (user == null || !user.isActive) {
      throw const AuthException(AuthFailure.invalidPhone);
    }
    return AuthResult(
      user: user,
      token: 'mock-token-${user.id}',
      refreshToken: 'mock-refresh-${user.id}',
    );
  }

  @override
  Future<void> logout() async {
    await mockDelay();
  }
}
