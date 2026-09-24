import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/role_labels.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../data/models/app_user.dart';
import '../application/session_provider.dart';

/// Multi-role picker. Cards per role; the last used role is pre-selected.
class RolePickerPage extends ConsumerStatefulWidget {
  const RolePickerPage({super.key});

  @override
  ConsumerState<RolePickerPage> createState() => _RolePickerPageState();
}

class _RolePickerPageState extends ConsumerState<RolePickerPage> {
  int _selected = 0;
  bool _initialized = false;

  static const Map<AppRole, IconData> _icons = {
    AppRole.driver: Icons.local_shipping_outlined,
    AppRole.owner: Icons.business_outlined,
    AppRole.ops: Icons.hub_outlined,
    AppRole.sales: Icons.trending_up_outlined,
    AppRole.supervisor: Icons.warehouse_outlined,
    AppRole.accountant: Icons.receipt_long_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final SessionState session = ref.watch(sessionProvider);
    final List<AppRole> roles = session.user?.roles ?? const [];
    if (!_initialized && roles.isNotEmpty) {
      final int last = roles.indexOf(session.lastRole ?? roles.first);
      _selected = last >= 0 ? last : 0;
      _initialized = true;
    }
    return AppScaffold(
      showOfflineBanner: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.rolePickerTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.rolePickerSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.tokens.inkMuted,
                ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Expanded(
            child: ListView.separated(
              itemCount: roles.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final AppRole role = roles[index];
                final bool selected = index == _selected;
                final bool lastUsed =
                    role == session.lastRole && session.lastRole != null;
                return AppCard(
                  onTap: () => setState(() => _selected = index),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: (selected
                                  ? context.tokens.primary
                                  : context.tokens.inkFaint)
                              .withValues(alpha: 0.12),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.md),
                        ),
                        child: Icon(
                          _icons[role],
                          color: selected
                              ? context.tokens.primary
                              : context.tokens.inkMuted,
                          size: AppSpacing.xxxl,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              roleLabel(l10n, role),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            if (lastUsed)
                              Text(
                                l10n.lastUsedRole,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: context.tokens.inkMuted,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      Icon(
                        selected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: selected
                            ? context.tokens.primary
                            : context.tokens.inkFaint,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: l10n.roleContinueAs,
            onPressed: roles.isEmpty
                ? null
                : () => ref
                    .read(sessionProvider.notifier)
                    .selectRole(roles[_selected]),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}
