import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/config/constants.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/biometric_service.dart';
import '../../../core/storage/secure_store.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/otp_input.dart';
import '../../../data/mock/mock_users.dart';
import '../application/session_provider.dart';

/// Staff lock screen after background > 2 min. Unlock with biometrics or
/// the 4-digit app PIN. Demo builds also accept PIN 1234.
class LockPage extends ConsumerStatefulWidget {
  const LockPage({super.key});

  @override
  ConsumerState<LockPage> createState() => _LockPageState();
}

class _LockPageState extends ConsumerState<LockPage> {
  final TextEditingController _pin = TextEditingController();
  bool _working = false;
  bool _pinError = false;

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  Future<void> _submitPin(String code) async {
    if (_working) return;
    setState(() {
      _working = true;
      _pinError = false;
    });
    final String? saved =
        await ref.read(secureStoreProvider).readAppPin();
    final bool ok =
        code == saved || (AppConfig.demo && code == MockUsers.demoPin);
    if (!mounted) return;
    if (ok) {
      ref.read(sessionProvider.notifier).setLocked(false);
      return;
    }
    setState(() {
      _working = false;
      _pinError = true;
    });
    _pin.clear();
  }

  Future<void> _unlockBio() async {
    if (_working) return;
    setState(() => _working = true);
    final bool ok = await BiometricService()
        .authenticate(AppLocalizations.of(context).lockTitle);
    if (!mounted) return;
    if (ok) {
      ref.read(sessionProvider.notifier).setLocked(false);
      return;
    }
    setState(() => _working = false);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final SessionState session = ref.watch(sessionProvider);
    final String name = session.user?.name ?? l10n.appName;
    return AppScaffold(
      showOfflineBanner: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.xxxl),
          Center(child: Avatar(name: name, radius: AppSpacing.xxxl)),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.lockTitle,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '$name · ${l10n.lockSubtitle}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.tokens.inkMuted,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          Center(
            child: OtpInput(
              controller: _pin,
              length: AppConstants.appPinLength,
              onCompleted: _submitPin,
              hasError: _pinError,
              enabled: !_working,
            ),
          ),
          if (_pinError) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.wrongPin,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.danger),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          if (_working)
            const Center(child: CircularProgressIndicator())
          else ...[
            AppButton(
              label: l10n.unlockWithBio,
              variant: AppButtonVariant.secondary,
              icon: Icons.fingerprint,
              onPressed: _unlockBio,
            ),
            if (AppConfig.demo) ...[
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: TextButton(
                  onPressed: () => _submitPin(MockUsers.demoPin),
                  child: Text(l10n.useDemoPin),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
