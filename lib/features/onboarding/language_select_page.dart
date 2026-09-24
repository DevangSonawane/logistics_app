import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/l10n/locale_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_scaffold.dart';
import '../auth/application/session_provider.dart';

/// First-launch language select. Tapping a card switches the UI instantly;
/// Continue persists onboarding and the guard moves to login.
class LanguageSelectPage extends ConsumerWidget {
  const LanguageSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final Locale current = ref.watch(localeControllerProvider);
    final List<({Locale locale, String label})> options = [
      (locale: const Locale('en'), label: l10n.langEnglish),
      (locale: const Locale('hi'), label: l10n.langHindi),
      (locale: const Locale('mr'), label: l10n.langMarathi),
      (locale: const Locale('ta'), label: l10n.langTamil),
      (locale: const Locale('te'), label: l10n.langTelugu),
      (locale: const Locale('kn'), label: l10n.langKannada),
      (locale: const Locale('bn'), label: l10n.langBengali),
      (locale: const Locale('pa'), label: l10n.langPunjabi),
    ];
    return AppScaffold(
      showOfflineBanner: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.languageTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.languageSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.tokens.inkMuted,
                ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.6,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                final bool selected =
                    option.locale.languageCode == current.languageCode;
                return AppCard(
                  onTap: () => ref
                      .read(localeControllerProvider.notifier)
                      .setLocale(option.locale),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Container(
                    decoration: selected
                        ? BoxDecoration(
                            border: Border.all(
                              color: context.tokens.primary,
                              width: 2,
                            ),
                            borderRadius: AppSpacing.cardRadius,
                          )
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          option.label,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Icon(
                          selected
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: selected
                              ? context.tokens.primary
                              : context.tokens.inkFaint,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: l10n.continueAction,
            onPressed: () =>
                ref.read(sessionProvider.notifier).completeOnboarding(),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}
