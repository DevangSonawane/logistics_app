import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/config/app_config.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../auth/application/session_provider.dart';

/// Settings: theme, language, biometric toggle, about. Shared by staff.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final ThemeMode mode = ref.watch(themeModeControllerProvider);
    final Locale locale = ref.watch(localeControllerProvider);
    final bool isStaff = ref.watch(
      sessionProvider.select((s) => s.isStaff),
    );
    String themeLabel(ThemeMode m) {
      return switch (m) {
        ThemeMode.system => l10n.themeSystem,
        ThemeMode.light => l10n.themeLight,
        ThemeMode.dark => l10n.themeDark,
      };
    }

    return AppScaffold(
      title: l10n.settingsTitle,
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.dark_mode_outlined),
            title: Text(l10n.themeLabel),
            trailing: SegmentedButton<ThemeMode>(
              segments: [
                for (final ThemeMode m in ThemeMode.values)
                  ButtonSegment(value: m, label: Text(themeLabel(m))),
              ],
              selected: {mode},
              onSelectionChanged: (s) => ref
                  .read(themeModeControllerProvider.notifier)
                  .setMode(s.first),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.language_outlined),
            title: Text(l10n.languageTitle),
            subtitle: Text(locale.languageCode.toUpperCase()),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () => context.push('/settings/language'),
          ),
          if (isStaff)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.fingerprint_outlined),
              title: Text(l10n.biometricLabel),
              value: true,
              onChanged: (_) {},
            ),
          FutureBuilder<PackageInfo>(
            future: _packageInfo(),
            builder: (context, snapshot) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info_outline),
              title: Text(l10n.aboutLabel),
              subtitle: Text(
                'RoadOps ${snapshot.data?.version ?? '1.0.0'}',
              ),
            ),
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
