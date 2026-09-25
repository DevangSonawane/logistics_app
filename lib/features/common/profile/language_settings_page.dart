import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';

/// Language settings: full 8-language list, instant apply.
class LanguageSettingsPage extends ConsumerWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final Locale current = ref.watch(localeControllerProvider);
    final List<(String, String)> options = [
      ('en', l10n.langEnglish),
      ('hi', l10n.langHindi),
      ('mr', l10n.langMarathi),
      ('ta', l10n.langTamil),
      ('te', l10n.langTelugu),
      ('kn', l10n.langKannada),
      ('bn', l10n.langBengali),
      ('pa', l10n.langPunjabi),
    ];
    return AppScaffold(
      title: l10n.languageTitle,
      body: ListView.separated(
        itemCount: options.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final (code, label) = options[index];
          final bool selected = current.languageCode == code;
          return ListTile(
            leading: Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? context.tokens.primary : null,
            ),
            title: Text(label),
            onTap: () => ref
                .read(localeControllerProvider.notifier)
                .setLocale(Locale(code)),
          );
        },
      ),
    );
  }
}
