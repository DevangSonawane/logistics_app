import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/offline/sync_engine.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../data/models/app_user.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../driver/application/gps_controller.dart';
import 'session_provider.dart';

/// Shared logout flow (Section 6.3): confirm, driver blockers, sign out.
///
/// Driver blockers:
/// - running trip -> hard block with the "complete or ask Ops" message.
/// - unsynced items -> block with Sync now / View queue; demo builds also
///   offer "Force logout".
/// Used by the role shell (Phase 2) and the profile page.
Future<void> runLogoutFlow(BuildContext context, WidgetRef ref) async {
  final AppLocalizations l10n = AppLocalizations.of(context);
  final bool confirmed = await ConfirmDialog.show(
    context,
    title: l10n.logoutTitle,
    message: l10n.logoutMessage,
    confirmLabel: l10n.logoutAction,
  );
  if (!confirmed || !context.mounted) return;

  final SessionState session = ref.read(sessionProvider);
  if (session.activeRole == AppRole.driver && session.user != null) {
    final bool hasTrip = await ref
        .read(tripRepositoryProvider)
        .hasActiveTrip(session.user!.id);
    if (!context.mounted) return;
    if (hasTrip) {
      await _showBlocker(context, message: l10n.logoutRunningTrip);
      return;
    }
    final int pending = ref.read(pendingSyncCountProvider);
    if (pending > 0) {
      await _showUnsyncedBlocker(context, ref, count: pending);
      return;
    }
  }
  await _finishLogout(ref);
}

/// Stops trip tracking (no-op when idle) then signs out. The GPS stop is
/// fire-and-forget with its own timeout so logout never blocks on it.
Future<void> _finishLogout(WidgetRef ref) async {
  unawaited(ref.read(gpsTrackerProvider.notifier).stop());
  await ref.read(sessionProvider.notifier).signOut();
}

Future<void> _showBlocker(
  BuildContext context, {
  required String message,
}) {
  final AppLocalizations l10n = AppLocalizations.of(context);
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.logoutTitle),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancelAction),
        ),
      ],
    ),
  );
}

Future<void> _showUnsyncedBlocker(
  BuildContext context,
  WidgetRef ref, {
  required int count,
}) {
  final AppLocalizations l10n = AppLocalizations.of(context);
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.logoutTitle),
      content: Text(l10n.logoutPendingSync(count)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(l10n.cancelAction),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(dialogContext).pop();
            await ref.read(syncControllerProvider.notifier).syncNow();
            if (!context.mounted) return;
            if (ref.read(pendingSyncCountProvider) == 0) {
              await ref.read(sessionProvider.notifier).signOut();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.logoutPendingSync(
                      ref.read(pendingSyncCountProvider),
                    ),
                  ),
                ),
              );
            }
          },
          child: Text(l10n.syncNow),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.phaseComingSoon('Phase 3'))),
            );
          },
          child: Text(l10n.viewQueue),
        ),
        if (AppConfig.demo)
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await _finishLogout(ref);
            },
            child: Text(l10n.forceLogout),
          ),
      ],
    ),
  );
}
