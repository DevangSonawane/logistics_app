import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/services/pdf_service.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/error_state.dart';
import '../../../data/models/hub.dart';
import '../application/supervisor_providers.dart';

/// V6. LR print: company-format preview with tracking reference,
/// share/print. Bluetooth printer section is feature-flagged off.
class LrPrintPage extends ConsumerWidget {
  const LrPrintPage({super.key});

  // TODO(Phase 8): flip when the Bluetooth printer integration lands.
  static const bool bluetoothEnabled = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.lrPrintTitle,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: context.tokens.surface,
              borderRadius: AppSpacing.cardRadius,
              border: Border.all(color: context.tokens.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shree Ganesh Roadlines Pvt Ltd',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.xs),
                const Text('LORRY RECEIPT · LR-88412'),
                const Divider(height: AppSpacing.xxl),
                const Text('Pune Hub → Chennai Depot'),
                const Text('Vehicle MH12 AB 1234 · Seal SEAL-2091'),
                const SizedBox(height: AppSpacing.md),
                Container(
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.tokens.border),
                    borderRadius: AppSpacing.inputRadius,
                  ),
                  child: const Text('roadops://trip/trip-ramesh-1'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: l10n.sharePdf,
            variant: AppButtonVariant.secondary,
            icon: Icons.share_outlined,
            onPressed: () => ShareService().sharePdf(
              'LR-88412',
              const [
                ('Route', 'Pune Hub - Chennai Depot'),
                ('Vehicle', 'MH12 AB 1234'),
                ('Seal', 'SEAL-2091'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: l10n.printAction,
            icon: Icons.print_outlined,
            onPressed: () async {
              final Uint8List bytes = await PdfService().statement(
                title: 'LR-88412',
                rows: const [
                  ('Route', 'Pune Hub - Chennai Depot'),
                  ('Vehicle', 'MH12 AB 1234'),
                  ('Seal', 'SEAL-2091'),
                ],
              );
              await Printing.layoutPdf(onLayout: (_) async => bytes);
            },
          ),
          if (bluetoothEnabled) ...[
            const SizedBox(height: AppSpacing.md),
            Text(l10n.bluetoothPrinter),
          ] else ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.bluetoothSoon,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.tokens.inkMuted,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Manifest list entry point for the Manifest tab.
class ManifestListPage extends ConsumerWidget {
  const ManifestListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AsyncValue<List<Manifest>> manifests =
        ref.watch(manifestsProvider);
    return AppScaffold(
      title: l10n.manifestTitle,
      body: Column(
        children: [
          Expanded(
            child: manifests.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorState(
                message: l10n.commonError,
                onRetry: () =>
                    ref.invalidate(manifestsProvider),
              ),
              data: (List<Manifest> items) {
                if (items.isEmpty) {
                  return const _ManifestEmpty();
                }
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  itemBuilder: (context, index) {
                    final Manifest m = items[index];
                    return Container(
                      padding:
                          const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: context.tokens.surface,
                        borderRadius: AppSpacing.cardRadius,
                        border: Border.all(
                          color: context.tokens.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${m.id} → ${m.destHub}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                                Text(
                                  '${m.items.length} packages · ${Formatters.dateTime(m.createdAt)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.print_outlined,
                            ),
                            onPressed: () =>
                                context.push('/supervisor/lr'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: l10n.lrPrintTitle,
            variant: AppButtonVariant.secondary,
            icon: Icons.receipt_long_outlined,
            onPressed: () => context.push('/supervisor/lr'),
          ),
        ],
      ),
    );
  }
}

class _ManifestEmpty extends StatelessWidget {
  const _ManifestEmpty();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.list_alt_outlined,
            size: AppSpacing.huge,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.scanToManifest),
        ],
      ),
    );
  }
}
