import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/otp_input.dart';
import '../application/auth_controller.dart';

/// 6-digit OTP: auto-submit on completion, 30 s resend timer, 5-attempt
/// lockout (5 min), error shake. Success signs in; the guard routes onward.
class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key, required this.phone});

  final String phone;

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final TextEditingController _otp = TextEditingController();
  final GlobalKey<_ShakeState> _shakeKey = GlobalKey<_ShakeState>();
  Timer? _resendTimer;
  int _resendLeft = AppConstants.otpResendSeconds;
  bool _verifying = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _otp.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _resendLeft = AppConstants.otpResendSeconds);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_resendLeft <= 1) {
        timer.cancel();
        setState(() => _resendLeft = 0);
      } else {
        setState(() => _resendLeft--);
      }
    });
  }

  Future<void> _resend() async {
    if (_resendLeft > 0) return;
    final SendOtpResult result =
        await ref.read(authFlowProvider.notifier).sendOtp(widget.phone);
    if (!mounted) return;
    if (result == SendOtpResult.sent) {
      _otp.clear();
      ref.read(authFlowProvider.notifier).clearError();
      setState(() => _message = null);
      _startResendTimer();
    } else {
      setState(
        () => _message = AppLocalizations.of(context).commonError,
      );
    }
  }

  Future<void> _verify(String code) async {
    if (_verifying) return;
    setState(() {
      _verifying = true;
      _message = null;
    });
    final VerifyResult result = await ref
        .read(authFlowProvider.notifier)
        .verifyOtp(phone: widget.phone, otp: code);
    if (!mounted) return;
    final AppLocalizations l10n = AppLocalizations.of(context);
    switch (result) {
      case VerifyResult.success:
        // Router guard reacts to the sign-in; nothing to do here.
        return;
      case VerifyResult.wrongOtp:
        _shakeKey.currentState?.shake();
        _otp.clear();
        setState(() {
          _verifying = false;
          _message = l10n.otpError;
        });
      case VerifyResult.expiredOtp:
        _shakeKey.currentState?.shake();
        _otp.clear();
        setState(() {
          _verifying = false;
          _message = l10n.otpExpired;
        });
      case VerifyResult.lockedOut:
      case VerifyResult.failed:
        setState(() => _verifying = false);
    }
  }

  void _backToLogin() {
    ref.read(authFlowProvider.notifier).reset();
    context.go(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final AuthFlowState flow = ref.watch(authFlowProvider);

    if (widget.phone.isEmpty) {
      return AppScaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.commonError),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: l10n.otpBackToLogin,
                onPressed: _backToLogin,
              ),
            ],
          ),
        ),
      );
    }

    final bool locked = flow.isLocked;
    final String? errorText = locked
        ? l10n.otpLockout(AppConstants.otpLockoutMinutes)
        : _message;

    return AppScaffold(
      showOfflineBanner: false,
      body: ListView(
        children: [
          const SizedBox(height: AppSpacing.xxl),
          Text(
            l10n.otpTitle(widget.phone),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.otpSubtitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: tokens.inkMuted),
          ),
          const SizedBox(height: AppSpacing.xxl),
          _Shake(
            key: _shakeKey,
            child: OtpInput(
              controller: _otp,
              onCompleted: _verify,
              hasError: flow.error != OtpErrorKind.none && !locked,
              enabled: !_verifying && !locked,
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              errorText,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.danger),
              textAlign: TextAlign.center,
            ),
          ],
          if (!locked && flow.attempts > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.otpAttemptsLeft(flow.attemptsLeft),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: tokens.inkMuted),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: AppSpacing.xxl),
          if (_verifying)
            const Center(child: CircularProgressIndicator())
          else
            Center(
              child: TextButton(
                onPressed: _resendLeft > 0 ? null : _resend,
                child: Text(
                  _resendLeft > 0
                      ? l10n.otpResendIn(_resendLeft)
                      : l10n.otpResend,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: TextButton(
              onPressed: _backToLogin,
              child: Text(l10n.otpBackToLogin),
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal shake wrapper triggered via [shake].
class _Shake extends StatefulWidget {
  const _Shake({super.key, required this.child});

  final Widget child;

  @override
  State<_Shake> createState() => _ShakeState();
}

class _ShakeState extends State<_Shake> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );

  void shake() => _controller.forward(from: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final double t = _controller.value;
        final double dx =
            math.sin(t * math.pi * 4) * AppSpacing.sm * (1 - t);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: widget.child,
    );
  }
}
