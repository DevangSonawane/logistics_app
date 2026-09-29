import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/config/app_config.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../auth/application/session_provider.dart';

/// Settings: theme, language, biometric toggle, about. Card rows that
/// fit 360dp screens: the theme switcher gets its own full-width row.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AppColorTokens tokens = context.tokens;
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
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.dark_mode_outlined,
                      color: tokens.primary,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        l10n.themeLabel,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                    style: SegmentedButton.styleFrom(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                      visualDensity: VisualDensity.compact,
                    ),
                    segments: [
                      for (final ThemeMode m in ThemeMode.values)
                        ButtonSegment(
                          value: m,
                          label: Text(themeLabel(m)),
                        ),
                    ],
                    selected: {mode},
                    onSelectionChanged: (s) => ref
                        .read(themeModeControllerProvider.notifier)
                        .setMode(s.first),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppCard(
            onTap: () => context.push('/settings/language'),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.language_outlined,
                  color: tokens.primary,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.languageTitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        locale.languageCode.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: tokens.inkMuted),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_outlined,
                  color: tokens.inkFaint,
                ),
              ],
            ),
          ),
          if (isStaff) ...[
            const SizedBox(height: AppSpacing.md),
            AppCard(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fingerprint_outlined,
                    color: tokens.primary,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      l10n.biometricLabel,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Switch(value: true, onChanged: (_) {}),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          FutureBuilder<PackageInfo>(
            future: _packageInfo(),
            builder: (context, snapshot) => AppCard(
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: tokens.primary,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.aboutLabel,
                          style:
                              Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'RoadOps ${snapshot.data?.version ?? '1.0.0'}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: tokens.inkMuted),
                        ),
                      ],
                    ),
                  ),
                ],
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
