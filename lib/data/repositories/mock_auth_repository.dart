import '../mock/mock_delay.dart';
import '../mock/mock_users.dart';
import 'auth_repository.dart';

/// Mock auth: demo credentials from Section 9, artificial latency.
/// Swap for the real API by overriding `authRepositoryProvider`.
class MockAuthRepository implements AuthRepository {
  @override
  Future<void> sendOtp(String phone) async {
    await mockDelay();
    throwIfChaos();
    if (phone == MockUsers.blockedPhone) {
      throw const AuthException(AuthFailure.blocked);
    }
    if (MockUsers.byPhone(phone) == null) {
      throw const AuthException(AuthFailure.invalidPhone);
    }
  }

  @override
  Future<AuthResult> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    await mockDelay();
    throwIfChaos();
    if (otp == MockUsers.expiredOtp) {
      throw const AuthException(AuthFailure.expiredOtp);
    }
    final user = MockUsers.byPhone(phone);
    if (user == null || !user.isActive) {
      throw const AuthException(AuthFailure.blocked);
    }
    if (otp != MockUsers.demoOtp) {
      throw const AuthException(AuthFailure.wrongOtp);
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
