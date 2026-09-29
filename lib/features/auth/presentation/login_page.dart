import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/role_labels.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../data/mock/mock_users.dart';
import '../../../data/models/app_user.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/repository_providers.dart';
import '../application/session_provider.dart';

/// Simple demo sign-in: phone + password form with role pills below that
/// autofill the credentials. No OTP. Users are admin-created; the pills
/// cover every role mode in the app:
///
/// Driver (field, offline-first), Sales, Supervisor, Accountant.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _obscure = true;
  bool _loading = false;
  int? _selectedPill;
  String? _phoneError;
  String? _passwordError;
  String? _formError;

  static const List<_RolePill> _pills = [
    _RolePill(
      role: AppRole.driver,
      icon: Icons.local_shipping_outlined,
      phone: '9000000001',
    ),
    _RolePill(
      role: AppRole.owner,
      icon: Icons.business_outlined,
      phone: '9000000011',
    ),
    _RolePill(role: AppRole.ops, icon: Icons.hub_outlined, phone: '9000000021'),
    _RolePill(
      role: AppRole.sales,
      icon: Icons.trending_up_outlined,
      phone: '9000000031',
    ),
    _RolePill(
      role: AppRole.supervisor,
      icon: Icons.warehouse_outlined,
      phone: '9000000041',
    ),
    _RolePill(
      role: AppRole.accountant,
      icon: Icons.receipt_long_outlined,
      phone: '9000000051',
    ),
  ];

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  void _autofill(int index) {
    final String phone = _pills[index].phone;
    setState(() {
      _selectedPill = index;
      _phone.text = phone;
      _password.text = MockUsers.demoPassword;
      _phoneError = null;
      _passwordError = null;
      _formError = null;
    });
  }

  Future<void> _signIn() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String phone = _phone.text.trim();
    final String password = _password.text;
    setState(() {
      _phoneError = Validators.isPhoneValid(phone) ? null : l10n.phoneError;
      _passwordError = Validators.minLength(password, 4)
          ? null
          : l10n.passwordError;
      _formError = null;
    });
    if (_phoneError != null || _passwordError != null) return;

    setState(() => _loading = true);
    try {
      final AuthResult result = await ref
          .read(authRepositoryProvider)
          .signInWithCredentials(phone: phone, password: password);
      ref.read(sessionProvider.notifier).signIn(result.user);
      // Router guard routes onward (role picker / permissions / home).
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _formError = switch (e.failure) {
          AuthFailure.blocked => l10n.blockedAccount,
          AuthFailure.invalidPhone => l10n.invalidPhone,
          AuthFailure.network => l10n.commonError,
        };
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _formError = l10n.commonError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final String? selectedName = _selectedPill == null
        ? null
        : MockUsers.byPhone(_pills[_selectedPill!].phone)?.name;

    return AppScaffold(
      showOfflineBanner: false,
      padding: EdgeInsets.zero,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.xxl,
              ),
              decoration: BoxDecoration(
                color: tokens.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSheet),
                border: Border.all(color: tokens.surface),
                boxShadow: [
                  BoxShadow(
                    color: tokens.primary.withValues(alpha: 0.22),
                    blurRadius: 30,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.loginTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: tokens.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: tokens.inkMuted),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    key: const Key('loginPhone'),
                    controller: _phone,
                    label: l10n.phoneLabel,
                    hint: l10n.phoneHint,
                    errorText: _phoneError,
                    prefixIcon: Icons.phone_outlined,
                    phonePrefix: true,
                    keyboardType: TextInputType.phone,
                    onChanged: (_) {
                      if (_phoneError != null) {
                        setState(() => _phoneError = null);
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    key: const Key('loginPassword'),
                    controller: _password,
                    label: l10n.passwordLabel,
                    hint: l10n.passwordHint,
                    errorText: _passwordError,
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                    onChanged: (_) {
                      if (_passwordError != null) {
                        setState(() => _passwordError = null);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: AppSpacing.xs,
                          ),
                        ),
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.loginSubtitle)),
                            ),
                        child: Text(
                          l10n.forgotPassword,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 11,
                                color: context.tokens.primary,
                              ),
                        ),
                      ),
                    ),
                  ),
                  if (_formError != null) ...[
                    Text(
                      _formError!,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.danger),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  _SignInButton(
                    label: l10n.signInAction,
                    loading: _loading,
                    onPressed: _loading ? null : _signIn,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.quickSignInHint,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: tokens.inkFaint),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (int i = 0; i < _pills.length; i++)
                        _Pill(
                          label: roleLabel(l10n, _pills[i].role),
                          icon: _pills[i].icon,
                          selected: _selectedPill == i,
                          onTap: () => _autofill(i),
                        ),
                    ],
                  ),
                  if (selectedName != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '$selectedName · +91 ${_phone.text}',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: tokens.inkMuted),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RolePill {
  const _RolePill({
    required this.role,
    required this.icon,
    required this.phone,
  });

  final AppRole role;
  final IconData icon;
  final String phone;
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppSpacing.motionFast,
        curve: AppSpacing.motionCurve,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? tokens.primary
              : tokens.primary.withValues(alpha: 0.08),
          borderRadius: AppSpacing.chipRadius,
          border: Border.all(
            color: selected
                ? tokens.primary
                : tokens.primary.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? tokens.onPrimary : tokens.primary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: selected ? tokens.onPrimary : tokens.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Full-width gradient submit button (Uiverse-style): purple gradient,
/// white bold label, spinner while signing in.
class _SignInButton extends StatelessWidget {
  const _SignInButton({
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      key: const Key('signInSubmit'),
      onTap: onPressed,
      child: Container(
        height: AppSpacing.buttonHeightMd,
        decoration: BoxDecoration(
          gradient: onPressed == null
              ? null
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
          color: onPressed == null ? tokens.surfaceAlt : null,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          boxShadow: onPressed == null
              ? null
              : [
                  BoxShadow(
                    color: tokens.primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: loading
            ? const SizedBox(
                width: AppSpacing.xl,
                height: AppSpacing.xl,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
