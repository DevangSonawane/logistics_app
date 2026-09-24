import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
import '../../../core/storage/hive_boxes.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final SessionState session = ref.watch(sessionProvider);
    final AppUser? user = session.user;
    return AppScaffold(
      title: l10n.profileTitle,
      body: ListView(
        children: [
          Row(
            children: [
              Avatar(
                name: user?.name ?? l10n.appName,
                radius: AppSpacing.xxl,
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      user == null ? '' : '+91 ${user.phone}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: context.tokens.inkMuted,
                          ),
                    ),
                    if (user != null)
                      Text(
                        rolesSummary(l10n, user.roles),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _LanguageRow(),
          const SizedBox(height: AppSpacing.sm),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.settings_outlined),
            title: Text(l10n.settingsTitle),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () => context.push(RouteNames.settings),
          ),
          if (session.activeRole == AppRole.driver) ...[
            const _DriverSettingsSection(),
            const SizedBox(height: AppSpacing.sm),
          ],
          FutureBuilder<PackageInfo>(
            future: _packageInfo(),
            builder: (context, snapshot) {
              final String version = snapshot.data?.version ?? '1.0.0';
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.appVersion(version)),
              );
            },
          ),
          if ((user?.roles.length ?? 0) > 1) ...[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: l10n.switchRole,
              variant: AppButtonVariant.secondary,
              icon: Icons.switch_account_outlined,
              onPressed: () =>
                  ref.read(sessionProvider.notifier).changeRole(),
            ),
          ],
          if (AppConfig.demo) ...[
            const SizedBox(height: AppSpacing.xl),
            SectionHeader(title: l10n.demoTools),
            const SizedBox(height: AppSpacing.sm),
            _DemoTools(),
          ],
          const SizedBox(height: AppSpacing.xxl),
          AppButton(
            label: l10n.logoutAction,
            variant: AppButtonVariant.danger,
            icon: Icons.logout,
            onPressed: () => runLogoutFlow(context, ref),
          ),
        ],
      ),
    );
  }

  Future<PackageInfo> _packageInfo() async {
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
}

/// Inline language switcher (also changeable on the onboarding screen).
class _LanguageRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.language_outlined),
      title: Text(l10n.languageTitle),
      trailing: DropdownButton<String>(
        value: current.languageCode,
        underline: const SizedBox.shrink(),
        items: [
          for (final entry in names.entries)
            DropdownMenuItem(value: entry.key, child: Text(entry.value)),
        ],
        onChanged: (code) {
          if (code != null) {
            ref
                .read(localeControllerProvider.notifier)
                .setLocale(Locale(code));
          }
        },
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
    final DriverSettingsState settings = ref.watch(driverSettingsProvider);
    return Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.voiceCommandsLabel),
          value: settings.voiceEnabled,
          onChanged: (value) => ref
              .read(driverSettingsProvider.notifier)
              .setVoiceEnabled(value),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.text_fields_outlined),
          title: Text(l10n.textSizeLabel),
          trailing: SegmentedButton<double>(
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
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.support_agent_outlined),
          title: Text(l10n.callOps),
          trailing: const Icon(Icons.phone_outlined),
          onTap: () => LaunchHelpers.call('9000000021'),
        ),
      ],
    );
  }
}

/// Demo-only tools. Sync/GPS/notification triggers land with Phase 3.
class _DemoTools extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final bool simulated = ref.watch(simulatedOfflineProvider);
    return Column(
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.simulateOffline),
          value: simulated,
          onChanged: (value) =>
              ref.read(simulatedOfflineProvider.notifier).set(value),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.restart_alt_outlined),
          title: Text(l10n.resetDemoData),
          onTap: () async {
            for (final String box in [
              HiveBoxes.cache,
              HiveBoxes.offlineQueue,
              HiveBoxes.gpsTrack,
            ]) {
              await Hive.box(box).clear();
            }
            await SessionStore().clearSession();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.demoActionDone)),
              );
            }
            await ref.read(sessionProvider.notifier).signOut();
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.notifications_outlined),
          title: Text(l10n.demoSampleNotification),
          subtitle: Text(l10n.phaseComingSoon('Phase 3')),
          onTap: () {},
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.fast_forward_outlined),
          title: Text(l10n.demoAdvanceTrip),
          subtitle: Text(l10n.phaseComingSoon('Phase 3')),
          onTap: () {},
        ),
      ],
    );
  }
}
