import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uuid/uuid.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/network/connectivity_provider.dart';
import '../../../core/offline/offline_action.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/services/image_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/photo_capture_sheet.dart';
import '../../../data/models/hub.dart';

/// V4. PTL scan: continuous scanner, count vs expected, duplicate
/// beep/vibrate, shortage/damage marking with photo. Queues offline.
class ScanPackagesPage extends ConsumerStatefulWidget {
  const ScanPackagesPage({super.key});

  @override
  ConsumerState<ScanPackagesPage> createState() => _ScanPackagesPageState();
}

class _ScanPackagesPageState extends ConsumerState<ScanPackagesPage> {
  final List<ScanItem> _scanned = [];
  final int _expected = 24;
  bool _working = false;

  void _onDetect(BarcodeCapture capture) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    for (final Barcode barcode in capture.barcodes) {
      final String? code = barcode.rawValue;
      if (code == null || code.isEmpty) continue;
      if (_scanned.any((s) => s.code == code)) {
        HapticFeedback.heavyImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.duplicateScan)),
        );
        continue;
      }
      HapticFeedback.selectionClick();
      setState(
        () => _scanned.add(ScanItem(code: code, at: DateTime.now())),
      );
    }
  }

  Future<void> _markIssue(int index, bool damaged) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    String? photo;
    final PhotoSource? source = await PhotoCaptureSheet.show(
      context,
      cameraLabel: l10n.photoCamera,
      galleryLabel: l10n.photoGallery,
    );
    if (source != null && mounted) {
      photo = await ref
          .read(imageServiceProvider)
          .capture(source: source, tag: 'scan-issue');
    }
    if (!mounted) return;
    setState(() {
      _scanned[index] = _scanned[index].copyWith(
        damaged: damaged,
        shortage: !damaged,
        photoPath: photo,
      );
    });
  }

  Future<void> _save() async {
    setState(() => _working = true);
    final OfflineAction action = OfflineAction(
      id: const Uuid().v4(),
      type: OfflineActionType.scanSubmit,
      payload: {
        'count': _scanned.length,
        'codes': [for (final s in _scanned) s.code],
      },
      createdAt: DateTime.now(),
    );
    await ref.read(offlineQueueProvider.notifier).enqueue(action);
    if (!mounted) return;
    setState(() => _working = false);
    final bool online = ref.read(isOnlineProvider);
    if (!online) {
      final AppLocalizations l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.stepQueued)),
      );
    }
    context.push('/supervisor/manifest', extra: List.of(_scanned));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.scanTitle,
      body: Column(
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: AppSpacing.cardRadius,
              border: Border.all(color: context.tokens.border),
            ),
            child: ClipRRect(
              borderRadius: AppSpacing.cardRadius,
              child: MobileScanner(
                onDetect: _onDetect,
                errorBuilder: (context, error) => Center(
                  child: Text(l10n.scannerUnavailable),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${l10n.scannedLabel}: ${_scanned.length} / $_expected',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView.separated(
              itemCount: _scanned.length,
              separatorBuilder: (_, __) => const SizedBox(
                height: AppSpacing.xs,
              ),
              itemBuilder: (context, index) {
                final ScanItem item = _scanned[index];
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.tokens.border),
                    borderRadius: AppSpacing.inputRadius,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.code,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                      ),
                      if (item.damaged || item.shortage)
                        Icon(
                          Icons.warning_amber_outlined,
                          color: AppColors.warning,
                          size: AppSpacing.lg,
                        ),
                      PopupMenuButton<bool>(
                        icon: const Icon(Icons.more_vert_outlined),
                        onSelected: (v) => _markIssue(index, v),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: true,
                            child: Text(l10n.markDamage),
                          ),
                          PopupMenuItem(
                            value: false,
                            child: Text(l10n.markShortage),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: l10n.createManifest,
            variant: AppButtonVariant.accent,
            large: true,
            loading: _working,
            onPressed:
                _working || _scanned.isEmpty ? null : _save,
          ),
        ],
      ),
    );
  }
}
