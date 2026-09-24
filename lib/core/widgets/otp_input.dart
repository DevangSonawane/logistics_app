import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../config/constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// 6-digit OTP input with error shake state.
class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    this.controller,
    this.onCompleted,
    this.hasError = false,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onCompleted;
  final bool hasError;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    final PinTheme base = PinTheme(
      width: AppSpacing.huge,
      height: AppSpacing.huge,
      textStyle: Theme.of(context).textTheme.headlineMedium,
      decoration: BoxDecoration(
        color: tokens.surfaceAlt,
        borderRadius: AppSpacing.inputRadius,
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Pinput(
      controller: controller,
      length: AppConstants.otpLength,
      onCompleted: onCompleted,
      enabled: enabled,
      showCursor: true,
      forceErrorState: hasError,
      defaultPinTheme: base,
      focusedPinTheme: base.copyWith(
        decoration: base.decoration!.copyWith(
          border: Border.all(color: tokens.primary, width: 1.5),
        ),
      ),
      errorPinTheme: base.copyWith(
        decoration: base.decoration!.copyWith(
          border: Border.all(color: AppColors.danger, width: 1.5),
        ),
      ),
    );
  }
}
