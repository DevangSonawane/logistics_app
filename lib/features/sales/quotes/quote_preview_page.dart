import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/pdf_service.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/launch_helpers.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../../data/models/approval.dart';

/// Branded quote PDF preview + send via WhatsApp. Under-floor rates raise
/// a rate approval instead of sending.
class QuotePreviewPage extends ConsumerStatefulWidget {
  const QuotePreviewPage({super.key, required this.args});

  final Map<String, dynamic> args;

  @override
  ConsumerState<QuotePreviewPage> createState() => _QuotePreviewPageState();
}

class _QuotePreviewPageState extends ConsumerState<QuotePreviewPage> {
  bool _working = false;

  int get _rate => widget.args['rate'] as int? ?? 0;
  Map<String, int> get _charges =>
      Map<String, int>.from(widget.args['charges'] as Map? ?? {});
  int get _total => _rate + _charges.values.fold(0, (a, b) => a + b);

  Future<Uint8List?> _bytes() async {
    try {
      return await PdfService().quote(
        lane: '${widget.args['from']} - ${widget.args['to']}',
        vehicle: '${widget.args['vehicle']}',
        rate: _rate,
        charges: _charges,
        total: _total,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _send() async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    setState(() => _working = true);
    final int? contract = await ref
        .read(dashboardRepositoryProvider)
        .contractRate(
          '${widget.args['from']}',
          '${widget.args['to']}',
          '${widget.args['vehicle']}',
        );
    if (!mounted) return;
    if (contract != null && _rate < contract) {
      await ref.read(approvalRepositoryProvider).create(
            type: ApprovalType.rate,
            requester: 'Sales',
            amount: _rate,
            reason:
                'Below-floor quote ${widget.args['from']}-${widget.args['to']}',
          );
      if (!mounted) return;
      setState(() => _working = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.needsApproval)),
      );
      return;
    }
    setState(() => _working = false);
    await ShareService().sharePdf(
      'Quote ${widget.args['from']}-${widget.args['to']}',
      [
        ('Rate', Formatters.inr(_rate)),
        for (final e in _charges.entries) (e.key, Formatters.inr(e.value)),
        ('Total', Formatters.inr(_total)),
      ],
    );
    await LaunchHelpers.whatsappShare(
      'RoadOps quote ${widget.args['from']}-${widget.args['to']}: '
      '${Formatters.inr(_total)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.quoteTitle,
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Uint8List?>(
              future: _bytes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return ErrorState(message: l10n.commonError);
                }
                return PdfPreview(
                  build: (_) async => snapshot.data!,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: AppButton(
              label: l10n.sendWhatsapp,
              variant: AppButtonVariant.accent,
              large: true,
              loading: _working,
              icon: Icons.share_outlined,
              onPressed: _working ? null : _send,
            ),
          ),
        ],
      ),
    );
  }
}
