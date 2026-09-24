import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/constants.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/repository_providers.dart';
import 'session_provider.dart';

part 'auth_controller.g.dart';

/// Result of requesting an OTP.
enum SendOtpResult { sent, invalidPhone, blocked, failed }

/// Result of verifying an OTP.
enum VerifyResult { success, wrongOtp, expiredOtp, lockedOut, failed }

/// Which error the OTP field should display.
enum OtpErrorKind { none, wrongOtp, expiredOtp, lockedOut }

/// OTP screen state: attempt counting with a 5-attempt / 5-minute lockout.
class AuthFlowState {
  const AuthFlowState({
    this.attempts = 0,
    this.lockedUntil,
    this.error = OtpErrorKind.none,
  });

  final int attempts;
  final DateTime? lockedUntil;
  final OtpErrorKind error;

  bool get isLocked =>
      lockedUntil != null && DateTime.now().isBefore(lockedUntil!);

  int get attemptsLeft => (AppConstants.otpMaxAttempts - attempts)
      .clamp(0, AppConstants.otpMaxAttempts);

  AuthFlowState copyWith({
    int? attempts,
    DateTime? Function()? lockedUntil,
    OtpErrorKind? error,
  }) {
    return AuthFlowState(
      attempts: attempts ?? this.attempts,
      lockedUntil: lockedUntil != null ? lockedUntil() : this.lockedUntil,
      error: error ?? this.error,
    );
  }
}

/// Orchestrates send/verify OTP. Session mutation (sign-in) happens here;
/// the router guard decides the next screen.
@riverpod
class AuthFlow extends _$AuthFlow {
  @override
  AuthFlowState build() => const AuthFlowState();

  Future<SendOtpResult> sendOtp(String phone) async {
    try {
      await ref.read(authRepositoryProvider).sendOtp(phone);
      return SendOtpResult.sent;
    } on AuthException catch (e) {
      return switch (e.failure) {
        AuthFailure.blocked => SendOtpResult.blocked,
        AuthFailure.invalidPhone => SendOtpResult.invalidPhone,
        _ => SendOtpResult.failed,
      };
    } catch (_) {
      return SendOtpResult.failed;
    }
  }

  Future<VerifyResult> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    if (state.isLocked) return VerifyResult.lockedOut;
    try {
      final AuthResult result = await ref
          .read(authRepositoryProvider)
          .verifyOtp(phone: phone, otp: otp);
      ref.read(sessionProvider.notifier).signIn(result.user);
      state = const AuthFlowState();
      return VerifyResult.success;
    } on AuthException catch (e) {
      return switch (e.failure) {
        AuthFailure.expiredOtp => _registerFailure(OtpErrorKind.expiredOtp),
        AuthFailure.wrongOtp => _registerFailure(OtpErrorKind.wrongOtp),
        _ => VerifyResult.failed,
      };
    } catch (_) {
      return VerifyResult.failed;
    }
  }

  VerifyResult _registerFailure(OtpErrorKind kind) {
    final int nextAttempts = state.attempts + 1;
    if (nextAttempts >= AppConstants.otpMaxAttempts) {
      state = AuthFlowState(
        attempts: nextAttempts,
        lockedUntil: DateTime.now().add(
          const Duration(minutes: AppConstants.otpLockoutMinutes),
        ),
        error: OtpErrorKind.lockedOut,
      );
      return VerifyResult.lockedOut;
    }
    state = state.copyWith(attempts: nextAttempts, error: kind);
    return kind == OtpErrorKind.expiredOtp
        ? VerifyResult.expiredOtp
        : VerifyResult.wrongOtp;
  }

  void clearError() {
    state = state.copyWith(error: OtpErrorKind.none);
  }

  void reset() {
    state = const AuthFlowState();
  }
}
