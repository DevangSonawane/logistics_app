import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../auth/application/logout_flow.dart';
import '../../auth/application/session_provider.dart';
import '../../driver/application/driver_settings.dart';
import '../../../core/config/app_config.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../core/network/connectivity_provider.dart';
import '../../../core/router/role_labels.dart';
import '../../../core/router/route_names.dart';
import '../../../core/storage/boxes.dart';
import '../../../core/storage/session_store.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/models/app_user.dart';

/// Profile: account summary, language switch, role switcher, app version,
/// demo tools (demo builds only) and logout. Shared by all roles;
/// driver/staff shells point here until their own tabs land.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  /// Loaded once per process: creating it in build would refire the
  /// platform channel on every rebuild.
  static final Future<PackageInfo> _infoFuture = _loadInfo();

  static Future<PackageInfo> _loadInfo() async {
    try {
      return await PackageInfo.fromPlatform();
    } catch (_) {
      return PackageInfo(
        appName: 'RoadOps',
        packageName: AppConfig.packageId,
        version: '1.0.0',
        buildNumber: '1',
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final SessionState session = ref.watch(sessionProvider);
    final AppUser? user = session.user;
    return AppScaffold(
      padding: EdgeInsets.zero,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Avatar(
                    name: user?.name ?? l10n.appName,
                    radius: AppSpacing.xxl,
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          user == null
                              ? ''
                              : '+91 ${user.phone}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Colors.white.withValues(
                                  alpha: 0.85,
                                ),
                              ),
                        ),
                        if (user != null)
                          Container(
                            margin: const EdgeInsets.only(
                              top: AppSpacing.xs,
                            ),
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius:
                                  AppSpacing.chipRadius,
                            ),
                            child: Text(
                              rolesSummary(l10n, user.roles),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              children: [
                _MenuCard(
                  children: [
                    _LanguageRow(),
                    _MenuDivider(),
                    _MenuRow(
                      icon: Icons.settings_outlined,
                      label: l10n.settingsTitle,
                      onTap: () =>
                          context.push(RouteNames.settings),
                    ),
                    if (session.activeRole ==
                        AppRole.driver) ...[
                      _MenuDivider(),
                      const _DriverSettingsSection(),
                    ],
                    _MenuDivider(),
                    FutureBuilder<PackageInfo>(
                      future: _infoFuture,
                      builder: (context, snapshot) {
                        final String version =
                            snapshot.data?.version ?? '1.0.0';
                        return _MenuRow(
                          icon: Icons.info_outline,
                          label: l10n.appVersion(version),
                        );
                      },
                    ),
                  ],
                ),
                if ((user?.roles.length ?? 0) > 1) ...[
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: l10n.switchRole,
                    variant: AppButtonVariant.secondary,
                    icon: Icons.switch_account_outlined,
                    onPressed: () => ref
                        .read(sessionProvider.notifier)
                        .changeRole(),
                  ),
                ],
                if (AppConfig.demo) ...[
                  const SizedBox(height: AppSpacing.lg),
                  SectionHeader(title: l10n.demoTools),
                  const SizedBox(height: AppSpacing.sm),
                  _MenuCard(children: [const _DemoTools()]),
                ],
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: l10n.logoutAction,
                  variant: AppButtonVariant.danger,
                  icon: Icons.logout,
                  onPressed: () => runLogoutFlow(context, ref),
                ),
                // Clearance above the floating nav dock.
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// White card grouping menu rows.
class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.tokens.surface,
        borderRadius: AppSpacing.cardRadius,
        border: Border.all(color: context.tokens.border),
      ),
      child: Column(children: children),
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.tokens.border,
    );
  }
}

/// Tappable menu row with icon + label + chevron.
class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColorTokens tokens = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: tokens.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.chevron_right_outlined,
                color: tokens.inkFaint,
              ),
          ],
        ),
      ),
    );
  }
}

/// Inline language switcher (also changeable on the onboarding screen).
class _LanguageRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final Locale current = ref.watch(localeControllerProvider);
    final Map<String, String> names = {
      'en': l10n.langEnglish,
      'hi': l10n.langHindi,
      'mr': l10n.langMarathi,
      'ta': l10n.langTamil,
      'te': l10n.langTelugu,
      'kn': l10n.langKannada,
      'bn': l10n.langBengali,
      'pa': l10n.langPunjabi,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            Icons.language_outlined,
            size: 20,
            color: tokens.primary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              l10n.languageTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          DropdownButton<String>(
            value: current.languageCode,
            underline: const SizedBox.shrink(),
            dropdownColor: tokens.surface,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: tokens.primary),
            icon: Icon(
              Icons.arrow_drop_down,
              color: tokens.primary,
            ),
            items: [
              for (final entry in names.entries)
                DropdownMenuItem(
                  value: entry.key,
                  child: Text(
                    entry.value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: tokens.ink),
                  ),
                ),
            ],
            onChanged: (code) {
              if (code != null) {
                ref
                    .read(localeControllerProvider.notifier)
                    .setLocale(Locale(code));
              }
            },
          ),
        ],
      ),
    );
  }
}

/// Driver-only settings (D9): voice commands toggle, text size,
/// help & call Ops. Other roles use the shared rows above.
class _DriverSettingsSection extends ConsumerWidget {
  const _DriverSettingsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final DriverSettingsState settings = ref.watch(driverSettingsProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            children: [
              Icon(
                Icons.mic_none_outlined,
                size: 20,
                color: tokens.primary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  l10n.voiceCommandsLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Switch(
                value: settings.voiceEnabled,
                onChanged: (value) => ref
                    .read(driverSettingsProvider.notifier)
                    .setVoiceEnabled(value),
              ),
            ],
          ),
        ),
        const _MenuDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              Icon(
                Icons.text_fields_outlined,
                size: 20,
                color: tokens.primary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  l10n.textSizeLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SegmentedButton<double>(
                style: SegmentedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
                segments: const [
                  ButtonSegment(value: 1.0, label: Text('S')),
                  ButtonSegment(value: 1.15, label: Text('M')),
                  ButtonSegment(value: 1.3, label: Text('L')),
                ],
                selected: {settings.textScale},
                onSelectionChanged: (s) => ref
                    .read(driverSettingsProvider.notifier)
                    .setTextScale(s.first),
              ),
            ],
          ),
        ),
        const _MenuDivider(),
        _MenuRow(
          icon: Icons.support_agent_outlined,
          label: l10n.callOps,
          onTap: () => LaunchHelpers.call('9000000021'),
        ),
      ],
    );
  }
}

/// Demo-only tools. Sync/GPS/notification triggers land with Phase 3.
class _DemoTools extends ConsumerWidget {
  const _DemoTools();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
    final bool simulated = ref.watch(simulatedOfflineProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            children: [
              Icon(
                Icons.wifi_off_outlined,
                size: 20,
                color: tokens.primary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  l10n.simulateOffline,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Switch(
                value: simulated,
                onChanged: (value) => ref
                    .read(simulatedOfflineProvider.notifier)
                    .set(value),
              ),
            ],
          ),
        ),
        const _MenuDivider(),
        _MenuRow(
          icon: Icons.restart_alt_outlined,
          label: l10n.resetDemoData,
          onTap: () async {
            await ref.read(cacheBoxProvider).clear();
            await ref.read(queueBoxProvider).clear();
            await ref.read(gpsTrackBoxProvider).clear();
            await SessionStore(
              box: ref.read(sessionBoxProvider),
            ).clearSession();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.demoActionDone)),
              );
            }
            await ref.read(sessionProvider.notifier).signOut();
          },
        ),
        const _MenuDivider(),
        _MenuRow(
          icon: Icons.notifications_outlined,
          label: l10n.demoSampleNotification,
        ),
        const _MenuDivider(),
        _MenuRow(
          icon: Icons.fast_forward_outlined,
          label: l10n.demoAdvanceTrip,
        ),
      ],
    );
  }
}
