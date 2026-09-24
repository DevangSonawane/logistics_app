import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Confirm dialog returning true when the confirm action is tapped.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.cancelLabel,
    this.dangerous = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String? cancelLabel;
  final bool dangerous;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    String? cancelLabel,
    bool dangerous = false,
  }) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        dangerous: dangerous,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel ?? l10n.cancelAction),
        ),
        dangerous
            ? ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(confirmLabel),
              )
            : TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(confirmLabel),
              ),
      ],
    );
  }
}
