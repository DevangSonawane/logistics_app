import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';

/// Shared PDF viewer: zoom, share and save via the printing sheet.
/// Callers pass rendered bytes through the route extra.
class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({
    super.key,
    required this.title,
    required this.bytes,
  });

  final String title;
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    if (bytes.isEmpty) {
      return AppScaffold(
        title: title,
        body: ErrorState(message: l10n.commonError),
      );
    }
    return AppScaffold(
      title: title,
      padding: EdgeInsets.zero,
      body: PdfPreview(
        build: (_) async => bytes,
        padding: const EdgeInsets.all(AppSpacing.lg),
      ),
    );
  }
}
