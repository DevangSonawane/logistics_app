import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/pdf_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../auth/application/session_provider.dart';
import '../../../data/models/driver.dart';

/// Salary-slip PDF preview (generated locally, shared/saved via printing).
class PayslipPage extends ConsumerWidget {
  const PayslipPage({super.key, required this.slip});

  final SalarySlip slip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String name =
        ref.watch(sessionProvider.select((s) => s.user?.name ?? ''));
    return AppScaffold(
      title: l10n.slipsTitle,
      padding: EdgeInsets.zero,
      body: FutureBuilder<Uint8List>(
        future: PdfService().payslip(driverName: name, slip: slip),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorState(message: l10n.commonError);
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return PdfPreview(
            build: (_) async => snapshot.data!,
            padding: const EdgeInsets.all(AppSpacing.lg),
          );
        },
      ),
    );
  }
}
