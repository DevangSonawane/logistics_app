import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../application/owner_settings.dart';

/// O6. Notification settings: per alert type (payment, delay, doc, credit)
/// toggles for push / WhatsApp / in-app channels.
class NotificationSettingsPage extends ConsumerWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    ref.watch(alertSettingsProvider);
    final AlertSettings settings =
        ref.read(alertSettingsProvider.notifier);
    String alertLabel(String alert) {
      return switch (alert) {
        'pay' => l10n.alertPay,
        'delay' => l10n.alertDelay,
        'doc' => l10n.alertDoc,
        'credit' => l10n.alertCredit,
        _ => alert,
      };
    }

    String channelLabel(String channel) {
      return switch (channel) {
        'push' => l10n.channelPush,
        'wa' => l10n.channelWa,
        'app' => l10n.channelApp,
        _ => channel,
      };
    }

    return AppScaffold(
      title: l10n.alertSettingsTitle,
      body: ListView(
        children: [
          for (final String alert in AlertSettings.alerts) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.xs,
              ),
              child: Text(
                alertLabel(alert),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            for (final String channel in AlertSettings.channels)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(channelLabel(channel)),
                value: settings.enabled(alert, channel),
                onChanged: (v) =>
                    settings.set(alert, channel, v),
              ),
          ],
        ],
      ),
    );
  }
}
