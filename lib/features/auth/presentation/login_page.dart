import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/role_labels.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/avatar.dart';
import '../../../data/mock/mock_users.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/session_provider.dart';

/// Demo sign-in, no OTP: pick an account card and go straight in.
/// Users are admin-created; this page lists the demo seed.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String? _error;
  String? _signingInPhone;

  Future<void> _signIn(String phone) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    setState(() {
      _error = null;
      _signingInPhone = phone;
    });
    try {
      final AuthResult result =
          await ref.read(authRepositoryProvider).demoSignIn(phone);
      ref.read(sessionProvider.notifier).signIn(result.user);
      // Router guard routes onward (role picker / permissions / home).
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _signingInPhone = null;
        _error = switch (e.failure) {
          AuthFailure.blocked => l10n.blockedAccount,
          AuthFailure.invalidPhone => l10n.invalidPhone,
          AuthFailure.network => l10n.commonError,
        };
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _signingInPhone = null;
        _error = l10n.commonError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      showOfflineBanner: false,
      body: ListView(
        children: [
          const SizedBox(height: AppSpacing.xl),
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
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.demoAccountsHint,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.tokens.inkMuted,
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
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          for (final user in MockUsers.users)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                onTap: _signingInPhone != null
                    ? null
                    : () => _signIn(user.phone),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Avatar(name: user.name),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                          Text(
                            '${rolesSummary(l10n, user.roles)} · +91 ${user.phone}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      context.tokens.inkMuted,
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (_signingInPhone == user.phone)
                      const SizedBox(
                        width: AppSpacing.xl,
                        height: AppSpacing.xl,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      )
                    else
                      const Icon(Icons.chevron_right_outlined),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
