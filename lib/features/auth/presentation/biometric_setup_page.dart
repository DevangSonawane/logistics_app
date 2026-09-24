import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/constants.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/biometric_service.dart';
import '../../../core/storage/secure_store.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/otp_input.dart';
import '../application/session_provider.dart';

/// Staff-only app lock setup: fingerprint/face, or a 4-digit app PIN.
/// Drivers skip this step (the guard never sends them here).
class BiometricSetupPage extends ConsumerStatefulWidget {
  const BiometricSetupPage({super.key});

  @override
  ConsumerState<BiometricSetupPage> createState() =>
      _BiometricSetupPageState();
}

class _BiometricSetupPageState extends ConsumerState<BiometricSetupPage> {
  bool _pinMode = false;
  String? _firstPin;
  bool _working = false;
  String? _error;

  final TextEditingController _pin = TextEditingController();

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  Future<void> _enableBiometrics() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    setState(() {
      _working = true;
      _error = null;
    });
    final bool ok =
        await BiometricService().authenticate(l10n.biometricTitle);
    if (!mounted) return;
    setState(() => _working = false);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.biometricEnrolled)),
      );
      ref.read(sessionProvider.notifier).completeBiometric();
    } else {
      setState(() => _pinMode = true);
    }
  }

  Future<void> _submitPin(String code) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (_firstPin == null) {
      setState(() {
        _firstPin = code;
        _error = null;
      });
      _pin.clear();
      return;
    }
    if (code != _firstPin) {
      setState(() {
        _firstPin = null;
        _error = l10n.appPinMismatch;
      });
      _pin.clear();
      return;
    }
    setState(() => _working = true);
    await ref.read(secureStoreProvider).saveAppPin(code);
    if (!mounted) return;
    setState(() => _working = false);
    ref.read(sessionProvider.notifier).completeBiometric();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      showOfflineBanner: false,
      body: _pinMode ? _pinStep(l10n) : _choiceStep(l10n),
    );
  }

  Widget _choiceStep(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.xl),
        const Icon(
          Icons.fingerprint,
          size: AppSpacing.huge,
          color: AppColors.primary,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.biometricTitle,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.biometricSubtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: context.tokens.inkMuted,
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        AppButton(
          label: l10n.biometricEnable,
          loading: _working,
          onPressed: _working ? null : _enableBiometrics,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: l10n.biometricSkip,
          variant: AppButtonVariant.text,
          onPressed: () => setState(() {
            _pinMode = true;
            _error = null;
          }),
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }

  Widget _pinStep(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.xl),
        Text(
          _firstPin == null ? l10n.appPinTitle : l10n.appPinConfirmTitle,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxl),
        Center(
          child: OtpInput(
            controller: _pin,
            length: AppConstants.appPinLength,
            onCompleted: _submitPin,
            enabled: !_working,
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            _error!,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.danger),
            textAlign: TextAlign.center,
          ),
        ],
        if (_working) ...[
          const SizedBox(height: AppSpacing.xl),
          const Center(child: CircularProgressIndicator()),
        ],
      ],
    );
  }
}
