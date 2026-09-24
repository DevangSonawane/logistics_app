import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/role_labels.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/mock/mock_users.dart';
import '../application/auth_controller.dart';

/// Phone + OTP login. Users are admin-created; no sign-up.
/// Demo builds show a collapsible panel of tappable demo accounts.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _phone = TextEditingController();
  String? _error;
  bool _sending = false;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  Future<void> _getOtp() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String phone = _phone.text.trim();
    if (!Validators.isPhoneValid(phone)) {
      setState(() => _error = l10n.phoneError);
      return;
    }
    setState(() {
      _error = null;
      _sending = true;
    });
    final SendOtpResult result =
        await ref.read(authFlowProvider.notifier).sendOtp(phone);
    if (!mounted) return;
    setState(() => _sending = false);
    switch (result) {
      case SendOtpResult.sent:
        context.go(RouteNames.otp, extra: phone);
      case SendOtpResult.invalidPhone:
        setState(() => _error = l10n.invalidPhone);
      case SendOtpResult.blocked:
        setState(() => _error = l10n.blockedAccount);
      case SendOtpResult.failed:
        setState(() => _error = l10n.commonError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    return AppScaffold(
      showOfflineBanner: false,
      body: ListView(
        children: [
          const SizedBox(height: AppSpacing.xxl),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              gradient: AppColors.heroGradient,
              borderRadius: AppSpacing.cardRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                  size: AppSpacing.xxxl,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.appName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  l10n.splashTagline,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            l10n.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.loginSubtitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: tokens.inkMuted),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            controller: _phone,
            label: l10n.phoneLabel,
            hint: l10n.phoneHint,
            errorText: _error,
            prefixIcon: Icons.phone_outlined,
            phonePrefix: true,
            keyboardType: TextInputType.phone,
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: l10n.getOtp,
            loading: _sending,
            onPressed: _sending ? null : _getOtp,
          ),
          if (AppConfig.demo) ...[
            const SizedBox(height: AppSpacing.xl),
            _DemoAccountsPanel(
              onPick: (phone) => setState(() {
                _phone.text = phone;
                _error = null;
              }),
            ),
          ],
        ],
      ),
    );
  }
}

/// Collapsible demo panel: tappable chips autofill the phone field.
class _DemoAccountsPanel extends StatelessWidget {
  const _DemoAccountsPanel({required this.onPick});

  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          l10n.demoAccounts,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(
          l10n.demoAccountsHint,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final user in MockUsers.users)
                ActionChip(
                  label: Text(
                    '${rolesSummary(l10n, user.roles)} · ${user.name}',
                  ),
                  onPressed: () => onPick(user.phone),
                ),
              ActionChip(
                avatar: const Icon(Icons.block, size: 18),
                label: Text(MockUsers.blockedPhone),
                onPressed: () => onPick(MockUsers.blockedPhone),
              ),
              ActionChip(
                avatar: const Icon(Icons.error_outline, size: 18),
                label: Text(MockUsers.invalidPhone),
                onPressed: () => onPick(MockUsers.invalidPhone),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}
